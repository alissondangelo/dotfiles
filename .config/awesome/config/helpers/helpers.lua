local gears_shape = require("gears.shape")

local helpers = {}

--change color and cursor on mouse hover--------------------------------------------
helpers.mouse_hover = function(wid, color)
    wid:connect_signal('mouse::enter', function()
        local w = _G.mouse.current_wibox
        if w then
            w.cursor = "hand2"
        end
        if wid.bg ~= color then
            wid.backup     = wid.bg
            wid.has_backup = true
        end
            wid.bg = color
        end)
    wid:connect_signal('mouse::leave', function()
        local w = _G.mouse.current_wibox
        if w then
            w.cursor = "left_ptr"
        end
        if wid.has_backup then wid.bg = wid.backup end
    end)
end

--shape maker-----------------------------------------------------------------------
helpers.rounded_rect_shape = function(r)
    return function(cr, w, h)
        gears_shape.rounded_rect(cr, w, h, r or 3)
    end
end

return helpers