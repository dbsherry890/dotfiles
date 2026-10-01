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

echo "Checking for powerline..."
if ! command -v powerline-daemon >/dev/null 2>&1; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        if command -v brew >/dev/null 2>&1; then
            echo "Installing powerline via Homebrew..."
            brew install powerline
        else
            echo "Homebrew not found — skipping powerline install, install manually."
        fi
    elif command -v apt >/dev/null 2>&1; then
        echo "Installing powerline via apt..."
        sudo apt install -y powerline
    else
        echo "No known package manager found — skipping powerline install, install manually."
    fi
else
    echo "powerline already installed, skipping."
fi
echo ""

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
