" =======================================
" This modification is based on spf13-vim
" =======================================

" Environment {
    " Basics {
        set nocompatible        " Must be first line
    " }

    " Global let, must be put in the beginning {
        let mapleader = ','
        let maplocalleader = '_'
    " }
" }

" Install plugins {
    " Environment {
    call plug#begin('~/.vim/plugged')
        " fuzzy search
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
        Plug 'junegunn/fzf.vim'

        " misc
        Plug 'itchyny/lightline.vim'
        Plug 'ludovicchabant/vim-gutentags'
        Plug 'preservim/nerdtree'
        Plug 'Xuyuanp/nerdtree-git-plugin'
        Plug 'tpope/vim-surround'
        Plug 'tpope/vim-repeat'
        Plug 'terryma/vim-multiple-cursors'
        Plug 'mbbill/undotree'
        Plug 'tpope/vim-fugitive'
        Plug 'tpope/vim-commentary'

        " languages
        Plug 'pangloss/vim-javascript'
        Plug 'leafgarland/typescript-vim'
        Plug 'peitalin/vim-jsx-typescript'

        Plug 'elzr/vim-json'

        Plug 'hail2u/vim-css3-syntax'
        Plug 'tpope/vim-haml'
        Plug 'groenewege/vim-less'

        Plug 'tpope/vim-rails'

        Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

        Plug 'hashivim/vim-terraform'

        Plug 'tpope/vim-markdown'
        Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

        Plug 'rust-lang/rust.vim'

        " appearance
        Plug 'rafi/awesome-vim-colorschemes'
        Plug 'Yggdroot/indentLine'
        Plug 'mhinz/vim-signify'

    if !has('nvim')
        if executable('ctags')
            Plug 'majutsushi/tagbar'
        endif
        Plug 'github/copilot.vim'

        " coc
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'antoinemadec/coc-fzf', {'branch': 'release'}
    endif

    call plug#end()
" }

" Plugins {

    " colorscheme {
        set background=dark
        colorscheme seoul256
        let g:seoul256_background = 234
    " }

    if !has('nvim')
    " coc {
        let g:coc_disable_transparent_cursor = 1
        let g:coc_global_extensions = ['coc-tsserver', 'coc-prettier', '@yaegassy/coc-tailwindcss3']
        let g:coc_user_config = {
              \   "list.maxPreviewHeight": 24,
              \   "coc.preferences.formatOnSaveFiletypes": ["javascript", "typescript", "typescriptreact", "javascriptreact"],
              \   "javascript.autoClosingTags": "false",
              \   "typescript.autoClosingTags": "false",
              \   "tsserver.maxTsServerMemory": 8192,
              \ }
        nnoremap <leader>cs :<C-u>CocCommand workspace.showOutput<CR>

        " Use `[g` and `]g` to navigate diagnostics
        nmap <silent> [g <Plug>(coc-diagnostic-prev)
        nmap <silent> ]g <Plug>(coc-diagnostic-next)

        " GoTo code navigation.
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)

        " Prettier
        command! -nargs=0 Prettier :CocCommand prettier.formatFile
        vmap <leader>pf <Plug>(coc-format-selected)
        nmap <leader>pf <Plug>(coc-format-selected)

        " coc-fzf
        let g:coc_fzf_preview = ''
        let g:coc_fzf_opts = []
    " }

    " Ctags {
        set tags=./tags;/,~/.vimtags

        " Make tags placed in .git/tags file available in all levels of a repository
        let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
        if gitroot != ''
            let &tags = &tags . ',' . gitroot . '/.git/tags'
        endif
    " }
    endif

    " GoLang {
        let g:go_highlight_functions = 1
        let g:go_highlight_methods = 1
        let g:go_highlight_structs = 1
        let g:go_highlight_operators = 1
        let g:go_highlight_build_constraints = 1
        let g:go_fmt_command = "goimports"
    " }


    " FZF {
        nnoremap <silent> <C-p> :Files<CR>
        nnoremap <silent> <Leader>f :Files<CR>
        nnoremap <silent> <Leader>F :Files!<CR>
        nnoremap <silent> <Leader>h :History<CR>
        nnoremap <silent> <Leader>H :History!<CR>
        nnoremap <silent> <Leader>b :Buffers<CR>
        nnoremap <silent> <Leader>B :Buffers!<CR>
        nnoremap <silent> <Leader>w :Windows<CR>
        nnoremap <silent> <Leader>c :BCommits!<CR>
        nnoremap <silent> <Leader>r :History:<CR>
        if executable('ag')
          let $FZF_DEFAULT_COMMAND = 'ag --ignore-case --hidden --ignore .git --path-to-ignore ~/.ignore -g ""'
        else
          let $FZF_DEFAULT_COMMAND = "
            \ find *
            \ -path '*/\.*' -prune -o
            \ -path 'node_modules/**' -prune -o
            \ -path 'target/**' -prune -o
            \ -path 'dist/**' -prune -o
            \ -type f -print -o -type l -print 2> /dev/null
            \"
        endif

        " ag with preview
        command! -bang -nargs=* SRaw
          \ call fzf#vim#ag(<q-args>,
          \                 <bang>0 ? fzf#vim#with_preview('up:60%')
          \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
          \                 <bang>0)

        command! -bang -nargs=* -complete=dir S
          \ call fzf#vim#ag_raw('--ignore-case --hidden --ignore .git --path-to-ignore ~/.ignore -Q '.<q-args>,
          \                 <bang>0 ? fzf#vim#with_preview('up:60%')
          \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
          \                 <bang>0)

        nnoremap <silent> <Leader>s :S <C-R><C-W><CR>
        nnoremap <silent> <Leader>S :S! <C-R><C-W><CR>
        vnoremap <Leader>s y:S <C-r>=fnameescape(@")<CR><CR>
        vnoremap <Leader>S y:S! <C-r>=fnameescape(@")<CR><CR>

        " tags
        nnoremap <silent> <Leader>t :Tags <C-R><C-W><CR>
        nnoremap <silent> <Leader>T :Tags! <C-R><C-W><CR>
        vnoremap <Leader>t y:Tags <C-r>=fnameescape(@")<CR><CR>
        vnoremap <Leader>T y:Tags! <C-r>=fnameescape(@")<CR><CR>
    " }

    " gutentags {
        let g:gutentags_enabled = 1
        let g:gutentags_cache_dir = '~/.cachetags'
        let g:gutentags_ctags_tagfile = '.tags'
        let g:gutentags_file_list_command = 'git ls-files'
        " make ctags understand jsx, mjs, tsx
        let g:gutentags_ctags_extra_args = ['--map-javascript=.jsx']
        let g:gutentags_ctags_extra_args += ['--map-javascript=.mjs']
        let g:gutentags_ctags_extra_args += ['--map-typescript=.tsx']
    " }

    " NerdTree {
        if isdirectory(expand("~/.vim/plugged/nerdtree"))
            map <C-e> :NERDTreeToggle<CR>
            map <leader>e :NERDTreeFind<CR>
            nmap <leader>nt :NERDTreeFind<CR>

            let NERDTreeShowBookmarks=1
            let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
            let NERDTreeChDirMode=0
            let NERDTreeQuitOnOpen=1
            let NERDTreeMouseMode=2
            let NERDTreeShowHidden=1
            let NERDTreeAutoDeleteBuffer = 1
            let NERDTreeMinimalUI = 1
            let NERDTreeWinSize = 50
            let g:NERDTreeMinimalMenu=1

            " Exit Vim if NERDTree is the only window remaining in the only tab.
            autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
            " Close the tab if NERDTree is the only window remaining in it.
            autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
        endif
    " }

    " JSON {
        nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
        let g:vim_json_syntax_conceal = 0
    " }

    " TagBar {
        if isdirectory(expand("~/.vim/plugged/tagbar/"))
            nnoremap <silent> <leader>ptt :TagbarToggle<CR>
        endif
    "}

    " Fugitive {
        if isdirectory(expand("~/.vim/plugged/vim-fugitive/"))
            nnoremap <silent> <leader>gs :Git<CR>
            nnoremap <silent> <leader>gd :Gdiff<CR>
            nnoremap <silent> <leader>gc :Gcommit<CR>
            nnoremap <silent> <leader>gb :Git blame<CR>
            nnoremap <silent> <leader>gl :Gclog<CR>
            nnoremap <silent> <leader>gh :0Gclog<CR>
        endif
    "}

    " UndoTree {
        if isdirectory(expand("~/.vim/plugged/undotree/"))
            nnoremap <Leader>u :UndotreeToggle<CR>
            " If undotree is opened, it is likely one wants to interact with it.
            let g:undotree_SetFocusWhenToggle=1
        endif
    " }

    " indentLine {
        if isdirectory(expand("~/.vim/plugged/indentLine/"))
            let g:indentLine_enabled = 0
            nmap <leader>il :IndentLinesToggle<CR>
        endif
    " }

    " lightline {
        let g:lightline = {
              \ 'colorscheme': 'seoul256',
          \ }
    " }
" }

" Syntax Group {
    augroup SyntaxSettings
        autocmd!
        autocmd BufNewFile,BufRead *.ts set filetype=typescript
        autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
    augroup END
" }

" General {
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8

    if has('clipboard')
        if has('unnamedplus')  " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else         " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif

    " Most prefer to automatically switch to the current file directory when
    " a new buffer is opened
    if 0
        autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
        " Always switch to the current file directory
    endif

    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    set hidden                          " Allow buffer switching without saving
    set iskeyword-=.                    " '.' is an end of word designator
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator
    set regexpengine=0
    set nospell
    set updatetime=1000

    " expand tabs to spaces
    set expandtab

    " Setting up the directories {
        set backup                  " Backups are nice ...
        if has('persistent_undo')
            set undofile                " So is persistent undo ...
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        endif
    " }

" }

" Vim UI {
    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    set cursorline                  " Highlight current line

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=%{fugitive#statusline()} " Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldlevel=3
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" }

" Formatting {

    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current

    " term config
    set shell=/bin/zsh
    " Remove trailing whitespaces and ^M chars
    autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> if 1 | call StripTrailingWhitespace() | endif
    "autocmd FileType go autocmd BufWritePre <buffer> Fmt
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
    autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
    " preceding line best in a plugin but here for now.

    " remove some autoformat options
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

    autocmd BufNewFile,BufRead *.coffee set filetype=coffee

    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Workaround broken colour highlighting in Haskell
    autocmd FileType haskell,rust setlocal nospell

    autocmd Filetype html setlocal ts=2 sts=2 sw=2
    autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
    autocmd BufRead,BufNewFile *.coffee setlocal ts=2 sts=2 sw=2
    autocmd BufRead,BufNewFile *.erb setlocal ts=2 sts=2 sw=2
    autocmd BufRead,BufNewFile *.scss setlocal ts=2 sts=2 sw=2
    autocmd BufRead,BufNewFile *.jst setlocal ts=2 sts=2 sw=2
    autocmd BufRead,BufNewFile *.eco setlocal ts=2 sts=2 sw=2
    autocmd BufRead,BufNewFile *.ejs setlocal ts=2 sts=2 sw=2
    autocmd BufRead,BufNewFile *.yml setlocal ts=2 sts=2 sw=2
    autocmd BufRead,BufNewFile *.vue setlocal ts=2 sts=2 sw=2
    autocmd BufRead,BufNewFile *.js setlocal ts=2 sts=2 sw=2
    autocmd BufRead,BufNewFile *.jsx setlocal ts=2 sts=2 sw=2
    autocmd BufRead,BufNewFile *.ts setlocal ts=2 sts=2 sw=2
    autocmd BufRead,BufNewFile *.tsx setlocal ts=2 sts=2 sw=2
    autocmd BufRead,BufNewFile *.mjs setlocal ts=2 sts=2 sw=2
    autocmd BufRead,BufNewFile *.css setlocal ts=2 sts=2 sw=2
    autocmd BufRead,BufNewFile *.html setlocal ts=2 sts=2 sw=2
    autocmd BufRead,BufNewFile *.json setlocal ts=2 sts=2 sw=2
    autocmd BufRead,BufNewFile *.tf setlocal ts=2 sts=2 sw=2
    autocmd BufRead,BufNewFile *.tfvars setlocal ts=2 sts=2 sw=2
    autocmd BufRead,BufNewFile *.prisma setlocal ts=2 sts=2 sw=2

    autocmd QuickFixCmdPost [^l]* nested cwindow
    autocmd QuickFixCmdPost    l* nested lwindow
" }

" Key (re)Mappings {
    " Easier moving in tabs and windows
    map <C-J> <C-W>j
    map <C-K> <C-W>k
    map <C-L> <C-W>l
    map <C-H> <C-W>h

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    " The following two lines conflict with moving to top and
    " bottom of the screen
    map <S-H> gT
    map <S-L> gt

    " Reorder tabs
    map <Leader>mtl :tabm -1<CR>
    map <Leader>mtr :tabm +1<CR>

    " Stupid shift key fixes
    if has("user_commands")
        command! -bang -nargs=* -complete=file E e<bang> <args>
        command! -bang -nargs=* -complete=file W w<bang> <args>
        command! -bang -nargs=* -complete=file Wq wq<bang> <args>
        command! -bang -nargs=* -complete=file WQ wq<bang> <args>
        command! -bang Wa wa<bang>
        command! -bang WA wa<bang>
        command! -bang Q q<bang>
        command! -bang QA qa<bang>
        command! -bang Qa qa<bang>
    endif

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Most prefer to toggle search highlighting rather than clear the current
    " search results.
    nmap <silent> <leader>/ :nohlsearch<CR>

    " Find merge conflict markers
    map <leader>mc /\v^[<\|=>]{7}( .*\|$)<CR>

    " Shortcuts
    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Allow using the repeat operator with a visual selection (!)
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Toggle cursorcolumn
    nmap <Leader>cc :set cursorcolumn!<cr>

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " Easier formatting
    nnoremap <silent> <leader>q gwip

    " copy to mac
    vmap <C-x> :w !pbcopy<CR><CR>

    " copy whole file
    map <C-x> :%y<CR>

    " copy current file name (relative/absolute) to system clipboard
    if has("mac") || has("gui_macvim") || has("gui_mac")
      " relative path  (src/foo.txt)
      nnoremap <leader>cfr :let @*=expand("%")<CR>
      " absolute path  (/something/src/foo.txt)
      nnoremap <leader>cfa :let @*=expand("%:p")<CR>
      " filename       (foo.txt)
      nnoremap <leader>cff :let @*=expand("%:t")<CR>
      " directory name (/something/src)
      nnoremap <leader>cfd :let @*=expand("%:p:h")<CR>
    endif
    " copy current file name (relative/absolute) to system clipboard (Linux version)
    if has("gui_gtk") || has("gui_gtk2") || has("gui_gnome") || has("unix")
      " relative path (src/foo.txt)
      nnoremap <leader>cfr :let @+=expand("%")<CR>
      " absolute path (/something/src/foo.txt)
      nnoremap <leader>cfa :let @+=expand("%:p")<CR>
      " filename (foo.txt)
      nnoremap <leader>cff :let @+=expand("%:t")<CR>
      " directory name (/something/src)
      nnoremap <leader>cfd :let @+=expand("%:p:h")<CR>
    endif

    " duplicate selection to below
    vmap <leader>d y'>p

" }

" Functions {
    " Initialize directories {
    function! InitializeDirectories()
        let parent = $HOME
        let prefix = 'vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif

        let common_dir = parent . '/.' . prefix

        for [dirname, settingname] in items(dir_list)
            let directory = common_dir . dirname . '/'
            if exists("*mkdir")
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo "Warning: Unable to create backup directory: " . directory
                echo "Try: mkdir -p " . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "g")
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()
    " }

    " Initialize NERDTree as needed {
    function! NERDTreeInitAsNeeded()
        redir => bufoutput
        buffers!
        redir END
        let idx = stridx(bufoutput, "NERD_tree")
        if idx > -1
            NERDTreeMirror
            NERDTreeFind
            wincmd l
        endif
    endfunction
    " }

    " Strip whitespace {
    function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction
    " }

    " Shell command {
    function! s:RunShellCommand(cmdline)
        botright new

        setlocal buftype=nofile
        setlocal bufhidden=delete
        setlocal nobuflisted
        setlocal noswapfile
        setlocal nowrap
        setlocal filetype=shell
        setlocal syntax=shell

        call setline(1, a:cmdline)
        call setline(2, substitute(a:cmdline, '.', '=', 'g'))
        execute 'silent $read !' . escape(a:cmdline, '%#')
        setlocal nomodifiable
        1
    endfunction

    command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
    " e.g. Grep current file for <search_term>: Shell grep -Hn <search_term> %
    " }

    function! s:ExpandFilenameAndExecute(command, file)
        execute a:command . " " . expand(a:file, ":p")
    endfunction
" }

" vimrc {
    " Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
    " }
" }
