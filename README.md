# Description
This repo contains personal configuration files for local development environment

# Prerequisite
- git
- curl
- vim
- ack
- tmux

# Install
```bash
# install oh-my-zsh
sh -c “$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)”

# install spf13-vim
sh <(curl https://j.mp/spf13-vim3 -L)

# clone this repo
git clone https://github.com/liuyang1520/configurations.git  ~/.liuyang1520-configurations

# softlink dotfiles
ln -s ~/.liuyang1520-configurations/.tmux.conf ~/
ln -s ~/.liuyang1520-configurations/.tag ~/
ln -s ~/.liuyang1520-configurations/.ackrc ~/
ln -s ~/.liuyang1520-configurations/.vimrc.before.local ~/
ln -s ~/.liuyang1520-configurations/.vimrc.bundles.local ~/
ln -s ~/.liuyang1520-configurations/.vimrc.local ~/

# update vim plugins
vim +BundleInstall! +BundleClean +q
```
