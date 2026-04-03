# Dotfiles

Config files for Mac and WSL (Windows work environment).

## Contents

| Config | File |
|--------|------|
| Zsh | [shell/.zshrc](shell/.zshrc) |
| Aliases | [shell/.aliases](shell/.aliases) |
| Tmux | [shell/.tmux.conf](shell/.tmux.conf) |
| Git | [git/.gitconfig](git/.gitconfig) |
| Neovim | [nvim/init.lua](nvim/init.lua) |
| VSCode Settings | [vscode/settings.json](vscode/settings.json) |
| VSCode Keybindings | [vscode/keybindings.json](vscode/keybindings.json) |
| VSCode Extensions | [vscode/extensions.txt](vscode/extensions.txt) |

## Setup

### Mac / Linux
```bash
git clone git@github.com:dbsherry890/dotfiles.git ~/.dotfiles
chmod +x ~/.dotfiles/install.sh
~/.dotfiles/install.sh
```

### Windows (WSL)
```bash
git clone git@github.com:dbsherry890/dotfiles.git $HOME\.dotfiles
setx DOTFILES "$HOME\.dotfiles"
powershell -ExecutionPolicy Bypass -File .\dotfiles\install.ps1
```

## Notes

To update the VSCode extensions list:
```bash
code --list-extensions > ~/dotfiles/vscode/extensions.txt
```
