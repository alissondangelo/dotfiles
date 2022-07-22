--[[

     Licensed under GNU General Public License v2
      * (c) 2017, Luca CPZ
      * (c) 2013, romockee

--]]

local gears  = require("gears")
local wibox  = require("wibox")
local dpi    = require("beautiful.xresources").apply_dpi
local date   = os.date
local ipairs = ipairs
local math   = math
local select = select
local string = string


local binclock = {}

function binclock.dec2bin(num, bits)
    local bits, t = bits or select(2, math.frexp(num)), {}
    for b = bits, 1, -1 do
        t[b] = math.fmod(num, 2)
        num = (num - t[b]) / 2
    end
    return t
end

function binclock.paintdot(cr, val, shift)
    local height = 0
    for _, bit in ipairs(binclock.dec2bin(val, 4)) do
        if bit >= 1 then
            cr:set_source(gears.color(binclock.color_active))
        else
            cr:set_source(gears.color(binclock.color_inactive))
        end
        cr:rectangle(shift, height, binclock.dotsize, binclock.dotsize)
        cr:fill()
        height = height + binclock.dotsize + binclock.step
    end
end

local function factory(args)
    local args = args or {}

    binclock.number         = args.number or 0
    binclock.width          = args.width or dpi(42)
    binclock.height         = args.height or dpi(18)
    binclock.show_seconds   = args.show_seconds or false
    binclock.color_active   = args.color_active or "#CCCCCC"
    binclock.color_inactive = args.color_inactive or "#666666"
    binclock.dotsize        = math.floor(binclock.height / 5)
    binclock.step           = math.floor(binclock.dotsize / 3)

    binclock.widget = wibox.widget {
        fit = function(self, context, width, height)
            return binclock.width, binclock.height
        end,
        draw = function(self, context, cr, width, height)

            local numberbin = string.format("%02d", binclock.number)

            local col_count = 2
            if binclock.show_seconds then
                col_count = 2
            end
            local step = math.floor((binclock.width - col_count * binclock.dotsize) /8)

            binclock.paintdot(cr, string.sub(numberbin, 1, 1), step, 2)
            binclock.paintdot(cr, string.sub(numberbin, 2, 2), binclock.dotsize + 2 * step)
        end,
        layout = wibox.widget.base.make_widget
    }
    return binclock
end

return factory
