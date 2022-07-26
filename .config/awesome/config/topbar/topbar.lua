local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi   = require("beautiful.xresources").apply_dpi
local gears_shape = require("gears.shape")

local topbar_buttons = require("config.keys.topbar_buttons")

local volume_widget   = require("config.topbar.widgets.volume")
local binclock_widget = require("config.topbar.widgets.binclock")
local calendar_widget = require("config.topbar.widgets.calendar")

local icons = require("config.topbar.iconcharacters.icons_binary")

awful.screen.connect_for_each_screen(function(s)

    --tags--------------------------------------------------------------------------
    for i = 1, 9, 1 do
        awful.tag.add(i, {
            icon = icons[i],
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
        buttons = topbar_buttons.taglist,
        widget_template = beautiful.taglist_widget_template,
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
    s.systray_widget = wibox.container.background(
        wibox.widget({
            image = icons.systrayoff,
            widget = wibox.widget.imagebox
        }),
        nil,
        function(cr,w,h)
            gears_shape.rounded_rect(
                cr, w, h, 3
            )
        end
    )
    topbar_buttons.systray(s.systray_widget, s.systray, icons.systrayon, icons.systrayoff)
    s.systray_widget:connect_signal('mouse::enter', function()
            if s.systray_widget.bg ~= beautiful.hover_color then
                s.systray_widget.backup     = s.systray_widget.bg
                s.systray_widget.has_backup = true
            end
            s.systray_widget.bg = beautiful.hover_color
        end)
    s.systray_widget:connect_signal('mouse::leave', function()
            if s.systray_widget.has_backup then s.systray_widget.bg = s.systray_widget.backup end
    end)

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
                s.volicon1.image = icons.volmuted
                s.volicon2.image = icons.volmuted
            else
                s.volicon1.image = icons[math.floor(perc/10)]
                s.volicon2.image = icons[(perc%10)]
            end
    end})
    topbar_buttons.volume_widget(s.volicon1, s.volume)
    topbar_buttons.volume_widget(s.volicon2, s.volume)

    --separator---------------------------------------------------------------------
    local function separator(width)
        return wibox.widget({forced_width = dpi(width)})
    end

    --Create the wibox--------------------------------------------------------------
    s.mywibox = awful.wibar({ position = "top", screen = s, height = "23" })

    --Add widgets to the wibox------------------------------------------------------
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mylayoutbox,
            separator(5),
            s.mytaglist,
            separator(10),
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            s.systray,
            separator(10),
            s.systray_widget,--wibox.widget.systray(),
            separator(10),
            s.volicon,
            separator(10),
            s.binclock,
        },
    }
end)