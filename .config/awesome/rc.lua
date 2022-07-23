require("awful.autofocus")
local beautiful = require("beautiful")

--remove tmux keybinds from hotkeys menu
package.loaded["awful.hotkeys_popup.keys.tmux"] = {}

-- Themes define colours, icons, font and wallpapers.
beautiful.init(require("config.theme"))

-- Init all modules
require("config.modules.notifications")
require("config.signals")

-- Setup all configs
require("config.rules")
require("config.layouts")
require("config.topbar")
require("config.menu")
require("config.apps.defaultapps")
require("config.apps.startupapps")

--Set keybinds and buttons
root.keys(require("config.keys.global").keys)
root.buttons(require("config.keys.global").buttons)

--set garbage collector 
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)

