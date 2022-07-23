local awful = require("awful")
local gears = require("gears")

local modkey = require('config.keys.mod_keys').modKey

local globalbuttons = gears.table.join(
    awful.button({        }, 3, function () awful.util.mymainmenu:toggle() end),
    awful.button({ modkey }, 4, awful.tag.viewnext),
    awful.button({ modkey }, 5, awful.tag.viewprev)
)

return globalbuttons