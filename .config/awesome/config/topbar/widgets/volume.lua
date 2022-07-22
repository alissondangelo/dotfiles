--[[

     Licensed under GNU General Public License v2
      * (c) 2013, Luca CPZ
      * (c) 2010, Adrian C. <anrxc@sysphere.org>

--]]

local shell   = require("awful.util").shell
local wibox   = require("wibox")
local string  = string
local awful   = require("awful")

-- ALSA volume
-- lain.widget.alsa

local function factory(args)
    args           = args or {}
    local alsa     = { widget = args.widget or wibox.widget.textbox() }
    local timeout  = args.timeout or 5
    local settings = args.settings or function() end

    alsa.cmd           = args.cmd or "amixer"
    alsa.channel       = args.channel or "Master"
    alsa.togglechannel = args.togglechannel

    local format_cmd = string.format("%s get %s", alsa.cmd, alsa.channel)

    if alsa.togglechannel then
        format_cmd = { shell, "-c", string.format("%s get %s; %s get %s",
        alsa.cmd, alsa.channel, alsa.cmd, alsa.togglechannel) }
    end

    alsa.last = {}


    local function async(cmd, callback)
        return awful.spawn.easy_async(cmd,
            function (stdout, _, _, exit_code)
                callback(stdout, exit_code)
            end)
    end

    local function newtimer(name, timeout, fun, nostart, stoppable)
        local timer_table = {}
        if not name or #name == 0 then return end
        name = (stoppable and name) or timeout
        if not timer_table[name] then
            timer_table[name] = timer({ timeout = timeout })
            timer_table[name]:start()
        end
        timer_table[name]:connect_signal("timeout", fun)
        if not nostart then
            timer_table[name]:emit_signal("timeout")
        end
        return stoppable and timer_table[name]
    end


    function alsa.update()
        async(format_cmd, function(mixer)
            local l,s = string.match(mixer, "([%d]+)%%.*%[([%l]*)")
            l = tonumber(l)
            if alsa.last.level ~= l or alsa.last.status ~= s then
                volume_now = { level = l, status = s }
                widget = alsa.widget
                settings()
                alsa.last = volume_now
            end
        end)
    end

    newtimer(string.format("alsa-%s-%s", alsa.cmd, alsa.channel), timeout, alsa.update)

    return alsa
end

return factory
