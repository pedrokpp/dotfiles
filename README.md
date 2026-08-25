# dotfiles

Configurações pessoais gerenciadas com [GNU Stow](https://www.gnu.org/software/stow/).

## Estrutura

```
$ tree .
.
├── hypr
├── kitty
├── nvim
├── README.md
└── zsh
```

## Instalação

```sh
git clone https://github.com/pedrokpp/dotfiles ~/dotfiles
cd ~/dotfiles
stow hypr kitty nvim zsh
```
