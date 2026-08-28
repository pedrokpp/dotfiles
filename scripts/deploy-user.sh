#!/usr/bin/bash
set -euo pipefail

repo_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
packages=(hypr uwsm waybar fuzzel mako portal kitty)
action=${1:-check}

stow_args=(
  --dir="$repo_root"
  --target="$HOME"
  --no-folding
  --verbose=2
)

case "$action" in
  check)
    stow --simulate "${stow_args[@]}" "${packages[@]}"
    ;;
  deploy)
    stow "${stow_args[@]}" "${packages[@]}"
    ;;
  restow)
    stow --restow "${stow_args[@]}" "${packages[@]}"
    ;;
  remove)
    stow --delete "${stow_args[@]}" "${packages[@]}"
    ;;
  *)
    printf 'Usage: %s {check|deploy|restow|remove}\n' "$0" >&2
    exit 2
    ;;
esac
