#!/usr/bin/env bash
set -e

export DOTFILES="$HOME/dotfiles"

echo "─────────────────────────────────────"
echo "  Dotfiles Installer (macOS/Linux)"
echo "─────────────────────────────────────"
echo "Using DOTFILES = $DOTFILES"
echo ""

link() {
    local src="$1"
    local dest="$2"
    echo "Linking $src → $dest"
    mkdir -p "$(dirname "$dest")"
    ln -sfn "$src" "$dest"
}

echo "Setting up shell dotfiles..."

link "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"
link "$DOTFILES/nvim" "$HOME/.config/nvim"
link "$DOTFILES/shell/.aliases" "$HOME/.aliases"
link "$DOTFILES/shell/.tmux.conf" "$HOME/.tmux.conf"

if command -v zsh >/dev/null; then
    link "$DOTFILES/shell/.zshrc" "$HOME/.zshrc"
fi

if command -v bash >/dev/null; then
    link "$DOTFILES/shell/.bashrc" "$HOME/.bashrc"
fi

echo "🎉 Dotfiles setup complete!"
