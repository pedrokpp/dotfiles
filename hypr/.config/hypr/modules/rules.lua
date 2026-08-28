hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_in = 0, gaps_out = 0 })
hl.workspace_rule({ workspace = "f[1]s[false]", gaps_in = 0, gaps_out = 0 })

hl.window_rule({
  name = "smart-gaps-single-window",
  match = { float = false, workspace = "w[tv1]s[false]" },
  border_size = 0,
  rounding = 0,
})
hl.window_rule({
  name = "smart-gaps-fullscreen",
  match = { float = false, workspace = "f[1]s[false]" },
  border_size = 0,
  rounding = 0,
})
hl.window_rule({
  name = "suppress-maximize-requests",
  match = { class = ".*" },
  suppress_event = "maximize",
})
hl.window_rule({
  name = "float-system-dialogs",
  match = { class = "^(pavucontrol|nm-connection-editor|blueman-manager)$" },
  float = true,
  center = true,
  size = "70% 75%",
})
hl.window_rule({
  name = "float-file-choosers",
  match = { title = "^(Open File|Open Files|Save File|Save As|Select a File).*$" },
  float = true,
  center = true,
  size = "75% 80%",
})
hl.window_rule({
  name = "fix-xwayland-drag-focus",
  match = {
    class = "^$", title = "^$", xwayland = true,
    float = true, fullscreen = false, pin = false,
  },
  no_focus = true,
})

hl.layer_rule({ name = "blur-launcher", match = { namespace = "^launcher$" }, blur = true })
hl.layer_rule({ name = "blur-notifications", match = { namespace = "^notifications$" }, blur = true })
