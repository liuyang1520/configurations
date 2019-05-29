### Ignore watching/tracking a particular dir/file
[Ignore file changes with Git](https://docs.microsoft.com/en-us/azure/devops/repos/git/ignore-files?view=azure-devops&tabs=visual-studio&viewFallbackFrom=vsts)
- assume unchange
```
git update-index --assume-unchanged <file>
git update-index --skip-worktree <file>
```
- revert assume unchange
```
git update-index --no-assume-unchanged <file>
git update-index --no-skip-worktree <file>
```
- list assume unchange files
```
git ls-files -v | grep '^h'
git ls-files -v | grep '^S'
```

### Delete all local branches except `master`
`git branch | grep -v "master" | xargs git branch -D`

### Delete all remote branches that have already been merged into `master`
```
$ git branch -r --merged | 
  grep origin | 
  grep -v '>' | 
  grep -v master | 
  xargs -L1 | 
  awk '{split($0,a,"/"); print a[2]}' | 
  xargs git push origin --delete
```

### Empty commit to trigger Jenkins build
```
$ git commit --allow-empty -m "Trigger jenkins build"
```

### Deleted files
```
# list deleted files
$ git ls-files --deleted
# revert deleted file
$ git checkout -- <file>
```

### Rebase/squash commits
```
# interactively
$ git rebase --interactive HEAD~n
# non-interactively
$ git reset --soft HEAD~n
$ git commit --amend
```

### Stash
```
# list stashes
$ git stash list
# show file changes
$ git stash show
# show change contents
$ git stash show -p
# show arbitrary changes
$ git stash show -p stash@{1}
```
