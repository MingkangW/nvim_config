#!/usr/bin/env bash

# Source this file from your shell rc to expose the portable config paths
# and aliases without changing global XDG behavior for the whole session.

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  echo "portable-config: source bin/portable-env.sh from your shell rc instead of executing it." >&2
  exit 1
fi

_portable_env_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

export PORTABLE_CONFIG_ROOT="$_portable_env_root"
export STARSHIP_CONFIG="$PORTABLE_CONFIG_ROOT/starship/starship.toml"

alias nvim="$PORTABLE_CONFIG_ROOT/bin/nvim-portable"
alias tmux="$PORTABLE_CONFIG_ROOT/bin/tmux-portable"

unset _portable_env_root
