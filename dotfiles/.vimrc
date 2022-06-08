" =======================================
" This modification is based on spf13-vim
" =======================================

" Environment {
    " Identify platform {
        silent function! OSX()
            return has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return  (has('win32') || has('win64'))
        endfunction
    " }

    " Basics {
        set nocompatible        " Must be first line
        if !WINDOWS()
            set shell=/bin/sh
        endif
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if WINDOWS()
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }

    " Arrow Key Fix {
        " https://github.com/spf13/spf13-vim/issues/780
        if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
            inoremap <silent> <C-[>OC <RIGHT>
        endif
    " }

    " Global let, must be put in the beginning {
        let mapleader = ','
        let maplocalleader = '_'
    " }
" }

" Install plugins {
    " Environment {
        " Basics {
            set nocompatible        " Must be first line
            set background=dark     " Assume a dark background
        " }

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

        " Python
        Plug 'klen/python-mode'
        Plug 'yssource/python.vim'

        " javascript
        Plug 'pangloss/vim-javascript'
        Plug 'posva/vim-vue'
        Plug 'leafgarland/typescript-vim'
        Plug 'peitalin/vim-jsx-typescript'

        " json
        Plug 'elzr/vim-json'

        " html
        Plug 'hail2u/vim-css3-syntax'
        Plug 'tpope/vim-haml'
        Plug 'mattn/emmet-vim'
        Plug 'groenewege/vim-less'

        " colors
        Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

        " ruby
        Plug 'tpope/vim-rails'

        " golang
        Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

        " terraform
        Plug 'hashivim/vim-terraform'

        " markdown
        Plug 'tpope/vim-markdown'
        Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

        " other langs
        Plug 'rust-lang/rust.vim'

        " appearance
        Plug 'rafi/awesome-vim-colorschemes'
        Plug 'Yggdroot/indentLine'
        Plug 'mhinz/vim-signify'
        Plug 'osyo-manga/vim-over'

        " programming
        Plug 'tpope/vim-fugitive'
        Plug 'tpope/vim-commentary'
        if executable('ctags')
            Plug 'majutsushi/tagbar'
        endif

        " coc
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'antoinemadec/coc-fzf', {'branch': 'release'}

    call plug#end()
" }

" Plugins {

    " colorscheme {
        colorscheme gruvbox
        set background=dark         " Assume a dark background
    " }

    " GoLang {
        let g:go_highlight_functions = 1
        let g:go_highlight_methods = 1
        let g:go_highlight_structs = 1
        let g:go_highlight_operators = 1
        let g:go_highlight_build_constraints = 1
        let g:go_fmt_command = "goimports"
        "let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
        "let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
        "au FileType go nmap <Leader>s <Plug>(go-implements)
        "au FileType go nmap <Leader>i <Plug>(go-info)
        "au FileType go nmap <Leader>e <Plug>(go-rename)
        "au FileType go nmap <leader>r <Plug>(go-run)
        "au FileType go nmap <leader>b <Plug>(go-build)
        "au FileType go nmap <leader>t <Plug>(go-test)
        "au FileType go nmap <Leader>gd <Plug>(go-doc)
        "au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
        "au FileType go nmap <leader>co <Plug>(go-coverage)
    " }

    " coc {
        let g:coc_disable_transparent_cursor = 1
        let g:coc_global_extensions = ['coc-tsserver', 'coc-prettier']
        let g:coc_user_config = {
              \   "list.maxPreviewHeight": 24,
              \ }
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

    " FZF {
        nnoremap <silent> <C-p> :Files<CR>
        nnoremap <silent> <Leader>f :Files<CR>
        nnoremap <silent> <Leader>F :Files!<CR>
        nnoremap <silent> <Leader>h :History<CR>
        nnoremap <silent> <Leader>H :History!<CR>
        nnoremap <silent> <Leader>w :Windows<CR>
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

    " Ctags {
        set tags=./tags;/,~/.vimtags

        " Make tags placed in .git/tags file available in all levels of a repository
        let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
        if gitroot != ''
            let &tags = &tags . ',' . gitroot . '/.git/tags'
        endif
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
        endif
    " }

    " JSON {
        nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
        let g:vim_json_syntax_conceal = 0
    " }

    " PyMode {
        " Disable if python support not present
        if !has('python') && !has('python3')
            let g:pymode = 0
        endif

        if isdirectory(expand("~/.vim/plugged/python-mode"))
            let g:pymode_lint_checkers = ['pyflakes']
            let g:pymode_trim_whitespaces = 0
            let g:pymode_options = 0
            let g:pymode_rope = 0
            let g:pymode_breakpoint = 0
        endif
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
            nnoremap <silent> <leader>gp :Git push<CR>
            nnoremap <silent> <leader>gr :Gread<CR>
            nnoremap <silent> <leader>gw :Gwrite<CR>
            nnoremap <silent> <leader>ge :Gedit<CR>
            " Mnemonic _i_nteractive
            nnoremap <silent> <leader>gi :Git add -p %<CR>
            nnoremap <silent> <leader>gg :SignifyToggle<CR>
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

    " vim-hexokinase {
        set termguicolors
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        let g:Hexokinase_highlighters = ['backgroundfull']
    " }

    " lightline {
        let g:lightline = {
              \ 'colorscheme': 'gruvbox',
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
    " if !has('gui')
        "set term=$TERM          " Make arrow and other keys work
    " endif
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

    "set autowrite                       " Automatically write a file when leaving a modified buffer
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

    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

    augroup resCur
        autocmd!
        autocmd BufWinEnter * call ResCur()
    augroup END

    " Setting up the directories {
        set backup                  " Backups are nice ...
        if has('persistent_undo')
            set undofile                " So is persistent undo ...
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        endif

        " Add exclusions to mkview and loadview
        " eg: *.*, svn-commit.tmp
        let g:skipview_files = [
            \ '\[example pattern\]'
            \ ]
    " }

" }

" Vim UI {
    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    set cursorline                  " Highlight current line

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    "highlight clear CursorLineNr    " Remove highlight color from current line number

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
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    "set matchpairs+=<:>             " Match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    " term config
    set shell=/bin/zsh
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
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

    " Map g* keys in Normal, Operator-pending, and Visual+select
    noremap $ :call WrapRelativeMotion("$")<CR>
    noremap <End> :call WrapRelativeMotion("$")<CR>
    noremap 0 :call WrapRelativeMotion("0")<CR>
    noremap <Home> :call WrapRelativeMotion("0")<CR>
    noremap ^ :call WrapRelativeMotion("^")<CR>
    " Overwrite the operator pending $/<End> mappings from above
    " to force inclusive motion with :execute normal!
    onoremap $ v:call WrapRelativeMotion("$")<CR>
    onoremap <End> v:call WrapRelativeMotion("$")<CR>
    " Overwrite the Visual+select mode mappings from above
    " to ensure the correct vis_sel flag is passed to function
    vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
    vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
    vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
    vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
    vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>

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

    cmap Tabe tabe

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

    " Some helpers to edit mode
    " http://vimcasts.org/e/14
    cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
    map <leader>ew :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%

    " Toggle cursorcolumn
    nmap <Leader>cc :set cursorcolumn!<cr>

    " Toggle background dark and light
    nmap <leader>cbg :call ToggleBG()<CR>

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " Easier formatting
    nnoremap <silent> <leader>q gwip

    " FIXME: Revert this f70be548
    " fullscreen mode for GVIM and Terminal, need 'wmctrl' in you PATH
    map <silent> <F11> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>

    " copy to mac
    vmap <C-x> :w !pbcopy<CR><CR>

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

" }

" GUI Settings {
    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        set guioptions-=T           " Remove the toolbar
        set lines=40                " 40 lines of text instead of 24
        if LINUX() && has("gui_running")
            set guifont=Andale\ Mono\ Regular\ 12,Menlo\ Regular\ 11,Consolas\ Regular\ 12,Courier\ New\ Regular\ 14
        elseif OSX() && has("gui_running")
            set guifont=Andale\ Mono\ Regular:h12,Menlo\ Regular:h11,Consolas\ Regular:h12,Courier\ New\ Regular:h14
        elseif WINDOWS() && has("gui_running")
            set guifont=Andale_Mono:h10,Menlo:h10,Consolas:h10,Courier_New:h10
        endif
    else
        if &term == 'xterm' || &term == 'screen'
            set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
        endif
        "set term=builtin_ansi       " Make arrow and other keys work
    endif

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

    " End/Start of line motion keys act relative to row/wrap width in the
    " presence of `:set wrap`, and relative to line for `:set nowrap`.
    " Default vim behaviour is to act relative to text line in both cases
    " Same for 0, home, end, etc
    function! WrapRelativeMotion(key, ...)
        let vis_sel=""
        if a:0
            let vis_sel="gv"
        endif
        if &wrap
            execute "normal!" vis_sel . "g" . a:key
        else
            execute "normal!" vis_sel . a:key
        endif
    endfunction

    " http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
    " Restore cursor to file position in previous editing session
    function! ResCur()
        if line("'\"") <= line("$")
            silent! normal! g`"
            return 1
        endif
    endfunction

    " Allow to trigger background
    function! ToggleBG()
        let s:tbg = &background
        " Inversion
        if s:tbg == "dark"
            set background=light
        else
            set background=dark
        endif
    endfunction
" }

" vimrc {
    " Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
    " }
" }
