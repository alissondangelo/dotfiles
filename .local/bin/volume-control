#!/bin/bash
# Control volume

if [[ "$1" = "up" ]]; then
    amixer set Master 1%+
    notify-send "$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')%" -r 1 --urgency low
elif [[ "$1" = "down" ]]; then
    amixer set Master 1%-
    notify-send "$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')%" -r 1 --urgency low
elif [[ "$1" = "toggle" ]]; then
    amixer set Master toggle
    notify-send "$(amixer get Master | tail -1 | grep -c '\[on\]')" -r 1 --urgency low
elif [[ "$1" = "mic_toggle" ]]; then
    amixer set Capture toggle
    notify-send $(amixer get Capture | tail -1 | grep -c '\[on\]') -r 1 --urgency low
else
    echo "No argument."
fi