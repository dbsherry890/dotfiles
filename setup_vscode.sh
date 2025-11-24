#!/usr/bin/env bash
set -e

DOTFILES="${DOTFILES:-$HOME/dotfiles}"

# Platform check
OS="$(uname)"
if [[ "$OS" == "Darwin" ]]; then
    VSCODE_DIR="$HOME/Library/Application Support/Code/User"
else
    VSCODE_DIR="$HOME/.config/Code/User"
fi

mkdir -p "$VSCODE_DIR"

# Symlink helper
link() {
    local src="$1"
    local dest="$2"
    echo "Linking $src → $dest"
    ln -sf "$src" "$dest"
}

# Symlink settings + keybindings
link "$DOTFILES/vscode/settings.json" "$VSCODE_DIR/settings.json"
link "$DOTFILES/vscode/keybindings.json" "$VSCODE_DIR/keybindings.json"

# Install extensions
echo "Installing VSCode extensions..."
while read -r ext; do
    code --install-extension "$ext" --force
done < "$DOTFILES/vscode/extensions.txt"

echo "VSCode setup finished!"

