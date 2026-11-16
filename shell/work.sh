# Work-only config (WSL). Linked to ~/.work.sh by install.sh and sourced by ~/.bashrc.

# ── Windows interop ───────────────────────────────────────────────────────────
alias pbcopy='clip.exe'
alias win="cd /mnt/c/Users/DSHERRY/"
alias winopen="explorer.exe"
alias mdview='f() { pandoc "$1" -o /tmp/preview.html && explorer.exe "$(wslpath -w /tmp/preview.html)"; }; f'
alias code="/mnt/c/Program\ Files/Microsoft\ VS\ Code/bin/code"
alias onedrive='cd "/mnt/c/Users/DSHERRY/OneDrive - ERCOT"; ls'
export BROWSER=wslview

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
export PATH="$PATH:/mnt/c/Windows/System32" # added for copying support in tmux
export PATH="$PATH:/mnt/c/Windows" # to find programs like explorer.exe

# ── Work shortcuts ────────────────────────────────────────────────────────────
alias ercot="cd ~/obsidian/ERCOT; nvim"
alias dc='docker compose'
alias uve='unset VIRTUAL_ENV'

function update_python_ca_certs() {
  for cacert in $(2>/dev/null find -name cacert.pem | grep certifi/cacert.pem); do
    for cert in /usr/share/ca-certificates/ercot/*; do
      alias=${cert##*/}; alias=${alias%.pem}; alias=${alias%.crt}
      echo "# $alias" | tee -a $cacert
      cat "$cert" | tee -a $cacert
    done
  done
}

# ── Oracle ────────────────────────────────────────────────────────────────────
export TNS_ADMIN=/home/dsherry/oracle/tnsnames.ora

# ── MCP / Jira ────────────────────────────────────────────────────────────────
export JIRA_BASE_URL="https://jira.ercot.com/"
export MCP_TOOL_PACKAGE="change_coordinator"

# ── Databricks ────────────────────────────────────────────────────────────────
export DATABRICKS_HOST="adb-4328769614695144.4.azuredatabricks.net"
alias d='/usr/local/bin/databricks'
alias data='/usr/local/bin/databricks'
command -v databricks >/dev/null 2>&1 && eval "$(databricks completion bash)"
