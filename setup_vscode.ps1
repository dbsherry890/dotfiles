$ErrorActionPreference = "Stop"

$Dotfiles = $env:DOTFILES
if (-not $Dotfiles) {
    $Dotfiles = "$HOME\dotfiles"
}

$VscodeDir = "$env:APPDATA\Code\User"
New-Item -ItemType Directory -Force -Path $VscodeDir | Out-Null

function Link($src, $dest) {
    Write-Host "Linking $src → $dest"
    if (Test-Path $dest) { Remove-Item $dest -Force }
    New-Item -ItemType SymbolicLink -Path $dest -Target $src | Out-Null
}

# Symlink settings and keybindings
Link "$Dotfiles\vscode\settings.json" "$VscodeDir\settings.json"
Link "$Dotfiles\vscode\keybindings.json" "$VscodeDir\keybindings.json"

# Install extensions
Write-Host "Installing VSCode extensions..."
Get-Content "$Dotfiles\vscode\extensions.txt" | ForEach-Object {
    code --install-extension $_ --force
}

Write-Host "VSCode setup complete!"

