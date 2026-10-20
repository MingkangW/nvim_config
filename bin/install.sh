#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INSTALL_HOME="${INSTALL_HOME:-$HOME}"
CONFIG_HOME="${XDG_CONFIG_HOME:-$INSTALL_HOME/.config}"
TMUX_PLUGIN_ROOT="$INSTALL_HOME/.tmux/plugins"
OH_MY_ZSH_CUSTOM="$INSTALL_HOME/.oh-my-zsh/custom"
BACKUP_SUFFIX="$(date +%Y%m%d-%H%M%S)"

backup_path() {
  local dst="$1"

  if [[ -L "$dst" || -f "$dst" || -d "$dst" ]]; then
    local backup="${dst}.bak.${BACKUP_SUFFIX}"
    mv "$dst" "$backup"
    echo "backup: $dst -> $backup"
  fi
}

link_path() {
  local src="$1"
  local dst="$2"
  local parent

  parent="$(dirname "$dst")"
  mkdir -p "$parent"

  if [[ -L "$dst" ]]; then
    local current
    current="$(readlink "$dst")"
    if [[ "$current" == "$src" ]]; then
      echo "ok: $dst -> $src"
      return
    fi
  fi

  if [[ -e "$dst" || -L "$dst" ]]; then
    backup_path "$dst"
  fi

  ln -s "$src" "$dst"
  echo "link: $dst -> $src"
}

link_path "$ROOT_DIR/nvim" "$CONFIG_HOME/nvim"
link_path "$ROOT_DIR/tmux/tmux.conf" "$INSTALL_HOME/.tmux.conf"
link_path "$ROOT_DIR/starship/starship.toml" "$CONFIG_HOME/starship.toml"
ZSH_CONFIG="$INSTALL_HOME/.zshrc"
ZSH_SHARED_CONFIG="$ROOT_DIR/zsh/.zshrc"
ZSH_SOURCE_LINE="[[ -f \"$ZSH_SHARED_CONFIG\" ]] && source \"$ZSH_SHARED_CONFIG\""
if [[ -e "$ZSH_CONFIG" || -L "$ZSH_CONFIG" ]]; then
  if ! grep -Fqx "$ZSH_SOURCE_LINE" "$ZSH_CONFIG" 2>/dev/null; then
    printf '\n# Shared configuration managed by nvim_config\n%s\n' "$ZSH_SOURCE_LINE" >> "$ZSH_CONFIG"
    echo "updated: $ZSH_CONFIG (sources $ZSH_SHARED_CONFIG)"
  else
    echo "ok: $ZSH_CONFIG already sources $ZSH_SHARED_CONFIG"
  fi
else
  printf '%s\n' "$ZSH_SOURCE_LINE" > "$ZSH_CONFIG"
  echo "created: $ZSH_CONFIG (sources $ZSH_SHARED_CONFIG)"
fi

if [[ -d "$INSTALL_HOME/.oh-my-zsh" ]]; then
  link_path "$ROOT_DIR/zsh/oh-my-zsh-custom" "$OH_MY_ZSH_CUSTOM"
else
  echo "warning: $INSTALL_HOME/.oh-my-zsh not found; install Oh My Zsh before linking custom config"
fi

mkdir -p "$TMUX_PLUGIN_ROOT"
link_path "$ROOT_DIR/submodules/tpm" "$TMUX_PLUGIN_ROOT/tpm"

cat <<EOF

Install complete.

Neovim config:  $CONFIG_HOME/nvim
tmux config:    $INSTALL_HOME/.tmux.conf
starship config:$CONFIG_HOME/starship.toml
TPM location:   $TMUX_PLUGIN_ROOT/tpm
Zsh shared config:$ZSH_SHARED_CONFIG
Oh My Zsh custom:$OH_MY_ZSH_CUSTOM

You can now start:
  nvim
  tmux
EOF
