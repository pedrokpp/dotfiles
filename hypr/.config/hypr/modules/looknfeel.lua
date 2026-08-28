local theme = require("modules.theme")

hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 10,
    border_size = 2,
    resize_on_border = true,
    allow_tearing = false,
    layout = "dwindle",
    col = {
      active_border = { colors = { theme.mauve, theme.blue }, angle = 45 },
      inactive_border = theme.surface1,
    },
  },
  decoration = {
    rounding = 10,
    rounding_power = 2,
    active_opacity = 1.0,
    inactive_opacity = 0.94,
    shadow = { enabled = true, range = 12, render_power = 3, color = "rgba(11111bcc)" },
    blur = { enabled = true, size = 8, passes = 3, vibrancy = 0.17 },
  },
  animations = { enabled = true },
  dwindle = { preserve_split = true, smart_split = true },
  master = { new_status = "master" },
  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    force_default_wallpaper = 0,
    focus_on_activate = true,
    background_color = "0x1e1e2e",
    font_family = "JetBrains Mono",
  },
  binds = { movefocus_cycles_fullscreen = true, workspace_center_on = 1 },
  xwayland = { force_zero_scaling = true },
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeOutExpo", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.8, bezier = "easeOutExpo" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutExpo", style = "popin 88%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3.2, bezier = "easeInOutCubic", style = "popin 88%" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.0, bezier = "easeOutQuint" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4.0, bezier = "easeOutExpo", style = "slide" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.8, bezier = "easeOutQuint", style = "fade" })
