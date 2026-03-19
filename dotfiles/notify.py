#!/usr/bin/env python3

from __future__ import annotations

import json
import os
import shutil
import subprocess
import sys
import time
from typing import Any


def _log(message: str) -> None:
    log_path = (os.environ.get("NOTIFY_LOG_PATH") or "").strip()
    if not log_path:
        return
    try:
        ts = time.strftime("%Y-%m-%d %H:%M:%S")
        with open(log_path, "a", encoding="utf-8") as f:
            f.write(f"[{ts}] {message}\n")
    except Exception:
        return


def _short_path(path: str) -> str:
    path = path.strip()
    if not path:
        return path
    home = os.path.expanduser("~")
    if path == home:
        return "~"
    prefix = home + os.sep
    if path.startswith(prefix):
        return "~" + os.sep + path[len(prefix) :]
    return path


def _collapse_whitespace(text: str) -> str:
    return " ".join(text.split())


def _truncate(text: str, max_len: int) -> str:
    if max_len <= 0:
        return ""
    if len(text) <= max_len:
        return text
    return text[: max_len - 1] + "…"


def _have_cmd(cmd: str) -> bool:
    return shutil.which(cmd) is not None


def _run(cmd: list[str], timeout_s: float = 2.0) -> tuple[int, str, str]:
    try:
        completed = subprocess.run(
            cmd,
            check=False,
            capture_output=True,
            text=True,
            timeout=timeout_s,
        )
        return completed.returncode, completed.stdout.strip(), completed.stderr.strip()
    except Exception as e:
        return 1, "", str(e)


def _tmux_context() -> str | None:
    if not os.environ.get("TMUX"):
        return None
    if not _have_cmd("tmux"):
        return None

    pane = os.environ.get("TMUX_PANE", "").strip()
    target = ["-t", pane] if pane else []
    fmt = "#{session_name} - #{window_name}"
    rc, out, err = _run(["tmux", "display-message", "-p", *target, fmt])
    if rc == 0 and out:
        return out

    _log(f"tmux context unavailable: rc={rc} err={err!r}")
    return pane or "tmux"


def _notify_osascript(title: str, message: str) -> bool:
    if sys.platform != "darwin":
        return False
    if not _have_cmd("osascript"):
        return False

    applescript = r"""
on run argv
  set theTitle to item 1 of argv
  set theMessage to item 2 of argv
  display notification theMessage with title theTitle
end run
""".strip()

    rc, out, err = _run(["osascript", "-e", applescript, title, message], timeout_s=3.0)
    if rc == 0:
        return True
    _log(f"osascript failed: rc={rc} out={out!r} err={err!r}")
    return False


def _notify_linux(title: str, message: str) -> bool:
    if sys.platform == "darwin":
        return False
    if not _have_cmd("notify-send"):
        return False
    rc, out, err = _run(["notify-send", title, message], timeout_s=3.0)
    if rc == 0:
        return True
    _log(f"notify-send failed: rc={rc} out={out!r} err={err!r}")
    return False


def _read_raw(argv: list[str]) -> str | None:
    if len(argv) >= 2 and argv[1].strip():
        return argv[1]
    if sys.stdin.isatty():
        return None
    raw = sys.stdin.read()
    return raw.strip() if raw else None


def _parse_payload(raw: str) -> dict[str, Any]:
    try:
        obj = json.loads(raw)
    except Exception:
        return {"type": "message", "message": raw}

    if isinstance(obj, dict):
        return obj

    if isinstance(obj, list):
        return {"type": "message", "message": " ".join(map(str, obj))}

    return {"type": "message", "message": str(obj)}


def _pick_title(payload: dict[str, Any]) -> str:
    title_override = (os.environ.get("NOTIFY_TITLE") or "").strip()
    if title_override:
        return title_override

    if isinstance(payload.get("title"), str) and payload["title"].strip():
        return payload["title"].strip()

    app = (os.environ.get("NOTIFY_APP") or "").strip()
    if not app:
        for key in ("app", "source", "client", "program", "tool"):
            value = payload.get(key)
            if isinstance(value, str) and value.strip():
                app = value.strip()
                break

    event_type = payload.get("type")
    event = event_type.strip() if isinstance(event_type, str) and event_type.strip() else "notification"
    return f"{app}: {event}" if app else event


def _pick_message(payload: dict[str, Any]) -> str:
    for key in (
        "message",
        "text",
        "last-assistant-message",
        "summary",
        "status",
        "output",
    ):
        value = payload.get(key)
        if isinstance(value, str) and value.strip():
            return value.strip()

    value = payload.get("input-messages")
    if isinstance(value, list) and value:
        msg = " ".join(str(v) for v in value if v is not None).strip()
        if msg:
            return msg

    # As a last resort, emit a compact JSON-ish string.
    try:
        return json.dumps(payload, ensure_ascii=False, sort_keys=True)
    except Exception:
        return str(payload)


def main(argv: list[str]) -> int:
    raw = _read_raw(argv)
    if not raw:
        return 0

    payload = _parse_payload(raw)

    title = _pick_title(payload)
    message = _truncate(_collapse_whitespace(_pick_message(payload)), 220) or "Notification."

    cwd_raw = payload.get("cwd")
    cwd = str(cwd_raw).strip() if cwd_raw else (os.environ.get("PWD") or "").strip()
    tmux_ctx = _tmux_context()

    context_parts: list[str] = []
    if tmux_ctx:
        context_parts.append(f"tmux {tmux_ctx}")
    if cwd:
        context_parts.append(_short_path(cwd))
    context = " · ".join(context_parts)

    body = f"{context}\n{message}" if context else message
    _log(f"received: title={title!r} cwd={cwd!r} tmux={tmux_ctx!r}")

    if _notify_osascript(title=title, message=body):
        _log("notified via osascript")
        return 0
    if _notify_linux(title=title, message=body):
        _log("notified via notify-send")
        return 0

    _log("no notifier available; falling back to stderr")
    try:
        sys.stderr.write(f"{title}: {body}\n")
    except Exception:
        pass
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
