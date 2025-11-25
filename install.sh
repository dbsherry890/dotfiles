#!/usr/bin/env bash
set -e

export DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

echo "─────────────────────────────────────"
echo "  Dotfiles Installer (macOS/Linux)"
echo "─────────────────────────────────────"
echo "Using DOTFILES = $DOTFILES"
echo ""

###
# SYMLINK HELPER
###
link() {
    local src="$1"
    local dest="$2"
    echo "Linking $src → $dest"
    mkdir -p "$(dirname "$dest")"
    ln -sfn "$src" "$dest"
}

###
echo "Setting up shell dotfiles..."

# ZSH (optional)
if command -v zsh >/dev/null; then
    link "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
fi

# Git
link "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"

# Neovim
link "$DOTFILES/nvim" "$HOME/.config/nvim"

# tmux config
if command -v tmux >/dev/null; then
  link "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"
fi


###
# VS CODE SYNC
###
# echo "Running VSCode setup..."
# bash "$DOTFILES/vscode/setup_vscode.sh"
# echo ""

echo "🎉 Dotfiles setup complete!"

