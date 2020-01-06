# Linux
## Prerequisite
### Config package manager
```
$ echo "deb http://ftp.de.debian.org/debian testing main" | sudo tee -a /etc/apt/sources.list
```
This adds another source URL for fetching newer packages, comparing to the default one.

### Install packages
- [vim](https://github.com/vim/vim) - `sudo apt-get -t testing install vim`
- [ag](https://github.com/ggreer/the_silver_searcher) - `sudo apt-get -t testing install silversearcher-ag`
- [fzf](https://github.com/junegunn/fzf) - `sudo apt-get -t testing install fzf`
- [highlight](http://www.andre-simon.de/doku/highlight/en/highlight.php) - `sudo apt-get -t testing install highlight`
- [ctags](https://github.com/universal-ctags/ctags) - `sudo apt-get -t testing install universal-ctags`
- [tmux](https://github.com/tmux/tmux) - `sudo apt-get -t testing install tmux`
  - xclip (Linux) - `sudo apt-get -t testing install xclip`
- zsh
    ```
    sudo apt-get -t testing install zsh
    sudo chsh $USER -s $(which zsh)
    ```
