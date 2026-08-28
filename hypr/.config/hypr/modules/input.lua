hl.config({
  input = {
    kb_layout = "us",
    kb_variant = "intl",
    kb_options = "compose:ralt,shift:both_capslock_cancel,grp:alts_toggle",
    follow_mouse = 1,
    sensitivity = 0.35,
    accel_profile = "flat",
    repeat_rate = 40,
    repeat_delay = 250,
    numlock_by_default = true,
    touchpad = {
      natural_scroll = true,
      clickfinger_behavior = true,
      tap_to_click = true,
    },
  },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
