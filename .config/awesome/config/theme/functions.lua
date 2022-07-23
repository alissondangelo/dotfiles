-- Helper functions for modifying hex colors:
--
local functions = {}

local hex_color_match = "[a-fA-F0-9][a-fA-F0-9]"
--function to mix 2 colors-------------------------------------
function functions.mix(color1, color2, ratio)
    ratio = ratio or 0.5
    local result = "#"
    local channels1 = color1:gmatch(hex_color_match)
    local channels2 = color2:gmatch(hex_color_match)
    for _ = 1,3 do
        local bg_numeric_value = math.ceil(
          tonumber("0x"..channels1())*ratio +
          tonumber("0x"..channels2())*(1-ratio)
        )
        if bg_numeric_value < 0 then bg_numeric_value = 0 end
        if bg_numeric_value > 255 then bg_numeric_value = 255 end
        result = result .. string.format("%02x", bg_numeric_value)
    end
    return result
end

--function to change hex color alpha (tranparency)--------------
function functions.change_color_alpha(color, alpha)
    local new_color = ""
    for i = 1, #color do
        if i <= 7 then 
        new_color = new_color .. color:sub(i,i)
        end
    end
    return new_color .. alpha
end

return functions