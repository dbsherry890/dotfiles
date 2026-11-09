## Powerlevel10k prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

## Base PATH 
export PATH="$HOME/bin:/usr/local/bin:$PATH"

## CDPATH 
export CDPATH="$HOME"
export CDPATH="$CDPATH:$HOME/1_Projects/"

## Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 30

ENABLE_CORRECTION="true"
export EDITOR='nvim'

setopt correctall

## Homebrew
# Sets PATH, MANPATH, INFOPATH
eval "$(/opt/homebrew/bin/brew shellenv)"

# Add additional Homebrew tools if needed
extra_brew_bins=(
  # "/opt/homebrew/opt/openjdk/bin"
  "/opt/homebrew/opt/libpq/bin"
)
for dir in "${extra_brew_bins[@]}"; do
  [[ -d "$dir" ]] && PATH="$dir:$PATH"
done

## Local environment variables
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

## Powerlevel10k theme
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

## Plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## fzf 
source <(fzf --zsh)
export FZF_DEFAULT_OPTS='--height 40% --tmux bottom,60% --layout reverse --border top'

## Go 
export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"

## Postgresql
export PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"

## Aliases 
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"
#
# CFLAGS is the variable make's built-in C rule reads for compiler flags.
# Exporting it means every `make <name>` (with no Makefile) uses these flags.
#   -Wall -Wextra -> most useful warnings on
#   -std=c17      -> modern C standard
#   -g            -> debug info for lldb/gdb
export CFLAGS="-Wall -Wextra -std=c17 -g"

# mr = "make & run". Pass the program name WITHOUT .c
# Usage: mr hello        -> builds hello.c into ./hello, then runs it
#        mr wc input.txt -> extra args are passed to your program
mr() {
  local name="$1"  # target name, e.g. "hello" (make looks for hello.c)
  shift            # remaining args belong to your program
  make "$name" && "./$name" "$@"  # only run if the build succeeded
}

# Support colors in less
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;33;44m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4;1;32m'
export LESS_TERMCAP_mr=$'\e[7m'
export LESS_TERMCAP_mh=$'\e[2m'
export LESS_TERMCAP_ZN=$'\e[74m'
export LESS_TERMCAP_ZV=$'\e[75m'
export LESS_TERMCAP_ZO=$'\e[73m'
export LESS_TERMCAP_ZW=$'\e[\75m'

alias hl='rg --passthru'
