local awful = require("awful")
local mytable = require('gears.table')
local beautiful = require("beautiful")

local modkey = require('config.keys.mod_keys').modKey

local topbar_buttons = {
    --taglist-----------------------------------------------------------------------
    taglist = mytable.join(
        awful.button({        }, 1, function(t)
            t:view_only()
            beautiful.backup = beautiful.taglist_bg_focus
        end),
        awful.button({ modkey }, 1, function(t)
            if client.focus then
                client.focus:move_to_tag(t)
                beautiful.backup = beautiful.taglist_bg_occupied
            end
        end),
        awful.button({        }, 3, function(t)
            awful.tag.viewtoggle(t)
            beautiful.backup = beautiful.taglist_bg_focus
        end),
        awful.button({ modkey }, 3, function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end),
        awful.button({        }, 4, function(t) awful.tag.viewnext(t.screen) end),
        awful.button({        }, 5, function(t) awful.tag.viewprev(t.screen) end)
    ),

    --tasklist----------------------------------------------------------------------
    tasklist = mytable.join(
        awful.button({ }, 1, function (c)
                if c == client.focus then
                    c.minimized = true
                    beautiful.backup = beautiful.bg_minimize
                else
                    beautiful.backup = beautiful.tasklist_bg_focus
                    c:emit_signal(
                        "request::activate",
                        "tasklist",
                        {raise = true}
                    )
                end
            end),
        awful.button({ }, 2, function(c)
                c.kill(c)
            end),
        awful.button({ }, 3, function()
                awful.menu.client_list({ theme = { width = 250 } })
            end),
        awful.button({ }, 4, function ()
                awful.client.focus.byidx(1)
            end),
        awful.button({ }, 5, function ()
                awful.client.focus.byidx(-1)
            end)
    ),

    --layoutbox---------------------------------------------------------------------
    layoutbox = mytable.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end)
    ),

    --volume_widget-----------------------------------------------------------------
    volume_widget = function (volicon, volwidget)
        volicon:buttons(mytable.join (
            awful.button({}, 1, function() -- left click
                    awful.spawn(string.format("pavucontrol"))
                end),
            awful.button({}, 2, function() -- middle click
                    os.execute(string.format("%s set %s 100%%", volwidget.cmd, volwidget.channel))
                    volwidget.update()
                end),
            awful.button({}, 3, function() -- right click
                    os.execute(string.format("%s set %s toggle", volwidget.cmd, volwidget.togglechannel or volwidget.channel))
                    volwidget.update()
                end),
            awful.button({}, 4, function() -- scroll up
                    os.execute(string.format("%s set %s 1%%+", volwidget.cmd, volwidget.channel))
                    volwidget.update()
                end),
            awful.button({}, 5, function() -- scroll down
                    os.execute(string.format("%s set %s 1%%-", volwidget.cmd, volwidget.channel))
                    volwidget.update()
                end)
        ))
    end,

    --systray-----------------------------------------------------------------------
    systray = function (tray_widget, tray, icon_on, icon_off)
        tray_widget:buttons(mytable.join(
            awful.button({}, 1, function()
                tray.visible = not tray.visible
            end)
        ))
    end,
}

return topbar_buttons