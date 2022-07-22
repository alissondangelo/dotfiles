-- Helper functions for modifying hex colors:
--
local functions = {}

local hex_color_match = "[a-fA-F0-9][a-fA-F0-9]"
local function darker(color_value, darker_n)
    local result = "#"
    local channel_counter = 1
    for s in color_value:gmatch(hex_color_match) do
        local bg_numeric_value = tonumber("0x"..s)
        if channel_counter <= 3 then
            bg_numeric_value = bg_numeric_value - darker_n
        end
        if bg_numeric_value < 0 then bg_numeric_value = 0 end
        if bg_numeric_value > 255 then bg_numeric_value = 255 end
        result = result .. string.format("%02x", bg_numeric_value)
        channel_counter = channel_counter + 1
    end
    return result
end
local function is_dark(color_value)
    local bg_numeric_value = 0;
    local channel_counter = 1
    for s in color_value:gmatch(hex_color_match) do
        bg_numeric_value = bg_numeric_value + tonumber("0x"..s);
        if channel_counter == 3 then
            break
        end
        channel_counter = channel_counter + 1
    end
    local is_dark_bg = (bg_numeric_value < 383)
    return is_dark_bg
end


function functions.choose_contrast_color(reference, candidate1, candidate2)  -- luacheck: no unused
    if is_dark(reference) then
        if not is_dark(candidate1) then
            return candidate1
        else
            return candidate2
        end
    else
        if is_dark(candidate1) then
            return candidate1
        else
            return candidate2
        end
    end
end


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

function functions.reduce_contrast(color, ratio)
    ratio = ratio or 50
    return darker(color, is_dark(color) and -ratio or ratio)
end


--function to change hex color alpha (tranparency)
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