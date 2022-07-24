local lain_icons = os.getenv("HOME") .. "/.config/awesome/config/topbar/iconcharacters/binary/"
local gears_color = require("gears.color")
local icons_color = require("beautiful").fg_normal

local icons = {}

--tags
icons.tag = {}
icons.tag[1]  = lain_icons .. "tag_1.png"
icons.tag[2]  = lain_icons .. "tag_2.png"
icons.tag[3]  = lain_icons .. "tag_3.png"
icons.tag[4]  = lain_icons .. "tag_4.png"
icons.tag[5]  = lain_icons .. "tag_5.png"
icons.tag[6]  = lain_icons .. "tag_6.png"
icons.tag[7]  = lain_icons .. "tag_7.png"
icons.tag[8]  = lain_icons .. "tag_8.png"
icons.tag[9]  = lain_icons .. "tag_9.png"

--numbers
icons.number = {}
icons.number[20] = lain_icons .. "1.png"
icons.number[0]  = lain_icons .. "0.png"
icons.number[1]  = lain_icons .. "1.png"
icons.number[2]  = lain_icons .. "2.png"
icons.number[3]  = lain_icons .. "3.png"
icons.number[4]  = lain_icons .. "4.png"
icons.number[5]  = lain_icons .. "5.png"
icons.number[6]  = lain_icons .. "6.png"
icons.number[7]  = lain_icons .. "7.png"
icons.number[8]  = lain_icons .. "8.png"
icons.number[9]  = lain_icons .. "9.png"
icons.number[10] = lain_icons .. "1.png"

icons.misc = {}
--hide systray icons
icons.misc.systrayon  = lain_icons .. "1.png"
icons.misc.systrayoff = lain_icons .. "0.png"

--volume icons
icons.misc.volmuted = lain_icons .. "0.png"

local function change_icons_color(icons)
    for i, icon in pairs(icons) do
        icons[i] = gears_color.recolor_image(icons[i], icons_color)
    end
end
change_icons_color(icons.tag)
change_icons_color(icons.number)
change_icons_color(icons.misc)

--icons.tag[1] = gears_color.recolor_image(icons.tag[1], "#FF0000")
return icons