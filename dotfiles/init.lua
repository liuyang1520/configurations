vim.g.mapleader = ','

if not vim.g.vscode then
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath })
  end
  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup({ {
    'junegunn/fzf',
    build = './install --all',
    name = "fzf"
  }, {
    'junegunn/fzf.vim',
    config = function()
      vim.keymap.set('n', '<C-p>', ':Files<CR>', {
        noremap = true,
        silent = true
      })
      vim.keymap.set('n', '<Leader>F', ':Files!<CR>', {
        noremap = true,
        silent = true
      })
      -- Open files in the current directory
      vim.keymap.set('n', '<Leader>e', ':Files %:p:h<CR>', {
        noremap = true,
        silent = true
      })
      vim.keymap.set('n', '<Leader>h', ':History<CR>', {
        noremap = true,
        silent = true
      })
      vim.keymap.set('n', '<Leader>b', ':Buffers<CR>', {
        noremap = true,
        silent = true
      })
      vim.keymap.set('n', '<Leader>r', ':History:<CR>', {
        noremap = true,
        silent = true
      })
      vim.keymap.set('n', '<Leader>s', ':S <C-R><C-W><CR>', {
        noremap = true,
        silent = true
      })
      vim.keymap.set('n', '<Leader>S', ':S! <C-R><C-W><CR>', {
        noremap = true,
        silent = true
      })
      vim.keymap.set('v', '<Leader>s', 'y:S <C-r>=fnameescape(@")<CR><CR>', {
        noremap = true
      })
      vim.keymap.set('v', '<Leader>S', 'y:S! <C-r>=fnameescape(@")<CR><CR>', {
        noremap = true
      })

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
        command! -bang -nargs=* -complete=dir S call fzf#vim#ag_raw('--color-path="0;34" --color-match="31;40" --ignore-case --hidden --ignore .git --path-to-ignore ~/.ignore -Q '.<q-args>, <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
      ]], false)
    end
  }, {
    "ibhagwan/fzf-lua",
    config = function()
      require("fzf-lua").setup({
        winopts = {
          preview = {
            default = "bat"
          }
        },
        keymap = {
          fzf = {
            ["ctrl-u"] = "half-page-up",
            ["ctrl-/"] = "toggle-preview"
          }
        }
      })
    end
  }, -- misc
    {
      'nvim-lualine/lualine.nvim',
      config = function()
        require('lualine').setup({
          options = {
            icons_enabled = false,
            theme = 'seoul256',
            section_separators = '',
            component_separators = ''
          },
          tabline = {
            lualine_a = { {
              'tabs',
              tab_max_length = 40,
              max_length = vim.o.columns,
              mode = 1,
              path = 0
            } }
          }
        })
      end
    }, {
    "nvim-tree/nvim-tree.lua",
    config = function()
      local nvimtree = require("nvim-tree")
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.opt.termguicolors = true
      nvimtree.setup({
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
        },
        filesystem_watchers = {
          enable = false
        }
      })
      vim.keymap.set("n", "<C-e>", "<cmd>NvimTreeFindFileToggle<CR>", {
        desc = "Toggle file explorer on current file"
      })
    end
  }, 'tpope/vim-repeat', 'tpope/vim-commentary', 'terryma/vim-multiple-cursors', {
    "ggandor/leap.nvim",
    config = function()
      require('leap').create_default_mappings()
    end
  }, {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<Leader>u', vim.cmd.UndotreeToggle, {
        noremap = true,
        silent = true
      })
      vim.g.undotree_SetFocusWhenToggle = 1
    end
  }, {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol',
          delay = 100
        },
        on_attach = function(bufnr)
          local gitsigns = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          map('n', '<leader>gd', gitsigns.diffthis)
          map('n', '<leader>gb', gitsigns.blame)
          map('n', '<leader>ghb', function()
            gitsigns.blame_line {
              full = true
            }
          end)
        end
      })
    end
  }, {
    "kdheepak/lazygit.nvim",
    lazy = true,
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
  }, "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim",
    "neovim/nvim-lspconfig", {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        completion = {
          autocomplete = false
        },
        sources = cmp.config.sources({ {
          name = 'nvim_lsp'
        } }),
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping({
            i = function()
              if cmp.visible() then -- pop-up menu is visible
                cmp.select_next_item()
              else
                cmp.complete() -- open the pop-up menu
              end
            end
          }),
          ["<C-p>"] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Insert
          })
        })
      })
    end
  }, {
    "github/copilot.vim",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.keymap.set("i", "<C-l>", 'copilot#Accept("<CR>")', {
        silent = true,
        expr = true,
        script = true,
        replace_keycodes = false
      })
      vim.keymap.set("i", "<C-j>", "<Plug>(copilot-next)")
      vim.keymap.set("i", "<C-k>", "<Plug>(copilot-previous)")
      vim.keymap.set("i", "<C-h>", "<Plug>(copilot-dismiss)")
    end
  }, {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = function()
      require("claudecode").setup({})
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "*",
        callback = function()
          -- Check if this is a Claude Code terminal by looking at the command
          local bufname = vim.api.nvim_buf_get_name(0)
          if bufname:match("claude") or bufname:match("Claude") then
            -- Set buffer-local keymaps only for Claude terminals
            vim.keymap.set('t', '<C-h>', '<C-\\><C-N><C-w>h', { buffer = true, desc = 'Claude Terminal left' })
            vim.keymap.set('t', '<C-j>', '<C-\\><C-N><C-w>j', { buffer = true, desc = 'Claude Terminal down' })
            vim.keymap.set('t', '<C-k>', '<C-\\><C-N><C-w>k', { buffer = true, desc = 'Claude Terminal up' })
            vim.keymap.set('t', '<C-l>', '<C-\\><C-N><C-w>l', { buffer = true, desc = 'Claude Terminal right' })
          end
        end,
      })
    end,
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>as", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                 desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
    },
  }, {
    'rafi/awesome-vim-colorschemes',
    config = function()
      vim.opt.background = 'dark'
      vim.g.seoul256_background = 233
      vim.cmd('colorscheme seoul256')
    end
  }, {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = { "json", "javascript", "typescript", "tsx", "yaml", "html", "css", "prisma",
          "markdown", "markdown_inline", "graphql", "bash", "lua", "vim", "vimdoc",
          "dockerfile", "gitignore", "query" },
        highlight = {
          enable = true
        },
        indent = {
          enable = true
        }
      })
    end
  }, {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")
      vim.g.disable_autoformat = false

      vim.api.nvim_create_user_command("ToggleAutoFormat", function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
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
            async = false,
            lsp_fallback = true,
            timeout_ms = 2000
          }
        end
      })

      vim.keymap.set({ 'n', 'v', 'x' }, "<leader>Pf", function()
        conform.format({
          async = true,
          lsp_fallback = true,
          timeout_ms = 500
        })
      end)
      vim.keymap.set('n', '<leader>tpf', ':ToggleAutoFormat<CR>', {
        noremap = true,
        silent = true
      })
    end
  } })

  -- LSP
  local lsp_cmds = vim.api.nvim_create_augroup('lsp_cmds', {
    clear = true
  })
  vim.api.nvim_create_autocmd('LspAttach', {
    group = lsp_cmds,
    desc = 'LSP actions',
    callback = function()
      local bufmap = function(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, {
          buffer = true
        })
      end

      bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
      bufmap('n', 'gd', "<cmd>lua require('fzf-lua').lsp_definitions({ jump1 = true })<cr>")
      bufmap('n', 'gD', "<cmd>lua require('fzf-lua').lsp_declarations()<cr>")
      bufmap('n', 'gi', "<cmd>lua require('fzf-lua').lsp_implementations()<cr>")
      bufmap('n', 'go', "<cmd>lua require('fzf-lua').lsp_typedefs()<cr>")
      bufmap('n', 'gr', "<cmd>lua require('fzf-lua').lsp_references()<cr>")
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
    ensure_installed = { 'ts_ls', 'pyright', 'biome', 'ast_grep', 'lua_ls', 'tailwindcss' },
    automatic_enabled = true,
    handlers = { function(server)
      if server == "ts_ls" then
        lspconfig[server].setup({
          cmd = { "env", "NODE_OPTIONS=--max-old-space-size=16384", "typescript-language-server", "--stdio" },
          capabilities = lsp_capabilities
        })
      else
        lspconfig[server].setup({
          capabilities = lsp_capabilities
        })
      end
    end }
  })
  require('mason-tool-installer').setup {
    ensure_installed = { 'prettier' }
  }
end

-- General
-- Remove specific format options for all file types
-- Comments will no longer be automatically wrapped.
-- Typing a new line while inside a comment will no longer auto-continue the comment.
-- Starting a new line with o or O will not automatically insert the comment leader.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end
})

-- Set local tabstop, softtabstop, and shiftwidth for specific file types and patterns
local set_indent = function()
  vim.opt_local.tabstop = 2
  vim.opt_local.softtabstop = 2
  vim.opt_local.shiftwidth = 2
end
-- Define autocmd for specific file patterns
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.coffee", "*.erb", "*.scss", "*.jst", "*.eco", "*.ejs", "*.yml", "*.vue", "*.js", "*.jsx", "*.ts",
    "*.tsx", "*.mjs", "*.css", "*.rb", "*.html", "*.json", "*.tf", "*.tfvars", "*.prisma", "*.lua" },
  callback = set_indent
})

-- Automatically enable mouse usage
vim.opt.mouse = 'a'

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

-- Abbreviate messages, modifies how Neovim displays and reduces command-line messages.
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
vim.opt.listchars = {
  tab = '› ',
  trail = '•',
  extends = '#',
  nbsp = '.'
}

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
vim.keymap.set('n', '<C-J>', '<C-W>j', {
  noremap = true,
  silent = true
})
vim.keymap.set('n', '<C-K>', '<C-W>k', {
  noremap = true,
  silent = true
})
vim.keymap.set('n', '<C-L>', '<C-W>l', {
  noremap = true,
  silent = true
})
vim.keymap.set('n', '<C-H>', '<C-W>h', {
  noremap = true,
  silent = true
})

-- Close current tab
vim.keymap.set('n', '<C-w>Q', ':tabclose<CR>', {
  noremap = true,
  silent = true
})

-- Wrapped lines go down/up to the next row, rather than the next line in the file
vim.keymap.set('n', 'j', 'gj', {
  noremap = true,
  silent = true
})
vim.keymap.set('n', 'k', 'gk', {
  noremap = true,
  silent = true
})

-- Conflict with moving to top and bottom of the screen
vim.keymap.set('n', '<S-H>', 'gT', {
  noremap = true,
  silent = true
})
vim.keymap.set('n', '<S-L>', 'gt', {
  noremap = true,
  silent = true
})

-- Reorder tabs
vim.keymap.set('n', '<Leader>ml', ':tabm -1<CR>', {
  noremap = true,
  silent = true
})
vim.keymap.set('n', '<Leader>mr', ':tabm +1<CR>', {
  noremap = true,
  silent = true
})

-- Yank from the cursor to the end of the line, to be consistent with C and D.
vim.keymap.set('n', 'Y', 'y$', {
  noremap = true,
  silent = true
})

-- Toggle search highlighting rather than clear the current search results.
vim.keymap.set('n', '<leader>/', ':nohlsearch<CR>', {
  noremap = true,
  silent = true
})

-- Visual shifting (does not exit Visual mode)
vim.keymap.set('v', '<', '<gv', {
  noremap = true,
  silent = true
})
vim.keymap.set('v', '>', '>gv', {
  noremap = true,
  silent = true
})

-- Allow using the repeat operator with a visual selection (!)
-- http://stackoverflow.com/a/8064607/127816
vim.keymap.set('v', '.', ':normal .<CR>', {
  noremap = true,
  silent = true
})

-- For when you forget to sudo.. Really Write the file.
vim.keymap.set('c', 'w!!', 'w !sudo tee % >/dev/null', {
  noremap = true,
  silent = true
})

-- Toggle cursorcolumn
vim.keymap.set('n', '<Leader>il', ':set cursorcolumn!<CR>', {
  noremap = true,
  silent = true
})

-- Easier horizontal scrolling
vim.keymap.set('n', 'zl', 'zL', {
  noremap = true,
  silent = true
})
vim.keymap.set('n', 'zh', 'zH', {
  noremap = true,
  silent = true
})

-- Copy whole file
vim.keymap.set('n', '<C-x>', ':%y<CR>', {
  noremap = true,
  silent = true
})

-- Duplicate selection to below
vim.keymap.set('v', '<leader>d', 'y\'>p', {
  noremap = true,
  silent = true
})

-- Copy relative path (src/foo.txt)
vim.keymap.set('n', '<leader>cfr', ':let @*=expand("%")<CR>', {
  noremap = true,
  silent = true
})
-- Copy filename (foo.txt)
vim.keymap.set('n', '<leader>cff', ':let @*=expand("%:t")<CR>', {
  noremap = true,
  silent = true
})

-- Toggling scrolloff
vim.keymap.set('n', '<Leader>zz', function()
  if vim.o.scrolloff == 999 then
    vim.o.scrolloff = 0
  else
    vim.o.scrolloff = 999
  end
end, { noremap = true, silent = true })

-- Toggle markdown preview with Glow
vim.keymap.set('n', '<leader>gp', function()
  local filepath = vim.fn.expand('%:p')
  vim.cmd('tabnew | term glow "' .. filepath .. '"')
end, { desc = 'Glow Preview in Tab' })
