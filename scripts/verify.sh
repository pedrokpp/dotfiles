#!/usr/bin/bash
set -euo pipefail

repo_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
cd "$repo_root"

failures=0

pass() {
  printf 'PASS  %s\n' "$1"
}

fail() {
  printf 'FAIL  %s\n' "$1" >&2
  failures=$((failures + 1))
}

tracked_and_new() {
  {
    git ls-files
    git ls-files --others --exclude-standard
  } | sort -u
}

check_repo() {
  local forbidden_name forbidden_path config_loader_pattern blocked_roots_pattern
  forbidden_name=$(printf '%s%s' 'omar' 'chy')
  forbidden_path=$(printf '%s%s' '/usr/share/omar' 'chy')
  config_loader_pattern='(source|include|import|require|dofile)'
  blocked_roots_pattern='(/usr/share|/etc/)'

  if tracked_and_new | xargs -r rg -n -i "$forbidden_name|$forbidden_path" -- 2>/dev/null; then
    fail "forbidden runtime references found"
  else
    pass "no forbidden runtime references"
  fi

  if rg -n -i "$config_loader_pattern.*$blocked_roots_pattern" \
    hypr uwsm waybar fuzzel mako portal kitty 2>/dev/null; then
    fail "configuration imports from system directories found"
  else
    pass "no configuration imports from system directories"
  fi

  if find . -path './.git' -prune -o -type l -print0 | while IFS= read -r -d '' link; do
    resolved=$(realpath -m "$link")
    case "$resolved" in
      "$repo_root"/*) ;;
      *) printf '%s -> %s\n' "$link" "$resolved"; exit 1 ;;
    esac
  done; then
    pass "repository symlinks remain inside the repository"
  else
    fail "repository symlink points outside the repository"
  fi

  if find . -path './.git' -prune -o -user root -print -quit | grep -q .; then
    fail "root-owned files found in repository"
  else
    pass "no root-owned files"
  fi

  if find . -path './.git' -prune -o \
    \( -name '.env' -o -name '*.pem' -o -name 'id_rsa*' -o -name '__pycache__' \
       -o -name '.DS_Store' -o -name 'nvim.log' \) -print -quit | grep -q .; then
    fail "secret, cache, or local artifact candidate found"
  else
    pass "no known secret, cache, or local artifact names"
  fi

  if git diff --check; then
    pass "git diff whitespace check"
  else
    fail "git diff whitespace check"
  fi

  if jq empty theme/catppuccin-mocha.json waybar/.config/waybar/config.jsonc; then
    pass "JSON configuration syntax"
  else
    fail "JSON configuration syntax"
  fi

  if scripts/generate-themes.py --check; then
    pass "generated themes match central palette"
  else
    fail "generated themes match central palette"
  fi

  local runtime_dir lua_file lua_failures_before
  runtime_dir=$(mktemp -d)
  lua_failures_before=$failures
  for lua_file in hypr/.config/hypr/hyprland.lua hypr/.config/hypr/modules/*.lua; do
    if command -v luac >/dev/null 2>&1; then
      luac -p "$lua_file" || fail "Lua syntax: $lua_file"
    elif command -v nvim >/dev/null 2>&1; then
      XDG_RUNTIME_DIR="$runtime_dir" NVIM_LOG_FILE="$runtime_dir/nvim.log" \
        nvim --headless -u NONE -c "lua assert(loadfile([[$lua_file]]))" -c qa \
        >/dev/null 2>&1 || fail "Lua syntax: $lua_file"
    else
      fail "no Lua parser available"
      break
    fi
  done
  rm -rf -- "$runtime_dir"
  if (( failures == lua_failures_before )); then
    pass "Lua files parsed"
  fi

  local shell_file shell_failures_before
  shell_failures_before=$failures
  while IFS= read -r shell_file; do
    bash -n "$shell_file" || fail "shell syntax: $shell_file"
  done < <(rg -l '^#!.*/(ba)?sh$' scripts hypr/.config/hypr/scripts)
  if (( failures == shell_failures_before )); then
    pass "shell files parsed"
  fi

  if python3 -c 'import ast, pathlib; ast.parse(pathlib.Path("scripts/generate-themes.py").read_text())'; then
    pass "Python generator parsed"
  else
    fail "Python generator parsed"
  fi

  if file hypr/.config/hypr/assets/wallpaper.png | rg -q 'PNG image data'; then
    pass "wallpaper is a local PNG asset"
  else
    fail "wallpaper is a local PNG asset"
  fi
}

check_deployed() {
  local package source relative target
  for package in hypr uwsm waybar fuzzel mako portal kitty; do
    while IFS= read -r -d '' source; do
      relative=${source#"$repo_root/$package/"}
      target="$HOME/$relative"
      if [[ ! -e "$target" ]] || [[ $(realpath -m "$target") != $(realpath -m "$source") ]]; then
        fail "deployment mismatch: $target"
      fi
    done < <(find "$repo_root/$package" -type f -print0)
  done
  if (( failures == 0 )); then
    pass "deployed files resolve to repository sources"
  fi
}

check_runtime() {
  local command_name
  local commands=(
    Hyprland hyprctl uwsm waybar fuzzel mako hyprlock hypridle hyprpaper
    cliphist grim slurp wl-copy wl-paste jq notify-send wpctl pavucontrol
    playerctl kitty nautilus
  )
  for command_name in "${commands[@]}"; do
    command -v "$command_name" >/dev/null 2>&1 || fail "missing command: $command_name"
  done
  [[ -x /usr/libexec/lxqt-policykit-agent ]] \
    || fail "missing command: /usr/libexec/lxqt-policykit-agent"
  rpm -q xdg-desktop-portal-hyprland >/dev/null 2>&1 \
    || fail "missing package: xdg-desktop-portal-hyprland"
  if (( failures == 0 )); then
    pass "runtime dependencies available"
  fi
}

check_repo
for requested_check in "$@"; do
  case "$requested_check" in
    --deployed) check_deployed ;;
    --runtime) check_runtime ;;
    *) printf 'Unknown option: %s\n' "$requested_check" >&2; exit 2 ;;
  esac
done

if (( failures > 0 )); then
  printf '%d verification failure(s)\n' "$failures" >&2
  exit 1
fi

printf 'All requested checks passed\n'
