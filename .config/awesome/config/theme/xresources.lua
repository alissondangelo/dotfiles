---------------------------------------------
-- Awesome theme which follows xrdb config --
--   by Yauhen Kirylau                    --
---------------------------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local gears_color = require("gears.color")
local gears_shape = require("gears.shape")
local wibox = require("wibox")
local awful_widget_clienticon = require("awful.widget.clienticon")

-- inherit default theme
local theme = dofile(themes_path.."default/theme.lua")
-- load vector assets' generators for this theme

local icons = os.getenv("HOME") .. "/.config/awesome/config/theme/icons/layout/"

local font = "Roboto Mono"
local font_size = "12"
theme.font          = font .. " Light " .. font_size
local font_bold     = font .. " Bold " .. font_size

theme.bg_normal     = xrdb.background .. "77"
theme.bg_focus      = xrdb.color12
theme.bg_urgent     = xrdb.color9
theme.bg_minimize   = xrdb.color8 .. "22"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = xrdb.foreground
theme.fg_focus      = xrdb.color7
theme.fg_urgent     = theme.bg_normal
theme.fg_minimize   = theme.bg_normal

theme.bg_systray    = theme.bg_focus

theme.border_normal = xrdb.color0
theme.border_focus  = theme.bg_focus
theme.border_marked = xrdb.color10

theme.useless_gap   = dpi(5)
theme.border_width  = dpi(3)
theme.border_radius = dpi(3)
theme.tooltip_border_width = dpi(3)

theme.tooltip_fg = theme.fg_normal
theme.tooltip_bg = theme.bg_normal
theme.tooltip_border_color = theme.border_focus

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg|shape|shape_border_color|shape_border_width]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg|shape|shape_border_color|shape_border_width]_[focus|urgent|minimized]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]

--helper shape maker-----------------------------------------------------------------
local rounded_rect_shape = function(cr,w,h)
    gears_shape.rounded_rect(
        cr, w, h, theme.border_radius
    )
end

--tag list--------------------------------------------------------------------------
--shape
theme.taglist_shape = rounded_rect_shape
--color
theme.taglist_bg_occupied = theme.border_focus .. "AA"
theme.taglist_bg_empty = "#00000000"
theme.taglist_bg_focus = xrdb.color8
--disable squares
theme.taglist_squares_sel = nil
theme.taglist_squares_unsel = nil

--tasklist--------------------------------------------------------------------------
--normal color
theme.tasklist_fg_normal = theme.bg_focus
theme.tasklist_bg_normal = theme.bg_focus .. "22"
theme.tasklist_shape_border_color = theme.bg_focus .. "33"
--focus color
theme.tasklist_fg_focus = theme.fg_focus
theme.tasklist_bg_focus = theme.border_focus .. "55"
theme.tasklist_shape_border_color_focus = theme.border_focus
theme.tasklist_font_focus = font_bold
--minimized
theme.tasklist_shape_border_color_minimized = xrdb.color8 .. "22"
--shape
theme.tasklist_shape = rounded_rect_shape
theme.tasklist_shape_focus = rounded_rect_shape
theme.tasklist_shape_minimized = rounded_rect_shape
--border width
local border_width = 2
theme.tasklist_shape_border_width = border_width
theme.tasklist_shape_border_width_focus = border_width
theme.tasklist_shape_border_width_minimized = border_width
--spacing
theme.tasklist_spacing = border_width
--widget
theme.tasklist_widget = wibox.widget
--template
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

--menu------------------------------------------------------------------------------
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
-- theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(24)
theme.menu_width  = dpi(150)
theme.menu_border_color = theme.border_focus
theme.menu_fg_focus = theme.fg_focus
theme.menu_fg_normal = theme.bg_focus
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
-- theme.bg_widget = "#cc0000"


-- Recolor Layout icons:
theme = theme_assets.recolor_layout(theme, theme.fg_normal)
theme.layout_centerwork = gears_color.recolor_image(icons .. "centerwork.png" , theme.fg_normal)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Try to determine if we are running light or dark colorscheme:
local bg_numberic_value = 0;
for s in theme.bg_normal:gmatch("[a-fA-F0-9][a-fA-F0-9]") do
    bg_numberic_value = bg_numberic_value + tonumber("0x"..s);
end
local is_dark_bg = (bg_numberic_value < 383)

--theme.layout_centerwork = theme.layout_floating
return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
