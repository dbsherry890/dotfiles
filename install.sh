#!/usr/bin/env bash
set -e

# Repo location = wherever this script lives
export DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

detect_platform() {
    case "$(uname -s)" in
        Darwin) echo mac ;;
        Linux)  grep -qi microsoft /proc/version 2>/dev/null && echo wsl || echo linux ;;
        *)      echo unknown ;;
    esac
}
# DOTFILES_PLATFORM overrides detection (useful for testing)
PLATFORM="${DOTFILES_PLATFORM:-$(detect_platform)}"

echo "─────────────────────────────────────"
echo "  Dotfiles Installer ($PLATFORM)"
echo "─────────────────────────────────────"
echo "Using DOTFILES = $DOTFILES"
echo ""

link() {
    local src="$1"
    local dest="$2"
    mkdir -p "$(dirname "$dest")"
    # Back up real files/dirs so ln doesn't clobber them (or nest inside a dir)
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        local backup="$dest.bak.$(date +%Y%m%d%H%M%S)"
        echo "Backing up $dest → $backup"
        mv "$dest" "$backup"
    fi
    echo "Linking $src → $dest"
    ln -sfn "$src" "$dest"
}

echo "Setting up shared dotfiles..."

link "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"
link "$DOTFILES/nvim" "$HOME/.config/nvim"
link "$DOTFILES/shell/.aliases" "$HOME/.aliases"
link "$DOTFILES/shell/.tmux.conf" "$HOME/.tmux.conf"

case "$PLATFORM" in
    mac)
        echo ""
        echo "Setting up macOS (personal)..."
        link "$DOTFILES/shell/.zshrc" "$HOME/.zshrc"

        VSCODE_DIR="$HOME/Library/Application Support/Code/User"
        link "$DOTFILES/vscode/settings.json" "$VSCODE_DIR/settings.json"
        link "$DOTFILES/vscode/keybindings.json" "$VSCODE_DIR/keybindings.json"

        if command -v code >/dev/null && [ "${SKIP_VSCODE_EXTENSIONS:-}" != 1 ]; then
            echo "Installing VSCode extensions..."
            while read -r ext; do
                [ -n "$ext" ] && code --install-extension "$ext" --force >/dev/null
            done < "$DOTFILES/vscode/extensions.txt"
        fi
        ;;
    wsl)
        echo ""
        echo "Setting up WSL (work)..."
        link "$DOTFILES/shell/.bashrc" "$HOME/.bashrc"
        link "$DOTFILES/shell/work.sh" "$HOME/.work.sh"
        if [ -f "$DOTFILES/git/work.gitconfig" ]; then
            link "$DOTFILES/git/work.gitconfig" "$HOME/.gitconfig.local"
        fi
        echo "VSCode runs on Windows; copy settings over manually (see README)."
        ;;
    *)
        echo "⚠️  Unrecognized platform '$PLATFORM' — only shared dotfiles were linked."
        ;;
esac

echo ""
echo "🎉 Dotfiles setup complete!"
