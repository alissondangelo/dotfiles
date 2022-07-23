local awful = require("awful")

awful.util.mymainmenu = awful.menu({ items = {
    { "🫡 Log out", function() awesome.quit() end },
    { "🤐 Lock", function() awful.spawn.with_shell("xset dpms force off && slock")end},
    { "😴 Sleep", "systemctl suspend" },
    { "🙃 Restart", "reboot" },
    { "😔 Power Off", "shutdown now" }, 
    -- other triads can be put here
}})
 -- Hide on mouse leave
awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function() awful.util.mymainmenu:hide() end)