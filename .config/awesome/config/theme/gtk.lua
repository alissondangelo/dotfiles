----------------------------------------------
-- Awesome theme which follows GTK+ 3 theme --
--   by Yauhen Kirylau                      --
----------------------------------------------

local theme_assets = require("beautiful.theme_assets")
local dpi = require("beautiful.xresources").apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local gears_shape = require("gears.shape")
local wibox = require("wibox")
local awful_widget_clienticon = require("awful.widget.clienticon")
local gtk = require("beautiful.gtk")

local functions = require("config.theme.functions")

-- inherit xresources theme:
local theme = dofile(themes_path.."xresources/theme.lua")
-- load and prepare for use gtk theme:
theme.gtk = gtk.get_theme_variables()
if not theme.gtk then
    local gears_debug = require("gears.debug")
    gears_debug.print_warning("Can't load GTK+3 theme. Using 'xresources' theme as a fallback.")
    return theme
end
theme.gtk.button_border_radius = dpi(theme.gtk.button_border_radius or 0)
theme.gtk.button_border_width = dpi(3)
theme.gtk.bold_font = theme.gtk.font_family .. ' Bold ' .. theme.gtk.font_size
theme.gtk.menubar_border_color = functions.mix(
    theme.gtk.menubar_bg_color,
    theme.gtk.menubar_fg_color,
    0.7
)


theme.font          = theme.gtk.font_family .. ' ' .. theme.gtk.font_size

theme.bg_normal     = theme.gtk.bg_color
theme.fg_normal     = theme.gtk.fg_color

theme.wibar_bg      = functions.change_color_alpha(theme.gtk.menubar_bg_color, "99")
theme.wibar_fg      = functions.mix(theme.gtk.menubar_fg_color, "#FFFFFFFF", 0.2)

theme.bg_focus      = functions.change_color_alpha(theme.gtk.selected_bg_color, "CC")
theme.fg_focus      = theme.gtk.fg_focus

theme.bg_urgent     = theme.gtk.error_bg_color
theme.fg_urgent     = theme.gtk.error_fg_color

theme.bg_minimize   = functions.change_color_alpha(functions.mix(theme.wibar_fg, theme.wibar_bg, 0.3), "55")
theme.fg_minimize   = functions.mix(theme.wibar_fg, theme.wibar_bg, 0.5)

theme.bg_systray    = theme.bg_focus

theme.border_normal = theme.gtk.wm_border_unfocused_color
theme.border_focus  = functions.change_color_alpha(theme.gtk.wm_border_focused_color, "FF")
theme.border_marked = theme.gtk.success_color


theme.border_width  = dpi(3)
theme.border_radius = theme.gtk.button_border_radius

theme.useless_gap   = dpi(5)

local rounded_rect_shape = function(cr,w,h)
    gears_shape.rounded_rect(
        cr, w, h, theme.border_radius
    )
end

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg|shape|shape_border_color|shape_border_width]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg|shape|shape_border_color|shape_border_width]_[focus|urgent|minimized]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]

-- tasklist

--normal color
theme.tasklist_fg_normal = theme.bg_focus
theme.tasklist_bg_normal = functions.change_color_alpha(theme.bg_focus, "22")
theme.tasklist_shape_border_color = functions.change_color_alpha(theme.bg_focus, "33")

--focus color
theme.tasklist_fg_focus = functions.mix(theme.fg_normal, "#FFFFFF", 0.8)
theme.tasklist_bg_focus = functions.change_color_alpha(theme.border_focus, "55")
theme.tasklist_shape_border_color_focus = theme.border_focus
theme.tasklist_font_focus = theme.gtk.bold_font

-- minimized color
theme.tasklist_shape_border_color_minimized = functions.change_color_alpha(functions.mix(
    theme.bg_minimize,
    theme.fg_minimize,
    0.85
), "88")

-- shape
theme.tasklist_shape = rounded_rect_shape
theme.tasklist_shape_focus = rounded_rect_shape
theme.tasklist_shape_minimized = rounded_rect_shape

-- border width
theme.tasklist_shape_border_width = theme.gtk.button_border_width
theme.tasklist_shape_border_width_focus = theme.gtk.button_border_width
theme.tasklist_shape_border_width_minimized = theme.gtk.button_border_width

theme.tasklist_widget = wibox.widget
theme.tasklist_spacing = theme.gtk.button_border_width

theme.tasklist_widget_template = {
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
    create_callback = function(self, c)
        self:get_children_by_id('clienticon')[1].client = c
    end,
}

--{{{tag list
theme.taglist_shape_container = rounded_rect_shape
theme.taglist_shape = rounded_rect_shape
theme.taglist_shape_clip_container = true
theme.taglist_shape_border_width_container = theme.gtk.button_border_width * 1.0
theme.taglist_shape_border_color_container = functions.change_color_alpha(theme.gtk.header_button_bg_color, "88")

theme.taglist_bg_occupied = functions.change_color_alpha(theme.gtk.header_button_bg_color, "44")
theme.taglist_fg_occupied = functions.mix(theme.gtk.header_button_fg_color, theme.gtk.header_button_bg_color, 0.7)
theme.taglist_bg_empty = "#00000000"--functions.mix( theme.gtk.menubar_bg_color, theme.gtk.header_button_bg_color, 0.3)
theme.taglist_fg_empty = functions.change_color_alpha(theme.gtk.menubar_fg_color, "55")

theme.taglist_bg_focus = theme.gtk.selected_bg_color
theme.taglist_fg_focus = theme.fg_focus
--}}}

--[[ Advanced taglist and tasklist styling: {{{

    --- In order to get taglist and tasklist to follow GTK theme you need to
    -- modify your rc.lua in the following way:

    diff --git a/rc.lua b/rc.lua
    index 231a2f68c..533a859d2 100644
    --- a/rc.lua
    +++ b/rc.lua
    @@ -217,24 +217,12 @@ awful.screen.connect_for_each_screen(function(s)
            filter  = awful.widget.taglist.filter.all,
            buttons = taglist_buttons
        }
    +    -- and apply shape to it
    +    if beautiful.taglist_shape_container then
    +        local background_shape_wrapper = wibox.container.background(s.mytaglist)
    +        background_shape_wrapper._do_taglist_update_now = s.mytaglist._do_taglist_update_now
    +        background_shape_wrapper._do_taglist_update = s.mytaglist._do_taglist_update
    +        background_shape_wrapper.shape = beautiful.taglist_shape_container
    +        background_shape_wrapper.shape_clip = beautiful.taglist_shape_clip_container
    +        background_shape_wrapper.shape_border_width = beautiful.taglist_shape_border_width_container
    +        background_shape_wrapper.shape_border_color = beautiful.taglist_shape_border_color_container
    +        s.mytaglist = background_shape_wrapper
    +    end

        -- Create a tasklist widget
        s.mytasklist = awful.widget.tasklist {
            screen  = s,
            filter  = awful.widget.tasklist.filter.currenttags,
    +        buttons = tasklist_buttons,
    +        widget_template = beautiful.tasklist_widget_template
    -        buttons = tasklist_buttons
        }

--]]

theme.titlebar_font_normal = theme.gtk.bold_font
theme.titlebar_bg_normal = theme.gtk.wm_border_unfocused_color
theme.titlebar_fg_normal = theme.gtk.wm_title_unfocused_color
--theme.titlebar_fg_normal = choose_contrast_color(
    --theme.titlebar_bg_normal,
    --theme.gtk.menubar_fg_color,
    --theme.gtk.menubar_bg_color
--)

theme.titlebar_font_focus = theme.gtk.bold_font
theme.titlebar_bg_focus = theme.gtk.wm_border_focused_color
theme.titlebar_fg_focus = theme.gtk.wm_title_focused_color
--theme.titlebar_fg_focus = choose_contrast_color(
    --theme.titlebar_bg_focus,
    --theme.gtk.menubar_fg_color,
    --theme.gtk.menubar_bg_color
--)

theme.tooltip_fg = theme.gtk.tooltip_fg_color
theme.tooltip_bg = theme.gtk.tooltip_bg_color
theme.tooltip_border_color = functions.change_color_alpha(theme.gtk.header_button_bg_color, "88")
theme.tooltip_border_width = theme.gtk.button_border_width

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]

theme.menu_border_width = theme.gtk.button_border_width
theme.menu_border_color = theme.gtk.menubar_border_color
theme.menu_bg_normal = theme.gtk.menubar_bg_color
theme.menu_fg_normal = theme.gtk.menubar_fg_color

-- @TODO: get from gtk menu height
theme.menu_height = dpi(24)
theme.menu_width  = dpi(150)
theme.menu_submenu_icon = nil
theme.menu_submenu = "▸ "
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
-- theme.bg_widget = "#cc0000"

-- Recolor Layout icons:
theme = theme_assets.recolor_layout(theme, theme.wibar_fg)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Or disable them:
theme.taglist_squares_sel = nil
theme.taglist_squares_unsel = nil

--set centerwork layout icon
local lain_icons         = os.getenv("HOME") ..
                           "/.config/awesome/config/theme/icons/layout/"
theme.layout_centerwork  = lain_icons .. "centerwork.png"

return theme