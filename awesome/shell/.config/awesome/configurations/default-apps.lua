local filesystem = require("gears.filesystem")
local beautiful = require("beautiful")
local config_dir = filesystem.get_configuration_dir()
local utils_dir = config_dir .. "utilities/"
local default_apps = {}

default_apps.screeh_shot = "spectacle"
default_apps.lock_screen = config_dir .. "scripts/i3lock-blur "
default_apps.software_updater = "kitty --title 'System upgrade' -e sudo pacman -Syu"
default_apps.bluetooth_manager = "kitty -e bluetoothctl"
default_apps.network_manager = "kitty -e nmtui"
default_apps.app_menu = "rofi -dpi " .. screen.primary.dpi ..
						" -show drun -theme " .. config_dir ..
						"configurations/rofi-".. beautiful.mode ..".rasi -icon-theme " ..
						beautiful.icon_theme
default_apps.terminal = "alacritty"
default_apps.web_browser = "firefox"
default_apps.file_manager = "pcmanfm"

default_apps.full_screenshot = utils_dir .. 'snap full'
default_apps.area_screenshot = utils_dir .. 'snap area'
default_apps.update_profile  = utils_dir .. 'profile-image'


return default_apps
