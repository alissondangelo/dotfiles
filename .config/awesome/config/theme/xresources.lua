local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local gears_color = require("gears.color")
local wibox = require("wibox")
local helpers = require("config.helpers")

-- inherit default theme
local theme = dofile(themes_path.."default/theme.lua")
-- load vector assets' generators for this theme

local icons_layout = os.getenv("HOME") .. "/.config/awesome/config/theme/icons/layout/"
local icons_topbar = require("config.theme.icons.topbar.icons")

--font------------------------------------------------------------------------------
local font = "Roboto Mono"
local font_size = "12"
theme.font          = font .. " Medium " .. font_size
local font_bold     = font .. " Bold " .. font_size

--bg_colors-------------------------------------------------------------------------
theme.bg_normal     = xrdb.background .. "99"
theme.bg_focus      = xrdb.color4
theme.bg_urgent     = "#AA0000"
theme.bg_minimize   = xrdb.color1 .. "44"
theme.bg_systray    = theme.bg_focus
--fg_colors-------------------------------------------------------------------------
theme.fg_normal     = xrdb.color7
theme.fg_focus      = xrdb.color15
theme.fg_urgent     = xrdb.background
theme.fg_minimize   = xrdb.background
--border_colors---------------------------------------------------------------------
theme.border_normal = xrdb.color0
theme.border_focus  = xrdb.color6
theme.border_marked = xrdb.color10
--hover_color-----------------------------------------------------------------------
theme.hover_color   = xrdb.color2 .. "CC"

--gaps and border width-------------------------------------------------------------
theme.useless_gap   = dpi(5)
theme.border_width  = dpi(2)
theme.border_radius = dpi(3)
theme.tooltip_border_width = dpi(2)
local tasklist_border_width = dpi(1)

--tooltip colors--------------------------------------------------------------------
theme.tooltip_fg = theme.fg_normal
theme.tooltip_bg = theme.bg_normal
theme.tooltip_border_color = theme.border_focus

--tag list--------------------------------------------------------------------------
--shape
theme.taglist_shape = helpers.rounded_rect_shape(3)
--color
theme.taglist_bg_occupied = xrdb.color3 .. "66"
theme.taglist_bg_empty = "#00000000"
theme.taglist_bg_focus = theme.border_focus .. "AA"
theme.taglist_hover_color = theme.hover_color
--disable squares
theme.taglist_squares_sel = nil
theme.taglist_squares_unsel = nil
--template
theme.backup = ""

--tasklist--------------------------------------------------------------------------
--normal color
theme.tasklist_fg_normal = theme.bg_focus
theme.tasklist_bg_normal = theme.bg_focus .. "22"
theme.tasklist_shape_border_color = theme.tasklist_bg_normal --theme.bg_focus .. "44"
--focus color
theme.tasklist_fg_focus = theme.fg_focus
theme.tasklist_bg_focus = theme.border_focus .. "44"
theme.tasklist_shape_border_color_focus = theme.border_focus .."AA"
theme.tasklist_font_focus = font_bold
theme.tasklist_hover_color = theme.hover_color
--minimized
theme.tasklist_shape_border_color_minimized = theme.background_minimized --xrdb.color1 .. "66"
--shape
theme.tasklist_shape = helpers.rounded_rect_shape(3)
theme.tasklist_shape_focus = helpers.rounded_rect_shape(3)
theme.tasklist_shape_minimized = helpers.rounded_rect_shape(3)
--border width
theme.tasklist_shape_border_width = tasklist_border_width
theme.tasklist_shape_border_width_focus = tasklist_border_width
theme.tasklist_shape_border_width_minimized = tasklist_border_width
--spacing
theme.tasklist_spacing = tasklist_border_width
--widget
theme.tasklist_widget = wibox.widget

--menu------------------------------------------------------------------------------
theme.menu_height = dpi(25)
theme.menu_width  = dpi(130)
theme.menu_border_color = theme.border_focus
theme.menu_fg_focus = theme.fg_focus
theme.menu_fg_normal = theme.bg_focus

--icons-----------------------------------------------------------------------------
-- Recolor Layout icons and set them------------------------------------------------
theme = theme_assets.recolor_layout(theme, theme.fg_normal)
theme.layout_centerwork = gears_color.recolor_image(icons_layout .. "centerwork.png" , theme.fg_normal)
--topbar_icons----------------------------------------------------------------------
--change icons color--
for i, icon in pairs(icons_topbar) do
    icons_topbar[i] = gears_color.recolor_image(icons_topbar[i], theme.fg_normal)
end
theme.icons_topbar = icons_topbar
-- Define the icon theme for application icons. If not set then the icons-----------
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
