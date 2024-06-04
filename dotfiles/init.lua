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
    'ludovicchabant/vim-gutentags',
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

-- Ctags {
    -- Set tags option
    vim.opt.tags = { './tags;/,~/.vimtags' }

    -- Make tags placed in .git/tags file available in all levels of a repository
    local gitroot = vim.fn.system('git rev-parse --show-toplevel'):gsub('[\n\r]', '')
    if gitroot ~= '' then
        vim.opt.tags:append(gitroot .. '/.git/tags')
    end
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
