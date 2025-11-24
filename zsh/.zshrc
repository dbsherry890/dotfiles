## -----------------------------
## Powerlevel10k instant prompt
## -----------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

## -----------------------------
## Base PATH
## -----------------------------
export PATH="$HOME/bin:/usr/local/bin:$PATH"

## -----------------------------
## Oh My Zsh
## -----------------------------
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 30

ENABLE_CORRECTION="true"
export EDITOR='mvim'

## -----------------------------
## Homebrew (recommended)
## -----------------------------
# Sets PATH, MANPATH, INFOPATH
eval "$(/opt/homebrew/bin/brew shellenv)"

# Add additional Homebrew tools if needed
extra_brew_bins=(
  "/opt/homebrew/opt/openjdk/bin"
  "/opt/homebrew/opt/libpq/bin"
)
for dir in "${extra_brew_bins[@]}"; do
  [[ -d "$dir" ]] && PATH="$dir:$PATH"
done

## -----------------------------
## Python site-packages
## -----------------------------
python_paths=(
  "/usr/local/lib/python3.10/site-packages"
  "$HOME/Library/Python/3.11/lib/python/site-packages"
  "$HOME/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages"
)
for dir in "${python_paths[@]}"; do
  [[ -d "$dir" ]] && PATH="$PATH:$dir"
done

## -----------------------------
## Node / NVM
## -----------------------------
[[ -s "$HOME/.nvm/nvm.sh" ]] && . "$HOME/.nvm/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

## -----------------------------
## Local environment variables
## -----------------------------
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

## -----------------------------
## Powerlevel10k theme
## -----------------------------
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

## -----------------------------
## Plugins
## -----------------------------
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## -----------------------------
## fzf
## -----------------------------
source <(fzf --zsh)
export FZF_DEFAULT_OPTS='--height 40% --tmux bottom,60% --layout reverse --border top'

## -----------------------------
## Go
## -----------------------------
export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"

## -----------------------------
## Aliases
## -----------------------------
alias python=/usr/bin/python3
alias ls="eza --icons=always"
alias cm="cmatrix"
alias dot="cd ~/.config/nvim; nvim"
alias zshrc="nvim ~/.zshrc"
alias e="exit"
alias c="clear"
