local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")
local gears = require("gears")

--remove tmux keybinds from hotkeys menu
package.loaded["awful.hotkeys_popup.keys.tmux"] = {}

-- Themes define colours, icons, font and wallpapers.
beautiful.init(require("config.theme"))

-- Init all modules
require("config.modules.notifications")
--require("config.modules.notifications")

-- Setup all configs
require("config.rules")
require("config.layouts")
require("config.topbar")
require("config.apps.defaultapps")
require("config.apps.startupapps")
require("config.menu")

--Set keybinds and buttons
root.keys(require("config.keys.global").keys)
root.buttons(require("config.keys.global").buttons)


-- {{{ Signals
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
--[[
screen.connect_signal("property::geometry", function () 
    awful.spawn.with_shell("nitrogen --restore") 
end)]]

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)



client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)
-- }}}

-- No border for maximized clients
function border_adjust(c)
    if c.maximized then -- no borders if only 1 client visible
        c.border_width = 0
    else
        c.border_width = beautiful.border_width
        c.border_color = beautiful.border_focus
    end
end
client.connect_signal("focus", border_adjust)
client.connect_signal("property::maximized", border_adjust)

--set garbage collector 
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)

