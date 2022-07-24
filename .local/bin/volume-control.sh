#!/bin/bash
# Control volume
# Requires pulseaudio
# AwesomeWM: Only sends a notification if the sidebar is not visible
# --------------------------

# Steps for raising/lowering volume
STEP=1
BIG_STEP=25

if [[ "$1" = "up" ]]; then
    pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ +$STEP%
elif [[ "$1" = "UP" ]]; then
    pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ +$BIG_STEP%
elif [[ "$1" = "down" ]]; then
    pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ -$STEP%
elif [[ "$1" = "DOWN" ]]; then
    pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ -$BIG_STEP%
elif [[ "$1" = "toggle" ]]; then
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    notify-send 'Volume toggle.' --urgency low
elif [[ "$1" = "reset" ]]; then
    pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ 50%
else
    echo "No argument."
fi

