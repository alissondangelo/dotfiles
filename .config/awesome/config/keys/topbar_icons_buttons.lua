local awful = require("awful")
local gears = require("gears")
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local icons = {}
function icons.set_volicon_buttons (volicon, volwidget)
    volicon:buttons(my_table.join (
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
end

return icons