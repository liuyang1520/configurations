# Description

This repo contains personal configuration files for local development environment

# Install (macOS)

## oh-my-zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

## Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Dependencies & Applications

- [iterm2](https://github.com/gnachman/iTerm2) - `brew install --cask iterm2`
  - Background color `22273E`
  - Ohmyzsh theme `dst` - `sed -i '' 's/^ZSH_THEME=.*/ZSH_THEME="dst"/' ~/.zshrc & source ~/.zshrc`
- [ghostty](https://ghostty.org/) - `brew install --cask ghostty`
- node, go - `brew install node go`
- [vim](https://github.com/vim/vim) - `brew install vim && brew link vim`
- [ag](https://github.com/ggreer/the_silver_searcher) - `brew install the_silver_searcher`
- [fzf](https://github.com/junegunn/fzf) - `brew install fzf`
- [bat](https://github.com/sharkdp/bat) - `brew install bat`
- [tmux](https://github.com/tmux/tmux) - `brew install tmux`
  - reattach-to-user-namespace - `brew install reattach-to-user-namespace`
- [lazygit](https://github.com/kdheepak/lazygit.nvim) - `brew install lazygit`

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
mkdir -p ~/.config/nvim && ln -sf ~/.liuyang1520-configurations/dotfiles/init.lua ~/.config/nvim/
ln -sf ~/.liuyang1520-configurations/dotfiles/.ctags.d ~/
ln -sf ~/.liuyang1520-configurations/dotfiles/.ignore ~/

mkdir -p ~/.config/ghostty && ln -sf ~/.liuyang1520-configurations/dotfiles/ghostty.config ~/.config/ghostty/config
```

#### VSCode/Cursor

```
ln -sf ~/.liuyang1520-configurations/dotfiles/.vscode/keybindings.json "$HOME/Library/Application Support/Cursor/User/keybindings.json"
ln -sf ~/.liuyang1520-configurations/dotfiles/.vscode/settings.json "$HOME/Library/Application Support/Cursor/User/settings.json"
```

### Update `.zshrc`

```
sed -i.bak '/^source \$ZSH\/oh-my-zsh\.sh/i\
source ~/.zshrc.local
' ~/.zshrc
```
