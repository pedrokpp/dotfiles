# Paths
typeset -U path PATH
path=(
  "$HOME/go/bin"
  "$HOME/bin"
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  /usr/local/bin
  $path
)

# Completion
autoload -Uz compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
compinit

# History
HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt share_history

# Move the cursor one word at a time with Ctrl+Left/Ctrl+Right.
# Terminals may encode these keys differently, so cover the common variants.
for keymap in emacs viins; do
  bindkey -M "$keymap" '^[[1;5D' backward-word
  bindkey -M "$keymap" '^[[1;5C' forward-word
  bindkey -M "$keymap" '^[[5D' backward-word
  bindkey -M "$keymap" '^[[5C' forward-word
  bindkey -M "$keymap" '^[Od' backward-word
  bindkey -M "$keymap" '^[Oc' forward-word
  bindkey -M "$keymap" '^H' backward-kill-word
  bindkey -M "$keymap" '^[[8;5u' backward-kill-word
  bindkey -M "$keymap" '^[[127;5u' backward-kill-word
done
unset keymap

# Prompt (pure-Zsh port of the Oh My Zsh tjkirch theme)
source "${ZDOTDIR:-$HOME}/.zsh/themes/tjkirch.zsh-theme"

# Fedora system packages:
#   sudo dnf install zsh-autosuggestions zsh-syntax-highlighting
[[ -r /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] &&
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting must be sourced after all other ZLE plugins.
[[ -r /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] &&
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Git
alias gst='git status'
alias gcam='git commit --all --message'
alias gpsup='git push --set-upstream origin "$(git branch --show-current)"'
alias gcmsg='git commit --message'
alias ga='git add'
alias gall='git add --all'

alias update='sudo dnf upgrade --refresh'

export EDITOR=nvim

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
