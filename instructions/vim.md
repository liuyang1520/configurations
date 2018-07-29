# Vim Notes
###### tags: `study` `notes`

## Key mapping
[https://hea-www.harvard.edu/~fine/Tech/vi.html](https://hea-www.harvard.edu/~fine/Tech/vi.html)

## spf13
### Configuration
Prevent Vim changes directory automatically
```bash
echo "let g:spf13_no_autochdir = 1" >> ~/.vimrc.before.local
rm -r ~/.vimviews
echo colorscheme molokai_dark >> ~/.vimrc.local
```

`~/.vimrc.before.local` file
```
" specify which plugin groups I will use
let g:spf13_bundle_groups=['general', 'writing', 'programming', 'ruby', 'python', 'javascript', 'html', 'misc']

" need to re-define leader key here
let mapleader = ','

" disable auto change dir option
let g:spf13_no_autochdir = 1

" disable auto tag completion
let g:AutoPairs = {}

" expand tabs to spaces
set expandtab

autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd BufRead,BufNewFile *.coffee setlocal ts=2 sts=2 sw=2
autocmd BufRead,BufNewFile *.erb setlocal ts=2 sts=2 sw=2
autocmd BufRead,BufNewFile *.scss setlocal ts=2 sts=2 sw=2
autocmd BufRead,BufNewFile *.jst setlocal ts=2 sts=2 sw=2
autocmd BufRead,BufNewFile *.eco setlocal ts=2 sts=2 sw=2
autocmd BufRead,BufNewFile *.vue setlocal ts=2 sts=2 sw=2

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" copy to mac
vmap <C-x> :w !pbcopy<CR><CR>

" ack shortcut
cnoreabbrev Ack Ack!
nnoremap <Leader>b :Ack!<CR>
vnoremap <Leader>b y:Ack! <C-r>=fnameescape(@")<CR><CR>
```

`~/.vimrc.local` file
```
" colorscheme molokai_dark
colorscheme default

" turn off spell check
set nospell
```

`~/.vimrc.bundles.local` file
```
Plugin 'posva/vim-vue'
UnBundle 'vim-colorschemes'
```

`$ vim +BundleInstall! +BundleClean +q`
`:PluginUpdate`

## Basic Operations
### Text Object
word only contains letters, digits, underscore, and etc.
WORD consists of a sequence of non-blank characters, separated with white spaces

`aw` a word
`aW` a WORD
`iw` inner word
`iW` inner WORD
`as` sentence
`ap` paragraph
`a[` or `a[` []
`a(` or `a)` ()
`a{` or `a}` {}
`a>` or `a<` <>
`at` tag block
`ab` block
`a'` single quote block
`a”` double quote block
`\`` \` quote block

`ai` indent block
`ii` indent block

### Delete
`dw` deletes a word starting from the cursor to the word end
`dW` deletes a whole word including special characters, split by spaces
`de / dE` are similar
`daw` deletes a word under the cursor and spaces after it
`diw` deletes a inner word no separators
`b + dw` should be the same as `dw`
`dt<c>` deletes till `<c>` character
`df<c>` deletes tile `<c>` character, include `<c>`

### Search
#### Locally
`/abc` to search "abc" in open file, `n` to next, `N` to previous
`#`, `*` to search current word and navigate

#### Globally
`:grep -r --include=*.rb app` to search all ruby files in "app" directory recursively
`:grep!` to prevent grep open the first mateched file
`:grep 'abc' app/**/*.rb` should do the same trick, however, it may miss some file depending on the system, so **do not use this**
`:copen`, `:cw[indow]` to open Quickfix window

### Indentation
#### Set Indentation Values
```
# by default, the indent is 2 spaces. 
set shiftwidth=2
set softtabstop=2
set tabstop=2

# for html/rb files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab

# for js/coffee/jade files, 4 spaces
autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype coffeescript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype jade setlocal ts=4 sw=4 sts=0 expandtab
```

#### Operations
```
>>   Indent line by shiftwidth spaces
<<   De-indent line by shiftwidth spaces
5>>  Indent 5 lines
5==  Re-indent 5 lines

>%   Increase indent of a braced or bracketed block (place cursor on brace first)
=%   Reindent a braced or bracketed block (cursor on brace)
<%   Decrease indent of a braced or bracketed block (cursor on brace)
]p   Paste text, aligning indentation with surroundings

=i{  Re-indent the 'inner block', i.e. the contents of the block
=a{  Re-indent 'a block', i.e. block and containing braces
=2a{ Re-indent '2 blocks', i.e. this block and containing block

>i{  Increase inner block indent
<i{  Decrease inner block indent
```

In insert mode
```
ctrl+t    to indent
ctrl+d    to reverse-indent
```


## Buffer
### Add a buffer
```
:badd f1.txt
:badd f2.txt
```

### Delete a buffer
```
:bdelete f1.txt
:bd[elete] 4
```

### Delete multiple buffers
```
:bdelete buf1.txt buf2.c buf3.h
:bdelete buf
```

### Wipeout a buffer
```
:bw[ipeout] 4
```

### Navigate between buffers
```
:ls         - list open buffers
:b N        - open buffer number N (as shown in ls)
:tabe +Nbuf - open buffer number N in new tab
:bnext      - go to the next buffer (:bn also)
:bprevious  - go to the previous buffer (:bp also)
```


## NERDTree
### Toggle NERDTree
`,e`

### Operations
```
o.......Open files, directories and bookmarks....................|NERDTree-o|
go......Open selected file, but leave cursor in the NERDTree.....|NERDTree-go|
t.......Open selected node/bookmark in a new tab.................|NERDTree-t|
T.......Same as 't' but keep the focus on the current tab........|NERDTree-T|
i.......Open selected file in a split window.....................|NERDTree-i|
gi......Same as i, but leave the cursor on the NERDTree..........|NERDTree-gi|
s.......Open selected file in a new vsplit.......................|NERDTree-s|
gs......Same as s, but leave the cursor on the NERDTree..........|NERDTree-gs|
O.......Recursively open the selected directory..................|NERDTree-O|
x.......Close the current nodes parent...........................|NERDTree-x|
X.......Recursively close all children of the current node.......|NERDTree-X|
e.......Edit the current dir.....................................|NERDTree-e|

<CR>...............same as |NERDTree-o|.
double-click.......same as the |NERDTree-o| map.
middle-click.......same as |NERDTree-i| for files, same as
                   |NERDTree-e| for dirs.

D.......Delete the current bookmark .............................|NERDTree-D|

P.......Jump to the root node....................................|NERDTree-P|
p.......Jump to current nodes parent.............................|NERDTree-p|
K.......Jump up inside directories at the current tree depth.....|NERDTree-K|
J.......Jump down inside directories at the current tree depth...|NERDTree-J|
<C-J>...Jump down to the next sibling of the current directory...|NERDTree-C-J|
<C-K>...Jump up to the previous sibling of the current directory.|NERDTree-C-K|

C.......Change the tree root to the selected dir.................|NERDTree-C|
u.......Move the tree root up one directory......................|NERDTree-u|
U.......Same as 'u' except the old root node is left open........|NERDTree-U|
r.......Recursively refresh the current directory................|NERDTree-r|
R.......Recursively refresh the current root.....................|NERDTree-R|
m.......Display the NERD tree menu...............................|NERDTree-m|
cd......Change the CWD to the dir of the selected node...........|NERDTree-cd|
CD......Change tree root to the CWD..............................|NERDTree-CD|

I.......Toggle whether hidden files displayed....................|NERDTree-I|
f.......Toggle whether the file filters are used.................|NERDTree-f|
F.......Toggle whether files are displayed.......................|NERDTree-F|
B.......Toggle whether the bookmark table is displayed...........|NERDTree-B|

q.......Close the NERDTree window................................|NERDTree-q|
A.......Zoom (maximize/minimize) the NERDTree window.............|NERDTree-A|
?.......Toggle the display of the quick help.....................|NERDTree-?|
```

### Commands
```
:NERDTreeFind                                                  *:NERDTreeFind*
    Find the current file in the tree.

    If no tree exists and the current file is under vim's CWD, then init a
    tree at the CWD and reveal the file. Otherwise init a tree in the current
    file's directory.

    In any case, the current file is revealed and the cursor is placed on it.

:NERDTreeCWD                                                    *:NERDTreeCWD*
    Change tree root to current directory. If no NERD tree exists for this
    tab, a new tree will be opened.
```


## ctrlp
### Basic
```
* Run `:CtrlP` or `:CtrlP [starting-directory]` to invoke CtrlP in find file mode.
* Run `:CtrlPBuffer` or `:CtrlPMRU` to invoke CtrlP in find buffer or find MRU file mode.
* Run `:CtrlPMixed` to search in Files, Buffers and MRU files at the same time.
```

### Operations
```
* Press `<F5>` to purge the cache for the current directory to get new files, remove deleted files and apply new ignore options.
* Press `<c-f>` and `<c-b>` to cycle between modes.
* Press `<c-d>` to switch to filename only search instead of full path.
* Press `<c-r>` to switch to regexp mode.
* Use `<c-j>`, `<c-k>` or the arrow keys to navigate the result list.
* Use `<c-t>` or `<c-v>`, `<c-x>` to open the selected entry in a new tab or in a new split.
* Use `<c-n>`, `<c-p>` to select the next/previous string in the prompt's history.
* Use `<c-y>` to create a new file and its parent directories.
* Use `<c-z>` to mark/unmark multiple files and `<c-o>` to open them.
```


## Undotree
### Basic
`<leader> + u`

### Operations
`D` show diff


## Fugitive
### Commands
- `:Gstatus` to view `git status`
- `:Gdiff` to view `git diff`

### Operations
 * `<leader>gs` :Gstatus<CR>
 * `<leader>gd` :Gdiff<CR>
 * `<leader>gc` :Gcommit<CR>
 * `<leader>gb` :Gblame<CR>
 * `<leader>gl` :Glog<CR>
 * `<leader>gp` :Git push<CR>
 * `<leader>gw` :Gwrite<CR>
 * :Git xxx will pass anything along to git.


## Spell Check
### Set spell check globally / only this buffer
```
:set spell spelllang=en_us
:setlocal spell spelllang=en_us
:set nospell
```

### Navigate between misspelled words
```
[s
]s
```

### Use dictionary
`z=` suggests a list of alternatives
`zg` adds current word as good word to dictionary
`zw` adds current word as wrong word to dictionary


## Useful Commands
### Paste mode
```
:set paste
:set nopaste
set pastetoggle=<F3></F>
```

### Turn off search highlighting
`:noh`

### Paste into Mac OS
- Select in visual mode then `:w !pbcopy`
- Copy whole file `:%w !pbcopy`

### New window
`ctrl` + `w` then press `v`

### Show file path
`ctrl` + 'g' show relative path
`1` + `ctrl g` show full path

### Command history
`q:`

### Delete without copy/cut
- `"_d` will do the trick
- `"_daw` delete a word only
- `"0p` copy from yank register

### Delete a block
1. `ma` add mark `a` to starting line, go to last line, `d'a` delete to mark `a`
2. `dii` or `dai`

### Delete all tabs
- `:qa` to quit all
- `:wqa` to save and quit all

### Goto file under cursor
```
gf      open in the same window ("goto file")
<c-w>f  open in a new window (Ctrl-w f)
<c-w>gf open in a new tab (Ctrl-w gf)

ctrl + o    to return back
ctrl + i    to go forward
```

### Repeat last t/f command
```
;    repeat last "f", "F", "t", or "T" command
```

### Window operations
```
<c-w>T        split to tab
<c-w>_        maxmize within current tab
<c-w>=        resize all windows to equal size
<c-w>H,J,K,L  move tab to left/down/up/right
```

### Reload buffers/windows
```
:windo e    reload all windows
:bufdo e    reload all buffers
:tabdo e    reload all tabs
```

### Reverse search char
```
F        reverse of f
T        reverse of t
```

### Goto line
```
:50
50G
```

### Open files from last commit
```
$ vim -p `git diff --name-only HEAD^`
```

### Command in Insert Mode
```
<c-o> o    new line
<c-o> e    move to end of word
```
`<c-o>` + command, will execute command in insert mode

### Macros
```
q{0-9a-zA-Z"}    enter recording
q                quit recording
@{0-9a-z".=*}    Execute the contents of [register]
:reg             output a list of [register] content
```
