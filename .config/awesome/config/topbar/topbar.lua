local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi   = require("beautiful.xresources").apply_dpi

local topbar_buttons = require("config.keys.topbar_buttons")

local volume_widget   = require("config.topbar.widgets.volume")
local binclock_widget = require("config.topbar.widgets.binclock")
local calendar_widget = require("config.topbar.widgets.calendar")

local icons = require("config.topbar.iconcharacters.icons_binary")

awful.screen.connect_for_each_screen(function(s)

    --tags--------------------------------------------------------------------------
    for i = 1, 9, 1 do
        awful.tag.add(i, {
            icon = icons.tag[i],
            icon_only = true,
            layout = awful.layout.suit.spiral.dwindle,
            screen = s,
            selected = i == 1
        })
    end

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(topbar_buttons.layoutbox)
    -- Create a taglist widget
    -- beautiful.taglist_font = 14
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = topbar_buttons.taglist
    }
    -- and apply shape to it
    --[[if beautiful.taglist_shape_container then
        local background_shape_wrapper = wibox.container.background(s.mytaglist)
        background_shape_wrapper._do_taglist_update_now = s.mytaglist._do_taglist_update_now
        background_shape_wrapper._do_taglist_update = s.mytaglist._do_taglist_update
        background_shape_wrapper.shape = beautiful.taglist_shape_container
        background_shape_wrapper.shape_clip = beautiful.taglist_shape_clip_container
        background_shape_wrapper.shape_border_width = beautiful.taglist_shape_border_width_container
        background_shape_wrapper.shape_border_color = beautiful.taglist_shape_border_color_container
        s.mytaglist = background_shape_wrapper
    end
    --]]

    --tasklist widget-----------------------------------------------------------------
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        widget_template = beautiful.tasklist_widget_template,
        buttons = topbar_buttons.tasklist
    }

    --SysTray-------------------------------------------------------------------------
    s.systray = wibox.widget.systray()
    s.systray.visible = false
    s.systrayicon = wibox.widget.imagebox(icons.misc.systrayoff)
    topbar_buttons.systray(s.systrayicon, s.systray, icons.misc.systrayon, icons.misc.systrayoff)

	--Binary clock--------------------------------------------------------------------
    s.binclock = wibox.widget(binclock_widget{
        height = dpi(24),
        show_seconds = true,
        color_active = beautiful.fg_focus,
        color_inactive = "#555555"
    })

    --calendar----------------------------------------------------------------------
    s.cw = calendar_widget{
        attach_to = {s.binclock},
        week_start = 1,
        icons = "",
        notification_preset = {
            font = "Monospace 12",
            fg   = beautiful.fg_normal,
            bg   = beautiful.bg_normal,
            border_color = beautiful.tooltip_border_color,
            border_width = beautiful.tooltip_border_width,
            shape = beautiful.tooltip_shape
        }
    }

    --volume------------------------------------------------------------------------
    s.volicon1 = wibox.widget.imagebox(icons.volmuted)
    s.volicon2 = wibox.widget.imagebox(icons.volmuted)
    s.volicon = {
        s.volicon1,
        s.volicon2
    }
    s.volicon.layout = wibox.layout.fixed.horizontal
    s.volume = volume_widget({
        settings = function()
            local index, perc = "", tonumber(volume_now.level) or 0
            if volume_now.status == "off" then
                s.volicon1.image = icons.misc.volmuted
                s.volicon2.image = icons.misc.volmuted
            else
                s.volicon1.image = icons.number[math.floor(perc/10)]
                s.volicon2.image = icons.number[(perc%10)]
            end
    end})
    topbar_buttons.volume_widget(s.volicon1, s.volume)
    topbar_buttons.volume_widget(s.volicon2, s.volume)

    --separator---------------------------------------------------------------------
    s.separator = wibox.widget({textbox = "", forced_width = dpi(10)})

    --Create the wibox--------------------------------------------------------------
    s.mywibox = awful.wibar({ position = "top", screen = s, height = "23" })

    --Add widgets to the wibox------------------------------------------------------
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mylayoutbox,
            s.separator,
            s.mytaglist,
            s.separator,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            s.systray,
            s.separator,
            s.systrayicon,--wibox.widget.systray(),
            s.separator,
            s.volicon,
            s.separator,
            s.binclock,
        },
    }
end)