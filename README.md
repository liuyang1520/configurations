# Description

This repo contains personal configuration files for local development environment.

# Setup

## Clone

```bash
git clone https://github.com/liuyang1520/configurations.git ~/.liuyang1520-configurations
```

## Initialize (recommended)

```bash
source ~/.liuyang1520-configurations/dotfiles/zshrc.local
dotfiles-setup --init
```

`dotfiles-setup --init` will:
- install oh-my-zsh if missing
- install Homebrew if missing
- install required brew dependencies if missing
- create/update all configuration symlinks
- ensure `source ~/.zshrc.local` is present in `~/.zshrc`

## Symlink only

```bash
source ~/.liuyang1520-configurations/dotfiles/zshrc.local
dotfiles-setup
```

## Optional auto setup on shell startup

```bash
export DOTFILES_AUTO_SETUP=symlink  # use init|symlink|off
source ~/.zshrc.local
```
