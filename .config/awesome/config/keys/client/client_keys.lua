local awful = require("awful")
local mytable = require("gears.table")

local modkey = require('config.keys.mod_keys').modKey

local helpers = require("config.keys.helpers")

local clientkeys = mytable.join(
-- Move to edge or swap by direction
    awful.key({ modkey, "Shift" }, "j", function(c) helpers.move_client_dwim(c, "down") end,
        { description = "move client down", group = "client" }),
    awful.key({ modkey, "Shift" }, "k", function(c) helpers.move_client_dwim(c, "up") end,
        { description = "move client up", group = "client" }),
    awful.key({ modkey, "Shift" }, "h", function(c) helpers.move_client_dwim(c, "left") end,
        { description = "move client left", group = "client" }),
    awful.key({ modkey, "Shift" }, "l", function(c) helpers.move_client_dwim(c, "right") end,
        { description = "move client right", group = "client" }),
    awful.key({ modkey, "Shift" }, "Down", function(c) helpers.move_client_dwim(c, "down") end,
        { description = "move client down", group = "client" }),
    awful.key({ modkey, "Shift" }, "Up", function(c) helpers.move_client_dwim(c, "up") end,
        { description = "move client up", group = "client" }),
    awful.key({ modkey, "Shift" }, "Left", function(c) helpers.move_client_dwim(c, "left") end,
        { description = "move client left", group = "client" }),
    awful.key({ modkey, "Shift" }, "Right", function(c) helpers.move_client_dwim(c, "right") end,
        { description = "move client right", group = "client" }),

    -- Resize focused client or layout factor
    awful.key({ modkey, "Control" }, "j", function(c) helpers.resize_dwim(client.focus, "down") end,
        { description = "resize client down", group = "client" }),
    awful.key({ modkey, "Control" }, "k", function(c) helpers.resize_dwim(client.focus, "up") end,
        { description = "resize client up", group = "client" }),
    awful.key({ modkey, "Control" }, "h", function(c) helpers.resize_dwim(client.focus, "left") end,
        { description = "resize client left", group = "client" }),
    awful.key({ modkey, "Control" }, "l", function(c) helpers.resize_dwim(client.focus, "right") end,
        { description = "resize client right", group = "client" }),
    awful.key({ modkey, "Control" }, "Down", function(c) helpers.resize_dwim(client.focus, "down") end,
        { description = "resize client down", group = "client" }),
    awful.key({ modkey, "Control" }, "Up", function(c) helpers.resize_dwim(client.focus, "up") end,
        { description = "resize client up", group = "client" }),
    awful.key({ modkey, "Control" }, "Left", function(c) helpers.resize_dwim(client.focus, "left") end,
        { description = "resize client left", group = "client" }),
    awful.key({ modkey, "Control" }, "Right", function(c) helpers.resize_dwim(client.focus, "right") end,
        { description = "resize client right", group = "client" }),

    --opacity
    awful.key({ modkey, }, "o", function(c) c.opacity = 1 end,
        { description = "disable client transparency", group = "client" }),

    awful.key({ modkey, }, "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        { description = "toggle fullscreen", group = "client" }),
    awful.key({ modkey }, "q", function(c) c:kill() end,
        { description = "close", group = "client" }),
    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle,
        { description = "toggle floating", group = "client" }),
    awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
        { description = "move to master", group = "client" }),
    awful.key({ modkey, }, "o", function(c) c:move_to_screen() end,
        { description = "move to screen", group = "client" }),
    awful.key({ modkey, }, "ç", function(c) c.ontop = not c.ontop end,
        { description = "toggle keep on top", group = "client" }),


    -- maximize e minimize
    awful.key({ modkey, }, "n",
        function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        { description = "minimize", group = "client" }),
    awful.key({ modkey, }, "m",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        { description = "(un)maximize", group = "client" }),
    awful.key({ modkey, "Control" }, "m",
        function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end,
        { description = "(un)maximize vertically", group = "client" }),
    awful.key({ modkey, "Shift" }, "m",
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end,
        { description = "(un)maximize horizontally", group = "client" })
)

return clientkeys
