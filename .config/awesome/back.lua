    --volume------------------------------------------------------------------------
    s.volicon1 = wibox.widget.imagebox(beautiful.icons_topbar.volmuted)
    s.volicon2 = wibox.widget.imagebox(beautiful.icons_topbar.volmuted)
    s.volicon = {
        s.volicon1,
        s.volicon2
    }
    s.volicon.layout = wibox.layout.fixed.horizontal
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
    topbar_buttons.volume_widget(s.volicon1, s.volume)
    topbar_buttons.volume_widget(s.volicon2, s.volume)