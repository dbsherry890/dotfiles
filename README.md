# Dotfiles

## Configs for NeoVim, Tmux, VSCode, Zsh, git

## Instructions
### Mac/Linux:
``` bash
git clone git@github.com:yourname/dotfiles.git ~/.dotfiles
~/.dotfiles/install.sh
```

### Windows 
``` bash
git clone git@github.com:yourname/dotfiles.git $HOME\.dotfiles
setx DOTFILES "$HOME\.dotfiles"
powershell -ExecutionPolicy Bypass -File .\dotfiles\install.ps1
```

#### Note
To rewrite list of extensions and update file: 
``` bash
code --list-extensions > ~/dotfiles/vscode/extensions.txt
```
