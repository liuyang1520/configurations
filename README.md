# Description
This repo contains personal configuration files for local development environment

# For new system
```
# set up new root password
$ sudo passwd root
# set up new hostname
$ sudo hostnamectl set-hostname <hostname>
$ sudo vim /etc/hosts
```

# Prerequisite
- git
- curl
- vim
- ~~~ack~~~
- ag
  - https://github.com/ggreer/the_silver_searcher
  - `brew install the_silver_searcher`
  - `apt-get install silversearcher-ag`
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
#ln -sf ~/.liuyang1520-configurations/dotfiles/.ackrc ~/
ln -sf ~/.liuyang1520-configurations/dotfiles/.vimrc.before.local ~/
ln -sf ~/.liuyang1520-configurations/dotfiles/.vimrc.bundles.local ~/
ln -sf ~/.liuyang1520-configurations/dotfiles/.vimrc.local ~/

# update vim plugins
vim +BundleInstall! +BundleClean +q
```
