# Description
This repo contains personal configuration files for local development environment

# Preparation
[MacOS](macos.md)
[Linux](linux.md)

# Install
## oh-my-zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

## spf13-vim
```bash
sh <(curl https://j.mp/spf13-vim3 -L)
```

## Configurations
```bash
# clone this repo
git clone https://github.com/liuyang1520/configurations.git  ~/.liuyang1520-configurations

# softlink dotfiles
ln -sf ~/.liuyang1520-configurations/dotfiles/.zshrc.local ~/
if [[ "$(uname -s)" = Darwin ]]; then ln -sf ~/.liuyang1520-configurations/dotfiles/.tmux-osx.conf ~/.tmux.conf; else ln -sf ~/.liuyang1520-configurations/dotfiles/.tmux.conf ~/; fi
ln -sf ~/.liuyang1520-configurations/dotfiles/.vimrc.before.local ~/
ln -sf ~/.liuyang1520-configurations/dotfiles/.vimrc.bundles.local ~/
ln -sf ~/.liuyang1520-configurations/dotfiles/.vimrc.local ~/
ln -sf ~/.liuyang1520-configurations/dotfiles/.ctags.d ~/

# append `.zshrc.local`
echo "source ~/.zshrc.local" >> ~/.zshrc

# update vim plugins
vim +BundleInstall! +BundleClean +q
```


# Screenshots
## tmux
![image](https://user-images.githubusercontent.com/8689754/49188903-97c0be00-f329-11e8-865d-11e5081a34fd.png)
