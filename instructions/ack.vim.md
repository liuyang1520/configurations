# Ack.vim Notes
###### tags: `study` `notes`

## Installation
`brew install ack` to install ack search tool

Add `ack` to vim vundle, spf13 install it by default if `ack` tool is already installed.

`:PluginInstall` in vim

## Config `~/.ackrc`
```
--ignore-dir=.idea/
--ignore-dir=node_modules/

--ignore-dir=vendor
--ignore-dir=log
--ignore-dir=tmp

--ignore-file=is:.byebug_history
```

## Operations
```
:Ack [options] {pattern} [{directories}]

?    a quick summary of these keys, repeat to close
o    to open (same as Enter)
O    to open and close the quickfix window
go   to preview file, keeping focus on the results
t    to open in new tab
T    to open in new tab, keeping focus on the results
h    to open in horizontal split
H    to open in horizontal split, keeping focus on the results
v    to open in vertical split
gv   to open in vertical split, keeping focus on the results
q    to close the quickfix window
```

## Tabs
### Open files in separate tabs
```
vim -p first.txt second.txt

:tabedit {file}   edit specified file in a new tab
                  alias: :tabnew {file} / :tabe {file}
:tabfind {file}   open a new tab with filename given, searching the 'path' to find it
:tabclose         close current tab
:tabclose {i}     close i-th tab
:tabo[nly]        close all other tabs (show only the current tab)

:tab ball         show each buffer in a tab (up to 'tabpagemax' tabs)
:tab help         open a new help window in its own tab page
:tab drop {file}  open {file} in a new tab, or jump to a window/tab containing the file if there is one
:tab split        copy the current window to a new tab of its own
```

Note only need to type enough characters for Vim to identify it, which means, `:tabe` is `:tabedit`.

### Navigation
```
:tabs         list all tabs including their displayed windows
:tabm 0       move current tab to first
:tabm         move current tab to last
:tabm {i}     move current tab to position i+1

:tabn         go to next tab
:tabp         go to previous tab
:tabfirst     go to first tab
:tablast      go to last tab

gt            go to next tab
gT            go to previous tab
{i}gt         go to tab in position i
```
