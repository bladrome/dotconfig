
local wezterm = require 'wezterm';


-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end


-- For example, changing the color scheme:
config.color_scheme = 'Argonaut'


-- Controls whether the tab bar is enabled
config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

-- gpu end
-- config.front_end = "OpenGL"

-- animation set
config.animation_fps = 60
config.max_fps = 60

-- enable wayland
config.enable_wayland = true
-- config.enable_wayland = false

-- Cursor set
config.force_reverse_video_cursor = true
-- window padding
win_padding = 5
config.window_padding = {
  left = win_padding,
  right = win_padding,
  top = win_padding,
  bottom = win_padding,
}

-- Window Transparent
config.window_background_opacity = 0.75
config.text_background_opacity = 1.0

-- font set
config.font = wezterm.font("Fira Code")
config.font_size = 11
config.cell_width = 1.1
config.line_height = 1.1
config.dpi = 96.0

-- scroll set
config.alternate_buffer_wheel_scroll_speed = 1

-- window set
config.window_decorations = 'NONE'
config.window_close_confirmation = 'NeverPrompt'
-- and finally, return the configuration to wezterm

config.warn_about_missing_glyphs = false
config.audible_bell  = "Disabled"

return config
