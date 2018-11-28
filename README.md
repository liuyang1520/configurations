# Description
This repo contains personal configuration files for local development environment

# For new system
```
# set up new root password
$ sudo passwd root

# set up new hostname
$ sudo hostnamectl set-hostname <hostname>
$ sudo vim /etc/hosts

# change zsh theme
$ vim .zshrc (dst theme)
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
- fzf
- highlight
  - brew install highlight
- tmux
  - xclip (Linux)
  - reattach-to-user-namespace (Mac OS)

# Install NodeJS NPM in Crostini
```
$ sudo apt-get update
$ sudo apt-get install curl gnupg -y
$ curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
$ sudo apt-get install -y nodejs
```

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
ln -sf ~/.liuyang1520-configurations/dotfiles/.zshrc.local ~/
if [[ "$(uname -s)" = Darwin ]]; then ln -sf ~/.liuyang1520-configurations/dotfiles/.tmux-osx.conf ~/.tmux.conf; else ln -sf ~/.liuyang1520-configurations/dotfiles/.tmux.conf ~/; fi
ln -sf ~/.liuyang1520-configurations/dotfiles/.tag ~/
#ln -sf ~/.liuyang1520-configurations/dotfiles/.ackrc ~/
ln -sf ~/.liuyang1520-configurations/dotfiles/.vimrc.before.local ~/
ln -sf ~/.liuyang1520-configurations/dotfiles/.vimrc.bundles.local ~/
ln -sf ~/.liuyang1520-configurations/dotfiles/.vimrc.local ~/

# append `.zshrc.local`
echo "source ~/.zshrc.local" >> ~/.zshrc

# update vim plugins
vim +BundleInstall! +BundleClean +q
```

# Screenshots
## tmux
![image](https://user-images.githubusercontent.com/8689754/49188903-97c0be00-f329-11e8-865d-11e5081a34fd.png)
