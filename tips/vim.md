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
