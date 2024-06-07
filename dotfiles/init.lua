-- Environment {
-- Basics {
vim.opt.compatible = false -- Must be first line
-- }

-- Global let, must be put in the beginning {
vim.g.mapleader = ','      -- Set mapleader
vim.g.maplocalleader = '_' -- Set maplocalleader
-- }
-- }

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- fuzzy search
  {
    'junegunn/fzf',
    dir = '~/.fzf',
    build = './install --all'
  },
  'junegunn/fzf.vim',

  -- misc
  'itchyny/lightline.vim',
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      local nvimtree = require("nvim-tree")

      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.opt.termguicolors = true

      nvimtree.setup({
        view = {
          width = 35,
          adaptive_size = true,
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
              bookmarks = true,
            },
            glyphs = {
              symlink = "@",
              bookmark = ":",
              modified = "●",
              folder = {
                arrow_closed = "⏵",
                arrow_open = "⏷",
                default = "|",
                open = "/",
                empty = "∅",
                empty_open = "⦱",
                symlink = "@",
                symlink_open = "@",
              },
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "⌥",
                renamed = "➜",
                untracked = "★",
                deleted = "⊖",
                ignored = "◌",
              },
            },
          },
        },
        git = {
          ignore = false,
        },
      })

      vim.keymap.set("n", "<C-e>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
      vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>",
        { desc = "Toggle file explorer on current file" })
    end
  },
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'terryma/vim-multiple-cursors',
  'mbbill/undotree',
  'tpope/vim-fugitive',
  'tpope/vim-commentary',
  'majutsushi/tagbar',

  'github/copilot.vim',

  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",

  -- appearance
  'rafi/awesome-vim-colorschemes',
  'mhinz/vim-signify',

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = {
          "json",
          "javascript",
          "typescript",
          "tsx",
          "yaml",
          "html",
          "css",
          "prisma",
          "markdown",
          "markdown_inline",
          "graphql",
          "bash",
          "lua",
          "vim",
          "dockerfile",
          "gitignore",
          "query",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },

  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")
      vim.g.disable_autoformat = true

      vim.api.nvim_create_user_command("ToggleAutoFormat", function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
      end, {
        desc = "Toggle autoformat-on-save",
      })

      conform.setup({
        formatters_by_ft = {
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          graphql = { "prettier" },
        },
        format_on_save = function(bufnr)
          if vim.g.disable_autoformat then
            return
          end
          return {
            async = true,
            lsp_fallback = true,
            timeout_ms = 500,
          }
        end,
      })

      vim.keymap.set({ 'n', 'v', 'x' }, "<leader>Pf", function()
        conform.format({
          async = true,
          lsp_fallback = true,
          timeout_ms = 500,
        })
      end)
      vim.keymap.set('n', '<leader>tpf', ':ToggleAutoFormat<CR>', { noremap = true, silent = true })
    end,
  }
})

-- Colorscheme {
vim.opt.background = 'dark'
vim.g.seoul256_background = 234
vim.cmd('colorscheme seoul256')
-- }

-- FZF {
-- Key mappings
vim.api.nvim_set_keymap('n', '<C-p>', ':Files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>f', ':Files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>F', ':Files!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>h', ':History<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>H', ':History!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>j', ':Jumps<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>b', ':Buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>B', ':Buffers!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>w', ':Windows<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>c', ':BCommits!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>r', ':History:<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>s', ':S <C-R><C-W><CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>S', ':S! <C-R><C-W><CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Leader>s', 'y:S <C-r>=fnameescape(@")<CR><CR>', { noremap = true })
vim.api.nvim_set_keymap('v', '<Leader>S', 'y:S! <C-r>=fnameescape(@")<CR><CR>', { noremap = true })

-- Set FZF default command based on availability of 'ag'
if vim.fn.executable('ag') == 1 then
  vim.env.FZF_DEFAULT_COMMAND = 'ag --ignore-case --hidden --ignore .git --path-to-ignore ~/.ignore -g ""'
else
  vim.env.FZF_DEFAULT_COMMAND = [[
            find *
            -path '*/\.*' -prune -o
            -path 'node_modules/**' -prune -o
            -path 'target/**' -prune -o
            -path 'dist/**' -prune -o
            -type f -print -o -type l -print 2> /dev/null
        ]]
end

-- Define custom FZF commands with preview
vim.api.nvim_exec([[
        command! -bang -nargs=* SRaw call fzf#vim#ag(<q-args>, <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
        command! -bang -nargs=* -complete=dir S call fzf#vim#ag_raw('--ignore-case --hidden --ignore .git --path-to-ignore ~/.ignore -Q '.<q-args>, <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
    ]], false)
-- }

-- JSON {
-- Key mapping for formatting JSON using python's json.tool
vim.api.nvim_set_keymap('n', '<leader>jt', [[:%!python -m json.tool<CR>:set filetype=json<CR>]],
  { noremap = true, silent = true })

-- Disable JSON syntax conceal
vim.g.vim_json_syntax_conceal = 0
-- }

-- TagBar {
vim.api.nvim_set_keymap('n', '<leader>ptt', ':TagbarToggle<CR>', { noremap = true, silent = true })
-- }

-- Fugitive {
-- Key mappings for Git commands
vim.api.nvim_set_keymap('n', '<leader>gs', ':Git<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gd', ':Gdiff<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gc', ':Gcommit<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gb', ':Git blame<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gl', ':Gclog<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gh', ':0Gclog<CR>', { noremap = true, silent = true })
-- }

-- UndoTree {
vim.api.nvim_set_keymap('n', '<Leader>u', ':UndotreeToggle<CR>', { noremap = true, silent = true })
vim.g.undotree_SetFocusWhenToggle = 1
-- }

-- lightline {
vim.g.lightline = {
  colorscheme = 'seoul256'
}
-- }

-- LSP {
local lsp_cmds = vim.api.nvim_create_augroup('lsp_cmds', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_cmds,
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { buffer = true })
    end

    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
    bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
    bufmap({ 'n' }, '<leader>pf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
    bufmap({ 'x', 'v' }, '<leader>pf', '<cmd>lua vim.lsp.buf.format({async = true})<cr><Esc>')
    bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
    bufmap('n', '<F3>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})
local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    'tsserver',
    'pyright',
    'biome',
    'ast_grep',
    'lua_ls',
  },
  automatic_installation = true,
  handlers = {
    function(server)
      lspconfig[server].setup({
        capabilities = lsp_capabilities,
      })
    end,
  }
})
require('mason-tool-installer').setup {
  ensure_installed = {
    'prettier',
  }
}
--}

-- General {
-- Remove specific format options for all file types
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})
-- Set local tabstop, softtabstop, and shiftwidth for specific file types and patterns
local set_indent = function()
  vim.opt_local.tabstop = 2
  vim.opt_local.softtabstop = 2
  vim.opt_local.shiftwidth = 2
end

-- Define autocmd for specific file patterns
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*.coffee", "*.erb", "*.scss", "*.jst", "*.eco", "*.ejs", "*.yml",
    "*.vue", "*.js", "*.jsx", "*.ts", "*.tsx", "*.mjs", "*.css", "*.rb",
    "*.html", "*.json", "*.tf", "*.tfvars", "*.prisma", "*.lua",
  },
  callback = set_indent,
})

-- Enable file type detection, plugins, and indenting
vim.cmd('filetype plugin indent on')

-- Enable syntax highlighting
vim.cmd('syntax on')

-- Automatically enable mouse usage
vim.opt.mouse = 'a'

-- Hide the mouse cursor while typing
vim.opt.mousehide = true

-- Set script encoding to utf-8
vim.scriptencoding = 'utf-8'

-- Configure clipboard settings
if vim.fn.has('clipboard') == 1 then
  if vim.fn.has('unnamedplus') == 1 then
    -- When possible, use + register for copy-paste
    vim.opt.clipboard = 'unnamed,unnamedplus'
  else
    -- On mac and Windows, use * register for copy-paste
    vim.opt.clipboard = 'unnamed'
  end
end

-- Abbreviate messages (avoids 'hit enter')
vim.opt.shortmess:append('filmnrxoOtT')

-- Better Unix / Windows compatibility
vim.opt.viewoptions = { 'folds', 'options', 'cursor', 'unix', 'slash' }

-- Store a lot of history (default is 20)
vim.opt.history = 1000

-- Allow buffer switching without saving
vim.opt.hidden = true

-- Set '.' as an end of word designator
vim.opt.iskeyword:remove('.')

-- Set '#' as an end of word designator
vim.opt.iskeyword:remove('#')

-- Set '-' as an end of word designator
vim.opt.iskeyword:remove('-')

-- Use default regular expression engine
vim.opt.regexpengine = 0

-- Disable spell checking
vim.opt.spell = false

-- Set update time
vim.opt.updatetime = 1000

-- Expand tabs to spaces
vim.opt.expandtab = true

-- Enable backups
vim.opt.backup = true
local prefix = vim.env.XDG_CONFIG_HOME or vim.fn.expand("~/.config")
vim.opt.undodir = { prefix .. "/nvim/.undo//" }
vim.opt.backupdir = { prefix .. "/nvim/.backup//" }
vim.opt.directory = { prefix .. "/nvim/.swp//" }

-- Persistent undo settings
if vim.fn.has('persistent_undo') == 1 then
  vim.opt.undofile = true    -- Enable persistent undo
  vim.opt.undolevels = 1000  -- Maximum number of changes that can be undone
  vim.opt.undoreload = 10000 -- Maximum number of lines to save for undo on a buffer reload
end

-- Display the current mode
vim.opt.showmode = true

-- Highlight current line
vim.opt.cursorline = true

-- SignColumn should match background
vim.cmd('highlight clear SignColumn')

-- Current line number row will have the same background color in relative mode
vim.cmd('highlight clear LineNr')

-- Backspace for dummies
vim.opt.backspace = { 'indent', 'eol', 'start' }

-- No extra spaces between rows
vim.opt.linespace = 0

-- Line numbers on
vim.opt.number = true

-- Show matching brackets/parenthesis
vim.opt.showmatch = true

-- Find as you type search
vim.opt.incsearch = true

-- Highlight search terms
vim.opt.hlsearch = true

-- Windows can be 0 line high
vim.opt.winminheight = 0

-- Case insensitive search
vim.opt.ignorecase = true

-- Case sensitive when uppercase present
vim.opt.smartcase = true

-- Show list instead of just completing
vim.opt.wildmenu = true

-- Command <Tab> completion: list matches, then longest common part, then all
vim.opt.wildmode = { 'list:longest', 'full' }

-- Backspace and cursor keys wrap too
vim.opt.whichwrap:append('b,s,h,l,<,>,[,]')

-- Lines to scroll when cursor leaves screen
vim.opt.scrolljump = 5

-- Minimum lines to keep above and below cursor
vim.opt.scrolloff = 3

-- Folding settings
vim.opt.foldlevel = 3
vim.opt.foldenable = true

-- Highlight problematic whitespace
vim.opt.list = true
vim.opt.listchars = { tab = '› ', trail = '•', extends = '#', nbsp = '.' }

-- Do not wrap long lines
vim.opt.wrap = false

-- Indent at the same level of the previous line
vim.opt.autoindent = true

-- Use indents of 4 spaces
vim.opt.shiftwidth = 4

-- An indentation every four columns
vim.opt.tabstop = 4

-- Let backspace delete indent
vim.opt.softtabstop = 4

-- Prevents inserting two spaces after punctuation on a join (J)
vim.opt.joinspaces = false

-- Puts new vsplit windows to the right of the current
vim.opt.splitright = true

-- Puts new split windows to the bottom of the current
vim.opt.splitbelow = true

-- Easier moving in tabs and windows
vim.api.nvim_set_keymap('n', '<C-J>', '<C-W>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-K>', '<C-W>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W>h', { noremap = true, silent = true })

-- Wrapped lines go down/up to the next row, rather than the next line in the file
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })

-- Conflict with moving to top and bottom of the screen
vim.api.nvim_set_keymap('n', '<S-H>', 'gT', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-L>', 'gt', { noremap = true, silent = true })

-- Reorder tabs
vim.api.nvim_set_keymap('n', '<Leader>mtl', ':tabm -1<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>mtr', ':tabm +1<CR>', { noremap = true, silent = true })

-- Yank from the cursor to the end of the line, to be consistent with C and D.
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true, silent = true })

-- Toggle search highlighting rather than clear the current search results.
vim.api.nvim_set_keymap('n', '<leader>/', ':nohlsearch<CR>', { noremap = true, silent = true })

-- Find merge conflict markers
vim.api.nvim_set_keymap('n', '<leader>mc', [[/\v^[<\|=>]{7}( .*\|$)<CR>]], { noremap = true, silent = true })

-- Shortcuts
-- Change Working Directory to that of the current file
vim.api.nvim_set_keymap('c', 'cwd', 'lcd %:p:h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('c', 'cd.', 'lcd %:p:h', { noremap = true, silent = true })

-- Visual shifting (does not exit Visual mode)
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true })

-- Allow using the repeat operator with a visual selection (!)
-- http://stackoverflow.com/a/8064607/127816
vim.api.nvim_set_keymap('v', '.', ':normal .<CR>', { noremap = true, silent = true })

-- For when you forget to sudo.. Really Write the file.
vim.api.nvim_set_keymap('c', 'w!!', 'w !sudo tee % >/dev/null', { noremap = true, silent = true })

-- Toggle cursorcolumn
vim.api.nvim_set_keymap('n', '<Leader>il', ':set cursorcolumn!<CR>', { noremap = true, silent = true })

-- Adjust viewports to the same size
vim.api.nvim_set_keymap('n', '<Leader>=', '<C-w>=', { noremap = true, silent = true })

-- Easier horizontal scrolling
vim.api.nvim_set_keymap('n', 'zl', 'zL', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'zh', 'zH', { noremap = true, silent = true })

-- Easier formatting
vim.api.nvim_set_keymap('n', '<Leader>q', 'gwip', { noremap = true, silent = true })

-- Copy to macOS clipboard
vim.api.nvim_set_keymap('v', '<C-x>', ':w !pbcopy<CR><CR>', { noremap = true, silent = true })

-- Copy whole file
vim.api.nvim_set_keymap('n', '<C-x>', ':%y<CR>', { noremap = true, silent = true })

-- Duplicate selection to below
vim.api.nvim_set_keymap('v', '<leader>d', 'y\'>p', { noremap = true, silent = true })

-- Function to check if running on macOS
local is_mac = vim.fn.has("mac") == 1 or vim.fn.has("gui_macvim") == 1 or vim.fn.has("gui_mac") == 1

if is_mac then
  -- Copy relative path (src/foo.txt)
  vim.api.nvim_set_keymap('n', '<leader>cfr', ':let @*=expand("%")<CR>', { noremap = true, silent = true })

  -- Copy absolute path (/something/src/foo.txt)
  vim.api.nvim_set_keymap('n', '<leader>cfa', ':let @*=expand("%:p")<CR>', { noremap = true, silent = true })

  -- Copy filename (foo.txt)
  vim.api.nvim_set_keymap('n', '<leader>cff', ':let @*=expand("%:t")<CR>', { noremap = true, silent = true })

  -- Copy directory name (/something/src)
  vim.api.nvim_set_keymap('n', '<leader>cfd', ':let @*=expand("%:p:h")<CR>', { noremap = true, silent = true })
end
-- }
