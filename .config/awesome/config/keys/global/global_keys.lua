local awful = require("awful")
local mytable = require("gears.table")
local hotkeys_popup = require("awful.hotkeys_popup")
local naughty = require("naughty")
local beautiful = require("beautiful")

require("awful.hotkeys_popup.keys")

local modkey = require("config.keys.mod_keys").modKey
local altkey = require("config.keys.mod_keys").altKey

local s = awful.screen.focused()
local calendar_aux = nil

local globalkeys = mytable.join(

    -- Lock,Sleep,Restart,Shutdown -------------------------------------------------
    awful.key({ modkey,           }, "F8", function () awful.spawn(awesome.quit()) end,
        {description = "Logout", group = "system"}),
    awful.key({ modkey,           }, "F9", function () awful.spawn("slock") end,
        {description = "Lock the screen", group = "system"}),
    awful.key({ modkey,           }, "F10", function () awful.spawn("systemctl suspend") end,
        {description = "System Sleep", group = "system"}),
    awful.key({ modkey,           }, "F11", function () awful.spawn("reboot") end,
        {description = "System Restart", group = "system"}),
    awful.key({ modkey,           }, "F12", function () awful.spawn("shutdown now") end,
        {description = "System Shutdown", group = "system"}),

    -- screenshots -----------------------------------------------------------------
    awful.key({                   }, "Print", function() awful.spawn("screenshot") end,
        {description = "take full screenshot", group = "screenshots"}),
    awful.key({ modkey,           }, "Print", function() awful.spawn("screenshot -s") end,
        {description = "select area to capture", group = "screenshots"}),
    awful.key({ modkey, "Shift"   }, "Print", function() awful.spawn("screenshot -c") end,
        {description = "select area to copy to clipboard", group = "screenshots"}),
    awful.key({ modkey, "Control" }, "Print", function() awful.spawn("screenshot -b") end,
        {description = "browse screenshots", group = "screenshots"}),
    awful.key({ modkey, altkey    }, "Print", function() awful.spawn("screenshot -e") end,
        {description = "edit most recent screenshot with gimp", group = "screenshots"}),

    -- internet --------------------------------------------------------------------
    awful.key({ modkey,           }, "b", function () awful.spawn(browser1) end,
        {description = "Browser 1 (Main)", group = "internet"}),
    awful.key({ modkey,           }, "v", function () awful.spawn(browser2) end,
        {description = "Browser 2", group = "internet"}),
    awful.key({ modkey,           }, "c", function () awful.spawn(browser3) end,
        {description = "Browser 3", group = "internet"}),
    awful.key({ modkey,           }, "y", function () awful.spawn("freetube") end,
        {description = "Free Tube", group = "internet"}),

    -- games -----------------------------------------------------------------------
    awful.key({ modkey,           }, "g", function () awful.spawn("lutris") end,
        {description = "Lutris", group = "Games"}),
    awful.key({ modkey,           }, "s", function () awful.spawn("steam") end,
        {description = "Steam", group = "Games"}),
    awful.key({ modkey,           }, "d", function () awful.spawn("discord") end,
        {description = "Discord", group = "Games"}),
    awful.key({ modkey,           }, "t", function () awful.spawn("/usr/bin/java -jar /opt/tlauncher/tlauncher.jar") end,
        {description = "Minecraft (Tlauncher)", group = "games"}),

    -- awesome ---------------------------------------------------------------------
    awful.key({ modkey,           }, "w", function () awful.util.mymainmenu:show() end,
        {description = "show system menu", group = "awesome"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
        {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, altkey    }, "q", awesome.quit,
        {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey,           }, "F1",      hotkeys_popup.show_help,
        {description="show help", group="awesome"}),

    -- layout keys -----------------------------------------------------------------
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1) end,
        {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1) end,
        {description = "select previous", group = "layout"}),
    awful.key({ modkey, altkey    }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
        {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, altkey    }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
        {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, altkey    }, "j",     function () awful.tag.incncol( 1, nil, true)    end,
        {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, altkey    }, "k",     function () awful.tag.incncol(-1, nil, true)    end,
        {description = "decrease the number of columns", group = "layout"}),

    -- tag keys ---------------------------------------------------------------------
    awful.key({ modkey, altkey    }, "Left",   awful.tag.viewprev,
        {description = "view previous", group = "tag"}),
    awful.key({ modkey, altkey    }, "Right",  awful.tag.viewnext,
        {description = "view next", group = "tag"}),
    awful.key({ modkey, altkey    }, "Escape", awful.tag.history.restore,
        {description = "go back", group = "tag"}),

    -- launchers -------------------------------------------------------------------
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
        {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Shift"   }, "Return", function () awful.spawn(terminal .. " --class floating") end,
        {description = "open a floating terminal", group = "launcher"}),
    awful.key({ modkey, "Shift"   }, "r", function () awful.screen.focused().mypromptbox:run() end,
        {description = "run prompt", group = "launcher"}),
    awful.key({ modkey,           }, "#94",
        function ()
            awful.spawn.with_shell("rofi -show drun")
        end,
        {description = "open rofi menu", group = "client"}),
    awful.key({ modkey,           }, "r",
    	function ()
	        awful.spawn.with_shell("rofi -show drun")
        end,
        {description = "pen rofi menu", group = "client"}),
    awful.key({ modkey,           }, "e", function () awful.spawn(fileManager) end,
        {description = "File Manager", group = "utilities"}),

    -- topbar -----------------------------------------------------------------------
    awful.key({ modkey,           }, "-",
        function ()
            naughty.destroy(calendar_aux)
            s.cw.show()
            calendar_aux = s.cw.notification
            s.cw.notification = nil
        end,
        {description = "toggle calendar", group = "awesome"}),
    awful.key({ modkey,           }, "=",
        function ()
            s.systray.visible = not s.systray.visible
            s.systray_image.image = beautiful.icons_topbar[s.systray.visible]
        end,
        {description = "toggle tray", group = "awesome"}),
    awful.key({ modkey,           }, "BackSpace",
        function ()
            s.mywibox.visible = not s.mywibox.visible
        end,
        {description = "toggle topbar", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "BackSpace",
        function ()
            s.mylayoutbox.visible = not s.mylayoutbox.visible
            s.mytasklist.visible = not s.mytasklist.visible
            s.systrayicon.visible = not s.systrayicon.visible
            s.volicon1.visible = not s.volicon1.visible
            s.volicon2.visible = not s.volicon2.visible
        end,
        {description = "toggle topbar cleaner mode", group = "awesome"}),

    -- media -------------------------------------------------------------------------
    awful.key({ modkey,           }, "KP_Add",
        function ()
            awful.spawn.with_shell("volume-control up")
            s.volume.update()
        end,
        {description = "Volume +", group = "media"}
    ),
    awful.key({ modkey,           }, "KP_Subtract",
        function ()
            awful.spawn.with_shell("volume-control down")
            s.volume.update()
        end,
        {description = "Volume -", group = "media"}
    ),
    awful.key({ modkey,           }, "KP_Multiply",
        function ()
            awful.spawn.with_shell("volume-control toggle")
            s.volume.update()
        end,
        {description = "Volume toggle", group = "media"}
    ),
    awful.key({ modkey,           }, "KP_Divide",
        function()
            awful.spawn.with_shell("volume-control mic_toggle")
        end,
        {description = "(un)mute microphone", group = "volume"}),
    awful.key({ modkey,           }, "KP_Decimal",
        function ()
            awful.spawn.with_shell("pavucontrol")
        end,
        {description = "pavucontrol", group = "media"}
    ),



    -- customization ------------------------------------------------------------------
    awful.key({ modkey, "Shift"   }, "w",
        function ()
            awful.spawn.with_shell("change_wallpaper_theme")
        end,
        {description = "Change wallpaper and color scheme", group = "customization"}
    ),

    --client -----------------------------------------------------------------------
    -- Focus client by direction
    awful.key({ modkey,            }, "j", function() awful.client.focus.bydirection("down") end,
        {description = "focus down", group = "client"}),
    awful.key({ modkey,            }, "k", function() awful.client.focus.bydirection("up") end,
        {description = "focus up", group = "client"}),
    awful.key({ modkey,            }, "h", function() awful.client.focus.bydirection("left") end,
        {description = "focus left", group = "client"}),
    awful.key({ modkey,            }, "l", function() awful.client.focus.bydirection("right") end,
        {description = "focus right", group = "client"}),
    awful.key({ modkey,            }, "Down", function() awful.client.focus.bydirection("down") end,
        {description = "focus down", group = "client"}),
    awful.key({ modkey,            }, "Up", function() awful.client.focus.bydirection("up") end,
        {description = "focus up", group = "client"}),
    awful.key({ modkey,            }, "Left", function() awful.client.focus.bydirection("left") end,
        {description = "focus left", group = "client"}),
    awful.key({ modkey,            }, "Right", function() awful.client.focus.bydirection("right") end,
        {description = "focus right", group = "client"}),
    -- client focus change by idx --------------------------------------------------
    awful.key({ modkey,            }, "Tab", function () awful.client.focus.byidx( 1)  end,
        {description = "focus next by index", group = "client"}),
    awful.key({ modkey, "Shift"    }, "Tab", function () awful.client.focus.byidx(-1)  end,
        {description = "focus previous by index", group = "client"}),
    -- kill all clients in current tab ---------------------------------------------
    awful.key({ modkey, "Shift"    }, "q",
        function ()
            local clients = awful.screen.focused().clients
            for _, c in pairs(clients) do
                c:kill()
            end
        end,
        {description = "kill all visible clients for the current tag", group = "client"}),
    -- restore minimized -----------------------------------------------------------
    awful.key({ modkey, "Shift"    }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal("request::activate", "key.unminimize", {raise = true})
                  end
              end,
        {description = "restore minimized", group = "client"}),
    -- jump to urgent client -------------------------------------------------------
    awful.key({ modkey,           }, "'",
        function ()
            uc = awful.client.urgent.get()
            -- If there is no urgent client, go back to last tag
            if uc == nil then
                awful.tag.history.restore()
            else
                awful.client.urgent.jumpto()
            end
        end,
        {description = "jump to urgent client", group = "client"}),
    --client------------------------------------------------------------------------

    --gaps--------------------------------------------------------------------------
    awful.key({ modkey,           }, "]", function () awful.tag.incgap(1, nil) end,
              {description = "increment gaps size for the current tag", group = "gaps"}),
    awful.key({ modkey,           }, "[", function () awful.tag.incgap(-1, nil) end,
              {description = "decrement gap size for the current tag", group = "gaps"}),

    -- lua execute prompt ----------------------------------------------------------
    awful.key({ modkey,           }, "x", function ()
            awful.prompt.run {
                prompt       = "Run Lua code: ",
                textbox      = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        {description = "lua execute prompt", group = "awesome"})

)

-- Bind all key numbers to tags. ---------------------------------------------------
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = mytable.join(globalkeys,
        -- View tag only. ----------------------------------------------------------
        awful.key({ modkey,           }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display. -----------------------------------------------------
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag. -----------------------------------------------------
        awful.key({ modkey, "Shift"   }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client. -------------------------------------------
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

return globalkeys