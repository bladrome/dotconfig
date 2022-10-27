local filesystem = require("gears.filesystem")
local beautiful = require("beautiful")
local config_dir = filesystem.get_configuration_dir()
local utils_dir = config_dir .. "utilities/"
local default_apps = {}

default_apps.screeh_shot = "spectacle"
default_apps.lock_screen = "slock"
default_apps.software_updater = "kitty --title 'System upgrade' -e sudo pacman -Syu"
default_apps.bluetooth_manager = "kitty -e bluetoothctl"
default_apps.network_manager = "kitty -e nmtui"
default_apps.app_menu = "rofi -show drun -theme ~/.config/rofi/config"
default_apps.terminal = "wezterm"
default_apps.web_browser = "firefox"
default_apps.file_manager = "pcmanfm"

default_apps.full_screenshot = utils_dir .. 'snap full'
default_apps.area_screenshot = utils_dir .. 'snap area'
default_apps.update_profile  = utils_dir .. 'profile-image'


return default_apps
