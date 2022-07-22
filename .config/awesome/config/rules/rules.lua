local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

local clientkeys = require("config.keys.client_keys")
local clientbuttons = require("config.keys.client_buttons")

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            --screen = awful.screen.preferred,
            screen = awful.screen.focused,
            size_hints_honor = false,
            honor_workarea = true,
            honor_padding = true,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen + awful.placement.centered
        }
    },

    -- Floating clients.
    {
        rule_any = {
            instance = {
                "floating", -- Launc alacritty with --class floating
                "DTA", -- Firefox addon DownThemAll.
                "copyq", -- Includes session name in class.
                "pinentry"
            },
            class = {
                "Nvidia-settings", 
                "File-roller", 
                "Lxappearance", 
                "Tor Browser",
                "mpv",
                "Yad"
                -- Needs a fixed window size to avoid fingerprinting by screen size.
                -- Note that the name property shown in xprop might be set slightly after creation of the client
                -- and the name shown there might not match defined rules here.
            },
            name = {
                "Event Tester" -- xev.
            },
            role = {
                "GtkFileChooserDialog", 
                "AlarmWindow", -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
            },
            type = {"dialog"}
        },
        properties = {floating = true}
    },

    -- Fullscreen clients
    {
        rule_any = {
            class = {
                "feh",
            },
        },
        properties = {fullscreen = true}
    },

    --[[ Maximized clients
    {
        rule_any = {
            class = {
                "Gimp",
            },
        },
        properties = {maximized = true}
    },]]


    -- Specific Tag clients
    {
        rule_any = {
            class = {
                "Gwe",
                "Pavucontrol"}
            },
        properties = {screen = 1, tag = "9"}
    }, {rule = {class = "discord"}, properties = {screen = 1, tag = "8"}}

    -- Add titlebars to normal clients and dialogs
    -- { rule_any = {type = { "normal", "dialog" }
    --   }, properties = { titlebars_enabled = true }
    -- },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}
