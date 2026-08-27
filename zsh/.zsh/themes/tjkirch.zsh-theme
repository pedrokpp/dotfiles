# Pure-Zsh port of Oh My Zsh's tjkirch theme.
# Original: https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/tjkirch.zsh-theme

setopt prompt_subst

function git_prompt_info() {
  command git rev-parse --git-dir &>/dev/null || return

  local ref dirty
  ref=$(command git symbolic-ref --quiet --short HEAD 2>/dev/null) ||
    ref=$(command git describe --tags --exact-match HEAD 2>/dev/null) ||
    ref=$(command git rev-parse --short HEAD 2>/dev/null) || return

  # Escape prompt expansion tokens from branch and tag names.
  ref=${ref//\%/%%}
  [[ -n $(command git status --porcelain 2>/dev/null) ]] && dirty=' %F{red}⚡'

  print -nr -- " %F{green}${ref}${dirty}%f"
}

PROMPT='%(?, ,%F{red}FAIL: %?%f
)
%F{magenta}%n%f@%F{yellow}%m%f: %B%F{blue}%~%f%b$(git_prompt_info)
%(#.%F{red}#%f.$) '
RPROMPT='%F{green}[%*]%f'
