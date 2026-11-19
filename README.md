# Dotfiles

Config files for Mac (personal) and WSL Ubuntu (Windows work environment).

## Contents

| Config | File | Where |
|--------|------|-------|
| Aliases | [shell/.aliases](shell/.aliases) | both |
| Tmux | [shell/.tmux.conf](shell/.tmux.conf) | both |
| Git | [git/.gitconfig](git/.gitconfig) | both |
| Neovim | [nvim/init.lua](nvim/init.lua) | both |
| Zsh | [shell/.zshrc](shell/.zshrc) | Mac |
| VSCode | [vscode/](vscode/) | Mac (copy to Windows by hand) |
| Bash | [shell/.bashrc](shell/.bashrc) | WSL |

## Setup

Same on both machines — `install.sh` detects Mac vs WSL with `uname` and links the right files.
Existing non-symlink files are moved aside to `<file>.bak.<timestamp>`.

```bash
git clone git@github.com:dbsherry890/dotfiles.git ~/Dotfiles
~/Dotfiles/install.sh
```

## Per-machine files (not tracked)

- `~/.config/secrets/env.sh` — tokens (JIRA_TOKEN, etc.), sourced by `.bashrc`
- `~/.localrc` — one-off machine tweaks, sourced last by `.zshrc` / `.bashrc`
- `~/.gitconfig.local` — git overrides (e.g. work email). Linked from `git/work.gitconfig` on WSL if that file exists.

## VSCode

On the Mac, `install.sh` symlinks `vscode/settings.json` and `vscode/keybindings.json` into
`~/Library/Application Support/Code/User/`. Set `SKIP_VSCODE_EXTENSIONS=1` to skip installing extensions.

On Windows, copy them over from WSL when needed:
```bash
cp ~/Dotfiles/vscode/{settings,keybindings}.json /mnt/c/Users/DSHERRY/AppData/Roaming/Code/User/
```

To update the extensions list:
```bash
code --list-extensions > ~/Dotfiles/vscode/extensions.txt
```
