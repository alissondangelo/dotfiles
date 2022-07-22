local awful = require("awful")

awful.util.mymainmenu = awful.menu({ items = {
         { "Log out", function() awesome.quit() end },
         { "Sleep", "systemctl suspend" },
         { "Restart", "reboot" },
         { "Power Off", "shutdown now" },
         -- other triads can be put here
     }
 })
 -- Menubar configuration
awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function() awful.util.mymainmenu:hide() end)