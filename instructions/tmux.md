# Tmux Notes
###### tags: `notes` `study`

## Installation
```bash
$ brew install tmux
$ brew install reattach-to-user-namespace --with-wrap-pbcopy-and-pbpaste
```

## Commands
start new:
`tmux`

start new with session name:
`tmux new -s myname`

list sessions:
`tmux ls`

## Operations
ctrl + b, then

### Windows
```
c  create window
w  list windows
n  next window
p  previous window
f  find window
,  name window
&  kill window
```

### Panes
```
%  vertical split
"  horizontal split

o  swap panes
q  show pane numbers
x  kill pane
+  break pane into window (e.g. to select text by mouse to copy)
-  restore pane from window
<space>  toggle between layouts
{ (Move the current pane left)
} (Move the current pane right)
z toggle pane zoom</prefix>"
```

### Misc
```
d  detach
t  big clock
?  list shortcuts
:  prompt
!  break the current pane out of its window (to form new window)
~  show previous messages from tmux, if any
```
[tmux man page](https://www.mankier.com/1/tmux)
