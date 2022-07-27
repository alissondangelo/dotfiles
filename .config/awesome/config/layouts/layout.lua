local awful = require("awful")
local my_layouts = require("config.layouts.my_layouts")

awful.layout.layouts = {
    awful.layout.suit.tile,
	my_layouts.centerwork,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
    awful.layout.suit.spiral.dwindle,

    --[[
    awful.layout.suit.floating,
    awful.layout.suit.tile.top,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.fair,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    awful.layout.suit.corner.ne,
    awful.layout.suit.corner.sw,
    awful.layout.suit.corner.se,
    lain.layout.cascade,
    lain.layout.cascade.tile,
    lain.layout.centerwork,
    lain.layout.centerwork.horizontal,
    lain.layout.termfair,
    lain.layout.termfair.center,
    ]]
}