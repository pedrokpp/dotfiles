-- Acer QG241Y S on DisplayPort. GNOME reports 164.998 Hz for this mode.
hl.monitor({ output = "DP-2", mode = "1920x1080@165", position = "0x0", scale = 1 })

-- Safe fallback for an additional or renamed output.
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
