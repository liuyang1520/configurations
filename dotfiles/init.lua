vim.g.mapleader = ","

-- Options and filetype behavior must be configured before plugins. Some plugin
-- managers trigger FileType while the startup buffer is still being opened.
vim.opt.clipboard = "unnamedplus"
vim.opt.shortmess:append("mro")
vim.opt.viewoptions = { "folds", "options", "cursor" }
vim.opt.updatetime = 1000
vim.opt.expandtab = true
vim.opt.backup = true
vim.opt.undofile = true
vim.opt.showmode = false
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.showmatch = true
vim.opt.inccommand = "split"
vim.opt.winminheight = 0
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildmode = { "list:longest", "full" }
vim.opt.whichwrap:append("h,l,<,>,[,]")
vim.opt.scrolljump = 5
vim.opt.scrolloff = 3
vim.opt.foldlevel = 3
vim.opt.list = true
vim.opt.listchars = {
  tab = "› ",
  trail = "•",
  extends = "#",
  nbsp = ".",
}
vim.opt.wrap = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = -1 -- Follow 'shiftwidth'.
vim.opt.splitright = true
vim.opt.splitbelow = true

local backup_dir = vim.fn.stdpath("state") .. "/backup"
vim.fn.mkdir(backup_dir, "p")
vim.opt.backupdir = backup_dir .. "//"

local config_group = vim.api.nvim_create_augroup("user-config", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  desc = "Use bundled Tree-sitter parsers",
  group = config_group,
  pattern = { "c", "help", "lua", "query", "vim" },
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Do not continue comments automatically",
  group = config_group,
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = config_group,
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

local function use_two_space_indent()
  vim.opt_local.tabstop = 2
  vim.opt_local.shiftwidth = 2
end

vim.api.nvim_create_autocmd("FileType", {
  desc = "Use two-space indentation",
  group = config_group,
  pattern = {
    "css",
    "eruby",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "lua",
    "prisma",
    "ruby",
    "scss",
    "terraform",
    "terraform-vars",
    "tf",
    "typescript",
    "typescriptreact",
    "vue",
    "yaml",
  },
  callback = use_two_space_indent,
})

-- These legacy template extensions are not detected by Neovim itself.
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  desc = "Use two-space indentation for template files",
  group = config_group,
  pattern = { "*.coffee", "*.eco", "*.ejs", "*.jst" },
  callback = use_two_space_indent,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Wrap Markdown buffers",
  group = config_group,
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
  end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath })
end
vim.opt.rtp:prepend(lazypath)

local init_source = debug.getinfo(1, "S").source:sub(2)
local config_dir = vim.fs.dirname(assert(vim.uv.fs_realpath(init_source)))
local lazy_lockfile = vim.fs.joinpath(config_dir, "lazy-lock.json")
local fzf_executable = assert(vim.uv.fs_realpath(vim.fn.exepath("fzf")), "fzf executable not found")
local fzf_runtime = vim.fs.dirname(vim.fs.dirname(fzf_executable))

require("lazy").setup({ {
  "junegunn/fzf.vim",
  dependencies = { { dir = fzf_runtime, name = "fzf" } },
  config = function()
    vim.g.fzf_layout = {
      window = {
        width = 0.96,
        height = 0.94,
      },
    }
    vim.g.fzf_preview_window = { "right:60%:hidden", "?" }

    vim.env.FZF_DEFAULT_COMMAND = [[ag --ignore-case --hidden --ignore .git -g ""]]

    local fzf_opts = vim.fn["fzf#vim#with_preview"]("right:60%:hidden", "?")

    local function search(query)
      local ag_options = table.concat({
        '--color-path="0;34"',
        '--color-match="31;40"',
        "--ignore-case",
        "--hidden",
        "--ignore .git",
        "-Q",
        vim.fn.shellescape(query),
      }, " ")
      vim.fn["fzf#vim#ag_raw"](ag_options, fzf_opts, 0)
    end

    vim.keymap.set("n", "<C-p>", "<cmd>Files<cr>", { desc = "FZF: Files" })
    vim.keymap.set("n", "<Leader>e", "<cmd>Files %:p:h<cr>", { desc = "FZF: Files (current dir)" })
    vim.keymap.set("n", "<Leader>h", "<cmd>History<cr>", { desc = "FZF: History" })
    vim.keymap.set("n", "<Leader>r", "<cmd>History:<cr>", { desc = "FZF: Command history" })
    vim.keymap.set("n", "<Leader>s", function()
      search(vim.fn.expand("<cword>"))
    end, { desc = "FZF: Search word under cursor" })
    vim.keymap.set("x", "<Leader>s", function()
      local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
      search(table.concat(lines, "\n"))
    end, { desc = "FZF: Search selection" })

    vim.api.nvim_create_user_command("SRaw", function(opts)
      vim.fn["fzf#vim#ag"](opts.args, fzf_opts, 0)
    end, {
      nargs = "*",
      desc = "FZF: search (raw)"
    })

    vim.api.nvim_create_user_command("S", function(opts)
      search(opts.args)
    end, {
      nargs = "*",
      desc = "FZF: search"
    })
  end
}, {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup({
      options = {
        icons_enabled = false,
        section_separators = '',
        component_separators = ''
      },
      tabline = {
        lualine_a = { {
          'tabs',
          tab_max_length = 40,
          max_length = function()
            return vim.o.columns
          end,
          mode = 1,
          path = 0
        } }
      }
    })
  end
}, {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFileToggle" },
  keys = {
    { "<C-e>", "<cmd>NvimTreeFindFileToggle<CR>", desc = "Toggle file explorer on current file" }
  },
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 35,
        adaptive_size = true
      },
      actions = {
        open_file = {
          quit_on_open = true
        }
      },
      renderer = {
        icons = {
          webdev_colors = false,
          symlink_arrow = " ➛ ",
          show = {
            file = false,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = true,
            diagnostics = true,
            bookmarks = true
          },
          glyphs = {
            symlink = "@",
            bookmark = ":",
            modified = "●",
            folder = {
              arrow_closed = "⏵",
              arrow_open = "⏷",
              default = "",
              open = "",
              empty = "∅",
              empty_open = "⦱",
              symlink = "@",
              symlink_open = "@"
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "⌥",
              renamed = "➜",
              untracked = "★",
              deleted = "⊖",
              ignored = "◌"
            }
          }
        }
      },
      git = {
        ignore = false
      }
    })
  end
}, "mg979/vim-visual-multi", {
  'lewis6991/gitsigns.nvim',
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require('gitsigns').setup({
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map('n', '<leader>gd', gitsigns.diffthis, { desc = "Git diff (this)" })
        map('n', '<leader>gb', gitsigns.blame, { desc = "Git blame (buffer)" })
        map('n', '<leader>ghb', function()
          gitsigns.blame_line {
            full = true
          }
        end, { desc = "Git blame (line)" })
      end
    })
  end
}, {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitFilterCurrentFile",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>gs", "<cmd>LazyGit<cr>",                  desc = "LazyGit" },
    { "<leader>gc", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "LazyGitFilterCurrentFile" }
  }
}, "mason-org/mason.nvim", "mason-org/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim",
  "neovim/nvim-lspconfig", {
  "rebelot/kanagawa.nvim",
  config = function()
    require("kanagawa").setup({
      overrides = function()
        return {
          LineNr = { bg = "NONE" },
          SignColumn = { bg = "NONE" },
        }
      end,
    })
    vim.cmd.colorscheme("kanagawa-wave")
  end
}, {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    vim.g.disable_autoformat = false

    vim.api.nvim_create_user_command("ToggleAutoFormat", function()
      vim.g.disable_autoformat = not vim.g.disable_autoformat
      vim.notify("Autoformat " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
    end, {
      desc = "Toggle autoformat-on-save"
    })

    conform.setup({
      formatters_by_ft = {
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" }
      },
      format_on_save = function()
        if vim.g.disable_autoformat then
          return
        end
        return {
          lsp_format = "fallback",
          timeout_ms = 2000
        }
      end
    })
    vim.keymap.set('n', '<leader>tpf', '<cmd>ToggleAutoFormat<cr>', {
      desc = "Toggle autoformat-on-save"
    })
  end
} }, {
  lockfile = lazy_lockfile,
  rocks = { enabled = false },
})

-- LSP
local preferred_ts_server = vim.fn.executable("tsgo") == 1 and "tsgo" or "ts_ls"
local mason_servers = { "pyright", "biome", "lua_ls", "tailwindcss", "ts_ls" }
local lsp_servers = { "pyright", "biome", "lua_ls", "tailwindcss", preferred_ts_server }

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = mason_servers,
  automatic_enable = false,
})
require('mason-tool-installer').setup({
  ensure_installed = { 'prettier' }
})

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Enable native LSP completion",
  group = config_group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or not client:supports_method("textDocument/completion") then
      return
    end

    vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })

    vim.keymap.set("i", "<C-n>", function()
      if vim.fn.pumvisible() == 1 then
        return "<C-n>"
      end
      vim.lsp.completion.get()
      return ""
    end, { buffer = args.buf, expr = true, desc = "Open or select next completion" })

    vim.keymap.set("i", "<C-p>", function()
      return vim.fn.pumvisible() == 1 and "<C-p>" or ""
    end, { buffer = args.buf, expr = true, desc = "Select previous completion" })
  end,
})

vim.lsp.enable(lsp_servers)
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- Easier moving in tabs and windows
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window right" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window left" })

-- Wrapped lines go down/up to the next row, rather than the next line in the file
vim.keymap.set("n", "j", function()
  return vim.v.count == 0 and "gj" or "j"
end, { expr = true, desc = "Down (wrap)" })
vim.keymap.set("n", "k", function()
  return vim.v.count == 0 and "gk" or "k"
end, { expr = true, desc = "Up (wrap)" })

-- Conflict with moving to top and bottom of the screen
vim.keymap.set("n", "H", "gT", { desc = "Previous tab" })
vim.keymap.set("n", "L", "gt", { desc = "Next tab" })

-- Reorder tabs
vim.keymap.set("n", "<Leader>ml", "<cmd>tabmove -1<cr>", { desc = "Move tab left" })
vim.keymap.set("n", "<Leader>mr", "<cmd>tabmove +1<cr>", { desc = "Move tab right" })

-- Toggle search highlighting rather than clear the current search results.
vim.keymap.set("n", "<leader>/", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Visual shifting (does not exit Visual mode)
vim.keymap.set("x", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("x", ">", ">gv", { desc = "Indent right" })

-- Allow using the repeat operator with a visual selection (!)
-- http://stackoverflow.com/a/8064607/127816
vim.keymap.set("x", ".", ":normal .<cr>", { silent = true, desc = "Repeat selection" })

-- For when you forget to sudo.. Really Write the file.
vim.keymap.set("c", "w!!", "w !sudo tee % >/dev/null", { desc = "Write with sudo" })

-- Toggle cursorcolumn
vim.keymap.set("n", "<Leader>il", "<cmd>set cursorcolumn!<cr>", { desc = "Toggle cursorcolumn" })

-- Open Neovim's bundled undo-tree viewer on demand.
vim.keymap.set("n", "<leader>u", function()
  vim.cmd.packadd("nvim.undotree")
  require("undotree").open()
end, { desc = "Toggle undo tree" })

-- Copy whole file
vim.keymap.set("n", "<C-x>", "<cmd>%y<cr>", { desc = "Yank whole file" })

local function copy_file_name(modifier, label)
  return function()
    local value = vim.fn.expand(modifier)
    vim.fn.setreg("+", value)
    vim.notify(label .. ": " .. value)
  end
end

-- Copy relative path (src/foo.txt)
vim.keymap.set("n", "<leader>cfr", copy_file_name("%", "Copied relative path"), { desc = "Copy relative path" })
-- Copy filename (foo.txt)
vim.keymap.set("n", "<leader>cff", copy_file_name("%:t", "Copied filename"), { desc = "Copy filename" })

-- Toggling scrolloff
vim.keymap.set("n", "<Leader>zz", function()
  vim.o.scrolloff = vim.o.scrolloff == 999 and 3 or 999
end, { desc = "Toggle scrolloff" })
