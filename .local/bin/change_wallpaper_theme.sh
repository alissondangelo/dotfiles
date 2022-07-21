#!/bin/sh

WALLPAPERDIR=$HOME/Pictures/Wallpapers

cd $WALLPAPERDIR &&
FILENAME=$(yad --title="Select Wallpaper" --file --add-preview --large-preview) &&
alacritty -e chameleon.py -i $FILENAME
#$HOME/.local/bin/starttree.py
echo "awesome.restart()" | awesome-client
