# Description
This repo contains personal configuration files for local development environment

# Preparation
- [MacOS](instructions/macos.md)
- [Linux](instructions/linux.md)

# Install
## oh-my-zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
red

## Configurations
### Clone this repo
```
git clone https://github.com/liuyang1520/configurations.git  ~/.liuyang1520-configurations
```

### Create softlinks
```
ln -sf ~/.liuyang1520-configurations/dotfiles/.zshrc.local ~/
if [[ "$(uname -s)" = Darwin ]]; then ln -sf ~/.liuyang1520-configurations/dotfiles/.tmux-osx.conf ~/.tmux.conf; else ln -sf ~/.liuyang1520-configurations/dotfiles/.tmux.conf ~/; fi
ln -sf ~/.liuyang1520-configurations/dotfiles/.vimrc ~/
ln -sf ~/.liuyang1520-configurations/dotfiles/.ctags.d ~/
ln -sf ~/.liuyang1520-configurations/dotfiles/.ignore ~/
```

### Update `.zshrc`
```
echo "source ~/.zshrc.local" >> ~/.zshrc
```

### Update vim plugins
```
# Install vim-plug
$ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
$ vim +PlugInstall +PlugClean! +q
```


# Screenshots
## tmux
![image](https://user-images.githubusercontent.com/8689754/49188903-97c0be00-f329-11e8-865d-11e5081a34fd.png)
