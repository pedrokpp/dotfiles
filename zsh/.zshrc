# Paths
typeset -U path PATH
path=(
  "$HOME/go/bin"
  "$HOME/bin"
  "$HOME/.local/bin"
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

# Prompt (pure-Zsh port of the Oh My Zsh tjkirch theme)
source "${ZDOTDIR:-$HOME}/.zsh/themes/tjkirch.zsh-theme"

# Fedora system packages:
#   sudo dnf install zsh-autosuggestions zsh-syntax-highlighting
[[ -r /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] &&
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting must be sourced after all other ZLE plugins.
[[ -r /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] &&
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias update='sudo dnf upgrade --refresh'

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
