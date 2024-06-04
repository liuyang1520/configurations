-- Environment {
    -- Basics {
        vim.opt.compatible = false    -- Must be first line
    -- }

    -- Global let, must be put in the beginning {
        vim.g.mapleader = ','         -- Set mapleader
        vim.g.maplocalleader = '_'    -- Set maplocalleader
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
    'preservim/nerdtree',
    'Xuyuanp/nerdtree-git-plugin',
    'tpope/vim-surround',
    'tpope/vim-repeat',
    'terryma/vim-multiple-cursors',
    'mbbill/undotree',
    'tpope/vim-fugitive',
    'tpope/vim-commentary',
    'majutsushi/tagbar',

    -- languages
    'pangloss/vim-javascript',
    'leafgarland/typescript-vim',
    'peitalin/vim-jsx-typescript',

    'elzr/vim-json',

    'hail2u/vim-css3-syntax',
    'tpope/vim-haml',
    'groenewege/vim-less',

    'tpope/vim-rails',

    {
        'fatih/vim-go',
        build = ':GoInstallBinaries'
    },

    'hashivim/vim-terraform',

    'tpope/vim-markdown',
    {
        'iamcco/markdown-preview.nvim',
        build = function() vim.fn['mkdp#util#install']() end,
        ft = {'markdown', 'vim-plug'}
    },

    'rust-lang/rust.vim',

    'github/copilot.vim',

    -- appearance
    'rafi/awesome-vim-colorschemes',
    'Yggdroot/indentLine',
    'mhinz/vim-signify'
})

-- Colorscheme {
    vim.opt.background = 'dark'
    vim.cmd('colorscheme seoul256')
    vim.g.seoul256_background = 234
-- }

-- GoLang {
    vim.g.go_highlight_functions = 1
    vim.g.go_highlight_methods = 1
    vim.g.go_highlight_structs = 1
    vim.g.go_highlight_operators = 1
    vim.g.go_highlight_build_constraints = 1
    vim.g.go_fmt_command = "goimports"
-- }


-- FZF {
    -- Key mappings
    vim.api.nvim_set_keymap('n', '<C-p>', ':Files<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>f', ':Files<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>F', ':Files!<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>h', ':History<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>H', ':History!<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>b', ':Buffers<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>B', ':Buffers!<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>w', ':Windows<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>c', ':BCommits!<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>r', ':History:<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>s', ':S <C-R><C-W><CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>S', ':S! <C-R><C-W><CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', '<Leader>s', 'y:S <C-r>=fnameescape(@")<CR><CR>', { noremap = true })
    vim.api.nvim_set_keymap('v', '<Leader>S', 'y:S! <C-r>=fnameescape(@")<CR><CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<Leader>t', ':Tags <C-R><C-W><CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>T', ':Tags! <C-R><C-W><CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', '<Leader>t', 'y:Tags <C-r>=fnameescape(@")<CR><CR>', { noremap = true })
    vim.api.nvim_set_keymap('v', '<Leader>T', 'y:Tags! <C-r>=fnameescape(@")<CR><CR>', { noremap = true })

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

-- NerdTree {
    -- Key mappings
    vim.api.nvim_set_keymap('n', '<C-e>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>e', ':NERDTreeFind<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>nt', ':NERDTreeFind<CR>', { noremap = true, silent = true })

    -- NERDTree settings
    vim.g.NERDTreeShowBookmarks = 1
    vim.g.NERDTreeIgnore = { '\\.py[cd]$', '\\~$', '\\.swo$', '\\.swp$', '^\\.git$', '^\\.hg$', '^\\.svn$', '\\.bzr$' }
    vim.g.NERDTreeChDirMode = 0
    vim.g.NERDTreeQuitOnOpen = 1
    vim.g.NERDTreeMouseMode = 2
    vim.g.NERDTreeShowHidden = 1
    vim.g.NERDTreeAutoDeleteBuffer = 1
    vim.g.NERDTreeMinimalUI = 1
    vim.g.NERDTreeWinSize = 50
    vim.g.NERDTreeMinimalMenu = 1

    -- Auto commands
    vim.api.nvim_exec([[
        autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
        autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
    ]], false)
-- }


-- JSON {
    -- Key mapping for formatting JSON using python's json.tool
    vim.api.nvim_set_keymap('n', '<leader>jt', [[:%!python -m json.tool<CR>:set filetype=json<CR>]], { noremap = true, silent = true })

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


-- indentLine {
    vim.g.indentLine_enabled = 0
    vim.api.nvim_set_keymap('n', '<leader>il', ':IndentLinesToggle<CR>', { noremap = true, silent = true })
-- }

-- lightline {
    vim.g.lightline = {
        colorscheme = 'seoul256'
    }
-- }
