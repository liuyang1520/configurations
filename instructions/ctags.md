tags

#### Install Ctags
Note `Xcode` has its own `ctags`, which is the default one in Mac OS.
```
$ brew install ctags
$ alias ctags="`brew --prefix`/bin/ctags"
```

#### Run Ctags
##### Common
```
$ ctags -R --exclude=.git --exclude=log .
```

##### Ruby
```
$ ctags -R --languages=ruby --exclude=.git --exclude=log --append .

~/.tag config file:
--recurse=yes
--exclude=.git
--exclude=log
--languages=ruby
--append
```

##### Node
```
$ ctags -R --exclude=.git --exclude=node_modules --exclude=test .

~/.tag config file:
--recurse=yes
--exclude=.git
--exclude=vendor/*
--exclude=node_modules/*
--exclude=db/*
--exclude=log/*
```

##### Add to .gitignore
```
echo "tags" >> ~/.gitignore_global
git config --global core.excludesfile $HOME/.gitignore_global
```

##### Git Hooks
```
$ git config --global init.templatedir '~/.git_template'
$ mkdir -p ~/.git_template/hooks
```

Put in ~/.git_template/hooks/ctags file
```bash
#!/bin/sh
set -e
PATH="/usr/local/bin:$PATH"
dir="`git rev-parse --git-dir`"
trap 'rm -f "$dir/$$.tags"' EXIT
git ls-files | \
  ctags --tag-relative -L - -f"$dir/$$.tags" --languages=-javascript,sql
mv "$dir/$$.tags" "$dir/tags"
```

Make it excutable
```
$ chmod +x ~/.git_template/hooks/ctags
```

Create hook files `post-commit`, `post-merge`, `post-checkout` under `~/.git_template/hooks/`
```bash
#!/bin/sh
.git/hooks/ctags >/dev/null 2>&1 &
```

Make hook files excutable
```
$ chmod +x ~/.git_template/hooks/post-*
```

Re-init the git repo
```
$ cd ~/git-repo-dir
$ git init
```

#### Navigation
`ctrl` + `]` to goto the definition

`g]` use tselect to open a list of definitions

`ctrl` + `t` to go back

`ctrl` + `w` + `}` to preview tag content, then `ctrl + w + o` to keep current buffer only

`:tag tagname` jump to tag by name

`:tags` show tags history

`:pop` or `:tag` `[count]` to trace through tag stack

#### Tags List
`:tag /^abc*` search tags start with "abc"

`:ts[elect]` show list

`:tn[ext]` go next tag

`:tp[rev]` go previous tag

`:tf[irst]` go first tag

`:tl[ast]` go last tag

#### Tagbar
`,tt` to open tagbar
`p` jump to tag under the cursor, stay in the tagbar window
`P` open tag in preview window
`<Space>` display prototype of the current tag
`+` `-` unfold and fold
`s` sort tags
