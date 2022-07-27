
local wezterm = require 'wezterm';

return {
  font = wezterm.font("Fira Code"),
  font_size = 14,
  color_scheme = "Argonaut",
  hide_tab_bar_if_only_one_tab = true,
  warn_about_missing_glyphs = false,
  audible_bell  = "Disabled",
  window_close_confirmation = "NeverPrompt",
}
