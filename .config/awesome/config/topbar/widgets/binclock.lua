local gears  = require("gears")
local wibox  = require("wibox")
local dpi    = require("beautiful.xresources").apply_dpi
local date   = os.date
local string = string
local beautiful = require("beautiful")
local helpers = require("config.helpers")

local binclock = {}

local function factory(args)
    local args = args or {}

    binclock.show_seconds    = args.show_seconds or false
    binclock.gap             = args.gap or 1.5

    local clock = {}
    for i = 0, 6, 1 do
        clock[i] = wibox.widget.imagebox(beautiful.icons_topbar[0])
    end

    binclock.set = function()
        local t = date("*t")
        local hour = string.format("%02d", t.hour)
        local min  = string.format("%02d", t.min)
        local sec  = string.format("%02d", t.sec)
        clock[0].image = beautiful.icons_topbar[tonumber(string.sub(hour, 1, 1))]
        clock[1].image = beautiful.icons_topbar[tonumber(string.sub(hour, 2, 2))]
        clock[2].image = beautiful.icons_topbar[tonumber(string.sub(min, 1, 1))]
        clock[3].image = beautiful.icons_topbar[tonumber(string.sub(min, 2, 2))]
        if binclock.show_seconds then
            clock[4].image = beautiful.icons_topbar[tonumber(string.sub(sec, 1, 1))]
            clock[5].image = beautiful.icons_topbar[tonumber(string.sub(sec, 2, 2))]
        else
            clock[4] = nil
            clock[5] = nil
        end

    end
    binclock.set()

    binclock.widget = wibox.widget{
        {
            {
                {
                    clock[0],
                    clock[1],
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = dpi(binclock.gap),
                right = dpi(binclock.gap),
                widget  = wibox.container.margin,
            },
            {
                {
                    clock[2],
                    clock[3],
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = dpi(binclock.gap),
                right = dpi(binclock.gap),
                widget  = wibox.container.margin,
            },
            {
                {
                    clock[4],
                    clock[5],
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = dpi(binclock.gap),
                right = dpi(binclock.gap),
                widget  = wibox.container.margin,
            },
            layout = wibox.layout.fixed.horizontal,
        },
        shape = helpers.rounded_rect_shape(),
        widget = wibox.container.background,
    }

    binclock.timer = gears.timer {
        autostart  = true,
        timeout    = binclock.show_seconds and 1 or 60,
        callback   = function()
           binclock.set()
        end
    }

    return binclock.widget
end

return factory