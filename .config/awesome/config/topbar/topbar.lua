local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi   = require("beautiful.xresources").apply_dpi
local awful_widget_clienticon = require("awful.widget.clienticon")
local topbar_buttons = require("config.keys.topbar_buttons")
local helpers = require("config.helpers")

local volume_widget   = require("config.topbar.widgets.volume")
local binclock_widget = require("config.topbar.widgets.binclock")
local calendar_widget = require("config.topbar.widgets.calendar")

awful.screen.connect_for_each_screen(function(s)

    --tags--------------------------------------------------------------------------
    for i = 1, 9, 1 do
        awful.tag.add(i, {
            icon = beautiful.icons_topbar[i],
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
        widget_template = {
            {
                {
                    {
                        {
                            id     = 'icon_role',
                            widget = wibox.widget.imagebox,
                        },
                        margins = 0,
                        widget  = wibox.container.margin,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 5,
                right = 5,
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
            --Add support for hover colors and an index label-----------
            create_callback = function(self, c3, index, objects) --luacheck: no unused args
                self:get_children_by_id('icon_role')[1].markup = '<b> '..index..' </b>'
                helpers.mouse_hover(self, beautiful.tasklist_hover_color)
            end,
            update_callback = function(self, c3, index, objects) --luacheck: no unused args
                self:get_children_by_id('icon_role')[1].markup = '<b> '..index..' </b>'
            end,
        }
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
        buttons = topbar_buttons.tasklist,
        widget_template = {
            {
                {
                    {
                        {
                            id     = 'clienticon',
                            widget = awful_widget_clienticon,
                        },
                        margins = dpi(4),
                        widget  = wibox.container.margin,
                    },
                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = dpi(2),
                right = dpi(4),
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
            --Add support for hover colors and an index label-----------
            create_callback = function(self, c, index, objects) --luacheck: no unused args
                self:get_children_by_id('clienticon')[1].client = c
                helpers.mouse_hover(self, beautiful.tasklist_hover_color)
            end,
            update_callback = function(self, c)
                self:get_children_by_id('clienticon')[1].client = c
            end,
        }
    }

    --SysTray-------------------------------------------------------------------------
    s.systray_image = wibox.widget.imagebox(beautiful.icons_topbar[false])
    s.systray_button = wibox.widget {
        {
            s.systray_image,
            left  = 5,
            right = 5,
            widget = wibox.container.margin
        },
        bg = beautiful.bg_normal,
        shape = helpers.rounded_rect_shape(3),
        widget = wibox.container.background,
        buttons = topbar_buttons.systray
    }
    s.systray = wibox.widget.systray()
    s.systray.visible = false
    helpers.mouse_hover(s.systray_button, beautiful.hover_color)

	--Binary clock--------------------------------------------------------------------
    s.binclock = wibox.widget{
        binclock_widget{
            height = dpi(24),
            show_seconds = true,
            color_active = beautiful.fg_focus,
            color_inactive = "#555555"
        },
        widget = wibox.container.background,
    }
    helpers.mouse_hover(s.binclock, beautiful.hover_color)

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
    s.volicon1 = wibox.widget {
        image = beautiful.icons_topbar.volmuted,
        widget = wibox.widget.imagebox,
    }
    s.volicon2 = wibox.widget {
        image = beautiful.icons_topbar.volmuted,
        widget = wibox.widget.imagebox,
    }
    s.volicon = wibox.widget {
        {
            {
                s.volicon1,
                s.volicon2,
                layout = wibox.layout.fixed.horizontal,
            },
            left  = dpi(4),
            right = dpi(4),
            widget  = wibox.container.margin,

        },
        shape = helpers.rounded_rect_shape(3),
        widget = wibox.container.background,
    }
    s.volume = volume_widget({
        settings = function()
            local index, perc = "", tonumber(volume_now.level) or 0
            if volume_now.status == "off" then
                s.volicon1.image = beautiful.icons_topbar.volmuted
                s.volicon2.image = beautiful.icons_topbar.volmuted
            else
                s.volicon1.image = beautiful.icons_topbar[math.floor(perc/10)]
                s.volicon2.image = beautiful.icons_topbar[(perc%10)]
            end
    end})
    topbar_buttons.volume_widget(s.volicon, s.volume)
    helpers.mouse_hover(s.volicon, beautiful.hover_color)

    --Create the wibox--------------------------------------------------------------
    s.mywibox = awful.wibar({ position = "top", screen = s, height = "23" })

    --Add widgets to the wibox------------------------------------------------------
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = 5,
            s.mylayoutbox,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = 5,
            s.systray,
            s.systray_button,
            s.volicon,
            s.binclock,
        },
    }
end)