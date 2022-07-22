-- MODULE AUTO-START
-- Run all the apps listed below as run_on_start_up only once when awesome start
local awful = require('awful')

local apps = {
    "gwe", --"gwe --hide-window",
    --"flatpak run com.leinardi.gwe",
    "feh --bg-scale $(< ${HOME}/.cache/wal/wal)",
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
    "picom -b --experimental-backends --backend glx --config  $HOME/.config/picom/picom.conf",
    "numlockx on"
    --"$HOME/.config/awesome/scripts/nvidia_clock.sh",
    --"fan-control pcurve"
}


local function run_once(cmd)
  local findme = cmd
  local firstspace = cmd:find(' ')
  if firstspace then
    findme = cmd:sub(0, firstspace - 1)
  end
  awful.spawn.with_shell(string.format('pgrep -u $USER -x %s > /dev/null || (%s)', findme, cmd))
end

for _, app in ipairs(apps) do
  run_once(app)
end
