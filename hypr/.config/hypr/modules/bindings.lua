local config_home = os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")
local scripts = config_home .. "/hypr/scripts"

hl.bind("SUPER + Return", hl.dsp.exec_cmd("uwsm app -- kitty"))
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("uwsm app -- fuzzel"))
hl.bind("SUPER + F", hl.dsp.exec_cmd("uwsm app -- org.gnome.Nautilus.desktop"))
hl.bind("SUPER + V", hl.dsp.exec_cmd(scripts .. "/clipboard-menu"))
hl.bind("SUPER + ESCAPE", hl.dsp.exec_cmd(scripts .. "/power-menu"))
hl.bind("SUPER + ALT + L", hl.dsp.exec_cmd("hyprlock"))

hl.bind("SUPER + W", hl.dsp.window.close())
hl.bind("SUPER + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + M", hl.dsp.window.fullscreen())
hl.bind("SUPER + P", hl.dsp.window.pseudo())
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("scratchpad"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:scratchpad" }))

for _, direction in ipairs({ "left", "right", "up", "down" }) do
  hl.bind("SUPER + " .. direction, hl.dsp.focus({ direction = direction }))
  hl.bind("SUPER + SHIFT + " .. direction, hl.dsp.window.move({ direction = direction }))
end

local vim_directions = { H = "left", L = "right", K = "up", J = "down" }
for key, direction in pairs(vim_directions) do
  hl.bind("SUPER + " .. key, hl.dsp.focus({ direction = direction }))
  hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ direction = direction }))
end

for workspace = 1, 10 do
  local key = workspace % 10
  hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = workspace }))
  hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
end

hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("Print", hl.dsp.exec_cmd(scripts .. "/screenshot output"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd(scripts .. "/screenshot area"))
hl.bind("SUPER + Print", hl.dsp.exec_cmd(scripts .. "/screenshot window"))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
