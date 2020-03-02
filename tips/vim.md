### Delete line from beginning to cursor
- `d0`, deletes from beginning
- `d^`, deletes from non-whitespace beginning

### Close splits in window
#### Keep current split only
- `:on`
- `:only`
- `ctrl-w` `ctrl-o`
- `ctrl-w` `o`
#### Close a split
- `ctrl-w` `q`
- `:q`

### Change split size
#### Width
- `ctrl-w <` decrease
- `ctrl-w >` increase

#### Height
- `ctrl-w -` decrease
- `ctrl-w +` increase

### Open in new split
#### File
- `ctrl-w f`
- `ctrl-w F`

#### Tag
- `ctrl-w ]`
- `ctrl-w g]`

#### Alternate file
- `ctrl-w ^`

### Open in new tab
#### File
- `ctrl-w gf`
- `ctrl-w gF`

### Non-space word motion
- `W`
- `E`
- `B`

### Navigation with search
- `v/abc`, select until search match position
- `v/abc ↵ n`, select until next search match position

### Auto complete
- `ctrl-xf` filenames
- `ctrl-xn` just this file
- `ctrl-n`/`ctrl-p` hint

### Replace text
- `shift + r`

### Join two lines
- `J`

### Increate/decrease a number
- `ctrl-a` increase
- `ctrl-x` decrease

### Fix line indent
- `==`

### ctrl-r in insert/command mode
- `a - z` the named registers
- `"` the unnamed register, containing the text of the last delete or yank
- `%` the current file name
- `#` the alternate file name
- `*` the clipboard contents (X11: primary selection)
- `+` the clipboard contents
- `/` the last search pattern
- `:` the last command-line
- `.` the last inserted text
- `-` the last small (less than a line) delete
- `=5*5` insert 25 into text (mini-calculator)

### Last position
- `g;` go to last position
- `gi` go to last position and insert

### Cursorcolumn
- `set cursorcolumn`
- `set nocursorcolumn`

### Navigation blocks
- `[ + {(<` go to previous `{(<`
- `] + }` go to next `}`
- `[[`
- `{{`
- `((`

### Folding
```
set foldmethod=
manual		manually define folds
indent		more indent means a higher fold level
expr		  specify an expression to define folds
syntax		folds defined by syntax highlighting
diff		  folds for unchanged text
marker		folds defined by markers in the text

zfa(      folds a ()
:mkview   save foldings
:loadview load foldings
```

### Append at end of line
`A`

### Backspace
`X`

### Search current word in file
```
#   search whole word up
g#  search word up
*   search whole word down
g*  search word down
```

### Search visual selection in file
1. `y` (yank the selected text, into the " register by default)
2. `/` (enter search mode)
3. `(\ V)` (optional, enter "plain text instead of as a regex" mode)
4. `Ctrl+r "` (insert text from " register)
5. `Enter`

### Case
```
~   Toggle case (Case => cASE)
gU  Uppercase
gu  Lowercase
gUU Uppercase current line (also gUgU)
guu Lowercase current line (also gugu)
```
