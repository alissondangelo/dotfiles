local awful = require("awful")

terminal = "alacritty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
fileManager = "pcmanfm" 
browser1 = "brave"
browser2 = "firefox"
browser3 = "librewolf"