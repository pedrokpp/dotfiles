# Dotfiles para GNOME e Hyprland no Fedora 44

Este repositório mantém uma sessão Hyprland autônoma ao lado do GNOME. O GDM
continua como display manager. O Hyprland inicia por UWSM e usa Catppuccin Mocha
desde o primeiro login.

O login não baixa arquivos e não consulta configurações fora deste repositório.
Os arquivos em `~/.config` são links gerenciados pelo GNU Stow. A única cópia
instalada no sistema é a entrada de sessão do GDM, cuja fonte está em
`system/wayland-sessions`.

Commit-base de rollback:

```text
2bc69b2becb3d7e3aefa554fa1a1cd26f3d4d1d7
```

## Estado verificado do host

- Fedora 44 Workstation, kernel 6.19.10.
- GNOME 50 em Wayland e GDM instalados.
- AMD Radeon RX 6650 XT com o driver `amdgpu`.
- Acer QG241Y S em `DP-2`, 1920x1080 a 164.998 Hz.
- PipeWire, WirePlumber, Kitty, Nautilus, `wl-clipboard`, `jq`, Libnotify,
  Stow e os portais GNOME e GTK já instalados.

O módulo `monitor.lua` arredonda o modo reportado pelo GNOME para
`1920x1080@165`, como exige o Hyprland.

## Dependências

### Obrigatórias

| Pacote | Origem | Estado inicial | Uso |
| --- | --- | --- | --- |
| `hyprland` | COPR único | ausente | compositor e `hyprctl` |
| `uwsm` | COPR único | ausente | sessão systemd do usuário |
| `hyprlock` | COPR único | ausente | bloqueio de tela |
| `hypridle` | COPR único | ausente | lock, DPMS e suspensão por inatividade |
| `hyprpaper` | COPR único | ausente | wallpaper local |
| `xdg-desktop-portal-hyprland` | COPR único | ausente | screencast e integração de portais |
| `waybar` | Fedora | ausente | barra |
| `fuzzel` | Fedora | ausente | launcher e menus dmenu |
| `mako` | Fedora | ausente | notificações |
| `cliphist` | Fedora | ausente | histórico do clipboard |
| `grim` | Fedora | ausente | captura de tela |
| `slurp` | Fedora | ausente | seleção de região |
| `pavucontrol` | Fedora | ausente | controle gráfico de áudio |
| `playerctl` | Fedora | ausente | teclas de mídia |
| `lxqt-policykit` | Fedora | ausente | agente Polkit |
| `jetbrains-mono-fonts` | Fedora | ausente | fonte da sessão |
| `fontawesome-6-free-fonts` | Fedora | ausente | ícones da Waybar |
| `pipewire`, `wireplumber` | Fedora | instalado | áudio |
| `wl-clipboard` | Fedora | instalado | clipboard Wayland |
| `kitty`, `nautilus` | Fedora | instalado | terminal e arquivos |
| `xdg-desktop-portal`, `xdg-desktop-portal-gtk` | Fedora | instalado | frontend e file chooser |
| `xdg-desktop-portal-gnome` | Fedora | instalado | portal preservado para GNOME |
| `jq`, `libnotify`, `stow` | Fedora | instalado | scripts, notificações e links |

O COPR escolhido é `lionheartp/Hyprland`. Ele fornece a pilha Hyprland para
Fedora 44 no mesmo repositório. Não habilite outro repositório de Hyprland em
paralelo.

### Opcionais

| Pacote | Uso |
| --- | --- |
| `brightnessctl` | teclas de brilho em hardware com backlight compatível |
| `hyprsunset` | temperatura de cor; a configuração existe, mas não inicia sozinha |
| `blueman` | gerenciamento gráfico de Bluetooth |
| `wev` | diagnóstico de teclas e dispositivos de entrada |

## Instalação

Execute cada categoria separadamente. Os comandos DNF não usam confirmação
automática.

### 1. Habilitação de repositório

```sh
sudo dnf copr enable lionheartp/Hyprland
```

Antes da instalação, confira os candidatos e envie a saída completa se alguma
versão não resolver:

```sh
dnf repoquery --latest-limit=1 --qf '%{name} %{evr} %{arch} %{repoid}' hyprland uwsm hyprlock hypridle hyprpaper xdg-desktop-portal-hyprland
```

### 2. Instalação de pacotes

Este comando contém somente os pacotes ausentes no inventário inicial:

```sh
sudo dnf install hyprland uwsm hyprlock hypridle hyprpaper xdg-desktop-portal-hyprland waybar fuzzel mako cliphist grim slurp pavucontrol playerctl lxqt-policykit jetbrains-mono-fonts fontawesome-6-free-fonts
```

### 3. Configuração do usuário

Primeiro simule a implantação:

```sh
cd /home/kp/dotfiles
./scripts/deploy-user.sh check
```

Depois crie os links individuais:

```sh
cd /home/kp/dotfiles
./scripts/deploy-user.sh deploy
```

O script aborta em caso de conflito. Ele não adota, move ou sobrescreve arquivos
existentes.

### 4. Integração com o GDM

Instale a entrada versionada em `/usr/local/share`, que tem precedência sobre
dados de pacotes e não altera as sessões do GNOME:

```sh
sudo install -Dm0644 /home/kp/dotfiles/system/wayland-sessions/hyprland-dotfiles.desktop /usr/local/share/wayland-sessions/hyprland-dotfiles.desktop
```

### 5. Serviços

Não há serviço global para habilitar. UWSM cria a sessão systemd do usuário.
Waybar, Mako, Hyprpaper, Hypridle, o agente Polkit e os watchers do clipboard
iniciam dentro dessa sessão. Os portais iniciam por D-Bus.

### 6. Validação antes do logout

```sh
cd /home/kp/dotfiles
./scripts/verify.sh --deployed --runtime
```

```sh
test -f /usr/local/share/wayland-sessions/hyprland-dotfiles.desktop
ls -l /usr/local/share/wayland-sessions/hyprland-dotfiles.desktop
```

```sh
find /home/kp/dotfiles -user root -print
```

O último comando não deve imprimir nada.

### 7. Primeiro login

1. Encerre a sessão do GNOME.
2. No GDM, abra o seletor de sessões.
3. Escolha `Hyprland (UWSM, dotfiles)`.
4. Entre normalmente.

GNOME continua disponível no mesmo seletor.

## Atalhos principais

| Atalho | Ação |
| --- | --- |
| `Super+Return` | Kitty |
| `Super+Space` | Fuzzel |
| `Super+F` | Nautilus |
| `Super+V` | histórico do clipboard |
| `Super+Escape` | menu de sessão |
| `Super+Alt+L` | bloquear |
| `Super+W` | fechar janela |
| `Super+T` | alternar janela flutuante |
| `Super+M` | tela cheia |
| `Super+H/J/K/L` ou setas | mover foco |
| `Super+Shift+H/J/K/L` ou setas | mover janela |
| `Super+1..0` | mudar de workspace |
| `Super+Shift+1..0` | mover janela para workspace |
| `Super+S` | scratchpad |
| `Print` | capturar o monitor ativo |
| `Shift+Print` | capturar uma região |
| `Super+Print` | capturar a janela ativa |

As teclas de áudio chamam `wpctl` diretamente. As teclas de mídia chamam
`playerctl`. Capturas são copiadas para o clipboard e salvas em
`~/Pictures/Screenshots`.

## Estrutura

```text
hypr/       compositor, regras, atalhos, lock, idle, wallpaper e scripts
uwsm/       ambiente carregado antes da sessão
waybar/     barra e estilo
fuzzel/     launcher e menus
mako/       notificações
portal/     seleção de backends somente para o desktop Hyprland
kitty/      terminal e tema
theme/      paleta, licença e templates de geração
system/     fonte da entrada de sessão do GDM
scripts/    implantação, geração de temas e verificações
```

O arquivo `hyprland.lua` carrega apenas módulos relativos em `modules/`. As
configurações do Hyprpaper, Hyprlock e Hypridle usam apenas arquivos que chegam
a `~/.config/hypr` pelos links deste repositório.

## Portais

`hyprland-portals.conf` escolhe o backend Hyprland como padrão da sessão e o
backend GTK para file chooser, app chooser e impressão. Na sessão GNOME, o
frontend continua carregando `gnome-portals.conf` fornecido pelo Fedora. Nenhum
pacote ou arquivo do portal GNOME é removido.

## Tema

`theme/catppuccin-mocha.json` é a fonte das cores. A paleta veio do projeto
Catppuccin e mantém sua licença MIT em `theme/LICENSE-catppuccin`.

Para regenerar os temas depois de editar a paleta:

```sh
cd /home/kp/dotfiles
./scripts/generate-themes.py
./scripts/generate-themes.py --check
```

O gerador produz os arquivos do Hyprland, Hyprlock, Waybar, Fuzzel, Mako e
Kitty. Ele não é chamado no login. O wallpaper é uma imagem abstrata original
gerada para esta configuração e está versionado em `hypr/.config/hypr/assets`.

## Atualização e manutenção

Depois de atualizar o repositório:

```sh
cd /home/kp/dotfiles
./scripts/generate-themes.py --check
./scripts/deploy-user.sh restow
./scripts/verify.sh --deployed --runtime
```

Recarregue somente os componentes modificados:

```sh
hyprctl reload
pkill -SIGUSR2 waybar
makoctl reload
```

Alterações em `uwsm/env*`, permissões do Hyprland ou na entrada do GDM exigem
novo login. Não baixe temas durante a sessão e não copie configurações para
`~/.config` manualmente.

## Diagnóstico após o primeiro login

```sh
printf 'desktop=%s\nsession=%s\n' "$XDG_CURRENT_DESKTOP" "$XDG_SESSION_TYPE"
uwsm check is-active
hyprctl version
hyprctl configerrors
hyprctl monitors -j | jq '.[] | {name, width, height, refreshRate, scale}'
```

```sh
systemctl --user --no-pager --failed
systemctl --user --no-pager status xdg-desktop-portal.service xdg-desktop-portal-hyprland.service
journalctl --user -b --no-pager -u xdg-desktop-portal.service -u xdg-desktop-portal-hyprland.service
```

```sh
wpctl status
notify-send 'Hyprland validation' 'Mako is receiving notifications'
printf 'clipboard-validation' | wl-copy
wl-paste
```

Valide manualmente Fuzzel, o seletor de arquivos de um aplicativo Flatpak,
compartilhamento de tela, Pavucontrol, bloqueio, retorno do idle, menu Polkit e
os três modos de screenshot. O registro completo está em `docs/validation.md`.

## Rollback

### Links do usuário

```sh
cd /home/kp/dotfiles
./scripts/deploy-user.sh remove
```

### Entrada do GDM

```sh
sudo rm -f /usr/local/share/wayland-sessions/hyprland-dotfiles.desktop
```

### Pacotes instalados para esta sessão

Revise a transação antes de confirmar:

```sh
sudo dnf remove hyprland uwsm hyprlock hypridle hyprpaper xdg-desktop-portal-hyprland waybar fuzzel mako cliphist grim slurp pavucontrol playerctl lxqt-policykit jetbrains-mono-fonts fontawesome-6-free-fonts
```

```sh
sudo dnf copr disable lionheartp/Hyprland
```

### Código

Voltar para `main` restaura o commit-base sem reescrever a branch de trabalho:

```sh
cd /home/kp/dotfiles
git switch main
git rev-parse HEAD
```

O último comando deve imprimir
`2bc69b2becb3d7e3aefa554fa1a1cd26f3d4d1d7`. O rollback não remove GNOME,
GDM, PipeWire, WirePlumber nem qualquer portal que já estava instalado.
