# dotfiles

Configurações pessoais gerenciadas com [GNU Stow](https://www.gnu.org/software/stow/).

## Estrutura

```
dotfiles/
├── claude/   # Claude Code (CLAUDE.md, settings, commands)
├── kitty/    # Kitty terminal
├── nvim/     # Neovim (LazyVim)
└── zsh/      # Zsh (.zshrc)
```

## Instalação

```sh
git clone https://github.com/pedrokpp/dotfiles ~/dotfiles
cd ~/dotfiles
./stow-all.sh
```

