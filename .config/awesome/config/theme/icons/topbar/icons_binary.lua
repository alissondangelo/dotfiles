local my_icons = os.getenv("HOME") .. "/.config/awesome/config/theme/icons/topbar/binary/"

local icons = {}

--numbers------------------------------------------------------
icons[20] = my_icons .. "1.png"
icons[0]  = my_icons .. "0.png"
icons[1]  = my_icons .. "1.png"
icons[2]  = my_icons .. "2.png"
icons[3]  = my_icons .. "3.png"
icons[4]  = my_icons .. "4.png"
icons[5]  = my_icons .. "5.png"
icons[6]  = my_icons .. "6.png"
icons[7]  = my_icons .. "7.png"
icons[8]  = my_icons .. "8.png"
icons[9]  = my_icons .. "9.png"
icons[10] = my_icons .. "1.png"

--hide systray icons-------------------------------------------
icons.systrayon  = my_icons .. "1.png"
icons.systrayoff = my_icons .. "0.png"

--volume icons-------------------------------------------------
icons.volmuted = my_icons .. "0.png"

return icons