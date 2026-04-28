#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INSTALL_HOME="${INSTALL_HOME:-$HOME}"
CONFIG_HOME="${XDG_CONFIG_HOME:-$INSTALL_HOME/.config}"
TMUX_PLUGIN_ROOT="$INSTALL_HOME/.tmux/plugins"
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

mkdir -p "$TMUX_PLUGIN_ROOT"
link_path "$ROOT_DIR/submodules/tpm" "$TMUX_PLUGIN_ROOT/tpm"

cat <<EOF

Install complete.

Neovim config:  $CONFIG_HOME/nvim
tmux config:    $INSTALL_HOME/.tmux.conf
starship config:$CONFIG_HOME/starship.toml
TPM location:   $TMUX_PLUGIN_ROOT/tpm

You can now start:
  nvim
  tmux
EOF
