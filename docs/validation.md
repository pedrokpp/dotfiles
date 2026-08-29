# Registro de validação

Data inicial: 2026-08-28.

## Testes estáticos concluídos

| Teste | Comando ou evidência | Resultado |
| --- | --- | --- |
| Branch e base | `git status`, `git rev-parse HEAD` | branch `hyprland-standalone`, base `2bc69b2b...` |
| Worktree inicial | `git status --short --branch` | limpo antes das edições |
| Fedora e GNOME | `/etc/os-release`, RPM e variáveis XDG | Fedora 44, GNOME 50 Wayland |
| GPU | `lspci -nnk` | RX 6650 XT, `amdgpu` |
| Monitor | `~/.config/monitors.xml` lido sem alteração | DP-2, 1920x1080, 164.998 Hz |
| Pacotes instalados | `rpm -q`, `dnf list --installed` | inventário registrado no README |
| Pacotes Fedora | `dnf repoquery --cacheonly` | utilitários confirmados nos repositórios oficiais |
| Origem do Hyprland | [wiki oficial](https://wiki.hypr.land/Getting-Started/Installation/) e [índice do COPR](https://copr-be.cloud.fedoraproject.org/results/lionheartp/Hyprland/fedora-44-x86_64/) | `lionheartp/Hyprland` indicado para Fedora, com builds Fedora 44 recentes |
| Candidatos do COPR | `dnf repoquery --latest-limit=1` | Hyprland 0.56.2, UWSM 0.26.4, Hyprlock 0.9.6, Hypridle 0.1.8, Hyprpaper 0.8.4 e XDPH 1.4.1 para Fedora 44 |
| Instalação | transação DNF sem dependências fracas | 43 pacotes instalados, 90 MiB, sem remoções ou downgrades |
| Dependências de runtime | `scripts/verify.sh --runtime` | todos os comandos e RPMs obrigatórios presentes |
| Configuração do Hyprland | `Hyprland --verify-config --config .../hyprland.lua` | `config ok` com Hyprland 0.56.2 |
| GNOME preservado | `rpm -q` | GDM, GNOME Shell, GNOME Session e portais GNOME e GTK continuam instalados |
| Lua | parser Lua embutido no Neovim | todos os módulos aceitos |
| Shell | `bash -n`, `sh -n` | todos os scripts aceitos |
| JSON e INI | `jq`, `configparser` | estruturas aceitas |
| Temas gerados | `scripts/generate-themes.py --check` | sincronizados com a paleta |
| Stow | `scripts/deploy-user.sh check` | sem conflitos; somente simulação |
| Referências proibidas | `scripts/verify.sh` | nenhuma encontrada |
| Imports externos | `scripts/verify.sh` | nenhum encontrado |
| Proprietário root | `scripts/verify.sh` | nenhum arquivo encontrado |
| Artefatos locais | `scripts/verify.sh` | nenhum encontrado |
| Whitespace | `git diff --check` | aprovado |
| Wallpaper | inspeção visual e `file` | PNG 1672x941, 16:9, sem texto ou marca |

Comando agregado executado:

```sh
cd /home/kp/dotfiles
./scripts/verify.sh
```

Resultado: todos os checks solicitados passaram.

## Validações pendentes

Estas verificações dependem da instalação de pacotes, implantação dos links e
um login real na sessão:

- carregamento do Lua sem `hyprctl configerrors`;
- `DP-2` em 1920x1080 a aproximadamente 165 Hz;
- Waybar, Fuzzel, Mako, wallpaper, clipboard e screenshots;
- Hyprlock, callbacks do Hypridle e suspensão;
- agente Polkit;
- PipeWire, WirePlumber, teclas de áudio e Pavucontrol;
- portal Hyprland para screencast e portal GTK para seleção de arquivo;
- sessão UWSM sem unidades do usuário em estado failed;
- sessão GNOME ainda selecionável e funcional no GDM;
- inicialização completa com a rede desativada.

Não considere esses itens aprovados antes do primeiro login e dos comandos de
diagnóstico documentados no README.
