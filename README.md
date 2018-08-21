# Description
This repo contains personal configuration files for local development environment

# Prerequisite
- git
- curl
- vim
- ack
- tmux
  - xclip (Linux)
  - reattach-to-user-namespace (Mac OS)

# Install
```bash
# install oh-my-zsh
apt-get install zsh
sudo chsh $USER -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install spf13-vim
sh <(curl https://j.mp/spf13-vim3 -L)

# clone this repo
git clone https://github.com/liuyang1520/configurations.git  ~/.liuyang1520-configurations

# softlink dotfiles
if [[ "$(uname -s)" = Darwin ]]; then ln -sf ~/.liuyang1520-configurations/dotfiles/.tmux-osx.conf ~/.tmux.conf; else ln -sf ~/.liuyang1520-configurations/dotfiles/.tmux.conf ~/; fi
ln -sf ~/.liuyang1520-configurations/dotfiles/.tag ~/
ln -sf ~/.liuyang1520-configurations/dotfiles/.ackrc ~/
ln -sf ~/.liuyang1520-configurations/dotfiles/.vimrc.before.local ~/
ln -sf ~/.liuyang1520-configurations/dotfiles/.vimrc.bundles.local ~/
ln -sf ~/.liuyang1520-configurations/dotfiles/.vimrc.local ~/

# update vim plugins
vim +BundleInstall! +BundleClean +q
```
