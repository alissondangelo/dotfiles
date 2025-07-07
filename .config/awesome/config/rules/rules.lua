local awful = require("awful")
local beautiful = require("beautiful")

local client_keys = require("config.keys.client")

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule------------------------
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = client_keys.keys,
            buttons = client_keys.buttons,
            --screen = awful.screen.preferred,
            screen = awful.screen.focused,
            size_hints_honor = false,
            honor_workarea = true,
            honor_padding = true,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen + awful.placement.centered
        }
    },

    --Floating clients-----------------------------------------
    {
        rule_any = {
            instance = {
                "floating", -- Launc alacritty with --class floating
                "DTA",      -- Firefox addon DownThemAll.
                "copyq",    -- Includes session name in class.
                "pinentry"
            },
            class = {
                "Nvidia-settings",
                "Lxappearance",
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "mpv",
                "Yad"
                -- Note that the name property shown in xprop might be set slightly after creation of the client
                -- and the name shown there might not match defined rules here.
            },
            name = {
		"Archive Manager",
                "Event Tester" -- xev.
            },
            role = {
                "GtkFileChooserDialog",
                "AlarmWindow",   -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up"         -- e.g. Google Chrome's (detached) Developer Tools.
            },
            type = { "dialog" }
        },
        properties = { floating = true }
    },

    --Fullscreen clients-----------------------------------------
    {
        rule_any = {
            class = {
                "feh",
            },
        },
        properties = { fullscreen = true }
    },

    --Maximized clients------------------------------------------
    {
        rule_any = {
            class = {
                class = {
                    "Gimp*",
                    "inkscape"
                },
                role = "gimp-image-window"
            },
        },
        properties = { maximized = true }
    },

    --Specific Tag clients---------------------------------------
    --[[{
        rule_any = {
            class = {
                "Gwe",
                "Pavucontrol" }
        },
        properties = { screen = 1, tag = "9" }
    },]]-- 
    --{ rule = { class = "discord" }, properties = { screen = 1, tag = "8" } }
}
