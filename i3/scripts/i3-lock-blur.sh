#!/bin/bash

# This is a script from petvas at github. It uses i3lock to lock the screen,
# while showing a blured version of the current screen.

TMPBG=/tmp/screen.png
LOCK=$HOME/dotfiles/i3/scripts/.arch.png
RES=$(xrandr | grep 'current' | sed -E 's/.*current\s([0-9]+)\sx\s([0-9]+).*/\1x\2/')
 
ffmpeg -f x11grab -video_size $RES -y -i $DISPLAY -i $LOCK -filter_complex "boxblur=5:1,overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -vframes 1 $TMPBG -loglevel quiet
i3lock -i $TMPBG
rm $TMPBG
