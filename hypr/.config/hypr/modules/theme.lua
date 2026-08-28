-- Generated from theme/catppuccin-mocha.json by scripts/generate-themes.py.
-- Do not edit color values here by hand.

local function rgba(hex, alpha)
  return "rgba(" .. hex .. (alpha or "ff") .. ")"
end

return {
  rosewater = rgba("f5e0dc"), flamingo = rgba("f2cdcd"),
  pink = rgba("f5c2e7"), mauve = rgba("cba6f7"),
  red = rgba("f38ba8"), maroon = rgba("eba0ac"),
  peach = rgba("fab387"), yellow = rgba("f9e2af"),
  green = rgba("a6e3a1"), teal = rgba("94e2d5"),
  sky = rgba("89dceb"), sapphire = rgba("74c7ec"),
  blue = rgba("89b4fa"), lavender = rgba("b4befe"),
  text = rgba("cdd6f4"), subtext1 = rgba("bac2de"),
  subtext0 = rgba("a6adc8"), overlay2 = rgba("9399b2"),
  overlay1 = rgba("7f849c"), overlay0 = rgba("6c7086"),
  surface2 = rgba("585b70"), surface1 = rgba("45475a"),
  surface0 = rgba("313244"), base = rgba("1e1e2e"),
  mantle = rgba("181825"), crust = rgba("11111b"),
}
