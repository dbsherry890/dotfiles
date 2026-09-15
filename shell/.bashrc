# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias l='ll'
alias la='ls -A'
alias src='source .venv/bin/activate'
alias gs='git status'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = -3 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Created by `pipx` on 2025-09-12 14:42:00
export PATH="$PATH:/home/dsherry/.local/bin"

alias grep='grep --color=auto '
alias ls='ls -1 -FhNv --color=auto --group-directories-first '
alias la='ls -a '
alias ll='la -l '
alias sudo='sudo '
alias code="/mnt/c/Program\ Files/Microsoft\ VS\ Code/bin/code"
alias bashrc="nvim ~/.bashrc"
alias bat=batcat
alias onedrive='cd "/mnt/c/Users/DSHERRY/OneDrive - ERCOT"; ls'
alias d='/usr/local/bin/databricks'

source ~/.local/share/bashrc/ssh-agent.sh

export PAGER=less
export LESS=-FRX
if [[ -z "$XDG_RUNTIME_DIR" ]]; then
  export XDG_RUNTIME_DIR=/run/user/$UID
  if [[ ! -d "$XDG_RUNTIME_DIR" ]]; then
    export XDG_RUNTIME_DIR=/tmp/$USER-runtime
    if [[ ! -d "$XDG_RUNTIME_DIR" ]]; then
      mkdir -m 0700 "$XDG_RUNTIME_DIR"
    fi
  fi
fi

function update_python_ca_certs() {
  for cacert in $(2>/dev/null find -name cacert.pem | grep certifi/cacert.pem); do
    for cert in /usr/share/ca-certificates/ercot/*; do
      alias=${cert##*/}; alias=${alias%.pem}; alias=${alias%.crt}
      echo "# $alias" | tee -a $cacert
      cat "$cert" | tee -a $cacert
    done
  done
}

function removemobaxtermstupidpath() {
  local IFS=':'
  local newpath=""
  read -r -a pathelements <<< "$PATH"
  for pathelement in "${pathelements[@]}"; do
    if [[ "$pathelement" != /c/* ]] && [[ "$pathelement" != /mnt/c/* ]] && [[ "$pathelement" != *games* ]]; then
      newpath="$newpath:$pathelement"
    fi
  done
  newpath="${newpath#:}"
  echo "$newpath"
}
export PATH=$(removemobaxtermstupidpath)
powerline-daemon -q
export POWERLINE_BASH_CONTINUATION=1
export POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh
export TNS_ADMIN=/home/dsherry/oracle/tnsnames.ora

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export PYTHONSTARTUP=~/.pythonstartup

export GOPATH=$HOME/go
export PATH=$PATH:/usr/lib/go-1.22/bin:$GOPATH/bin

export PATH="/home/linuxbrew/.linuxbrew/opt/postgresql@17/bin:$PATH"

export PATH="$PATH:/mnt/c/Windows/System32" # added for copying support in tmux
export PATH="$PATH:/mnt/c/Windows" # to find programs like explorer.exe

export CDPATH="$HOME/1_Projects/"

# for MCP
export JIRA_BASE_URL="https://jira.ercot.com/"
export MCP_TOOL_PACKAGE="change_coordinator"

# Secrets (JIRA_TOKEN, etc.) - not tracked in dotfiles repo, must exist per-machine
[ -f ~/.config/secrets/env.sh ] && source ~/.config/secrets/env.sh

export BROWSER=wslview

#  -- Databricks --
export DATABRICKS_HOST="adb-4328769614695144.4.azuredatabricks.net"
alias data='/usr/local/bin/databricks'
eval "$(databricks completion bash)"

#  -- K8s --
command -v kubectl >/dev/null 2>&1 && eval "$(kubectl completion bash 2>/dev/null)"

eval "$(fzf --bash)"

export SKILL_CHAR_BUDGET=100000

