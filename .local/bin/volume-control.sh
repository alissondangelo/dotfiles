#!/bin/bash
# Control volume

if [[ "$1" = "up" ]]; then
    amixer set Master 1%+
    VOL="$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')"
    notify-send "${VOL}%" -r 1 --urgency low
elif [[ "$1" = "down" ]]; then
    amixer set Master 1%-
    VOL="$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')"
    notify-send "${VOL}%" -r 1 --urgency low
elif [[ "$1" = "toggle" ]]; then
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    notify-send 'Volume toggle.' -r 1 --urgency low
elif [[ "$1" = "mic_toggle" ]]; then
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
    notify-send $(pactl get-source-mute @DEFAULT_SOURCE@) -r 1 --urgency low
else
    echo "No argument."
fi