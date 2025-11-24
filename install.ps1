$Dotfiles = "$HOME\dotfiles"

function Link-Item($src, $dest) {
    $destDir = Split-Path $dest
    if (!(Test-Path $destDir)) {
        New-Item -ItemType Directory -Force -Path $destDir | Out-Null
    }

    if (Test-Path $dest) {
        Write-Host "Removing old $dest"
        Remove-Item $dest -Force -Recurse
    }

    Write-Host "Linking $src -> $dest"
    New-Item -ItemType SymbolicLink -Path $dest -Target $src | Out-Null
}

Write-Host "🔧 Setting up dotfiles (Windows)..."

# Paths
$vscode = "$env:APPDATA\Code\User"
$nvim   = "$env:LOCALAPPDATA\nvim"
$gitcfg = "$HOME\.gitconfig"

# VSCode
Link-Item "$DOTFILES/vscode/settings.json" "$VSCODE_DIR/settings.json"
Link-Item "$DOTFILES/vscode/keybindings.json" "$VSCODE_DIR/keybindings.json"

# Neovim
Link-Item "$Dotfiles\nvim" "$nvim"

# Git
Link-Item "$Dotfiles\git\gitconfig" "$gitcfg"

# Tmux
## Only works in WSL. Use Linux setup there

Write-Host "✨ Windows setup done!"
