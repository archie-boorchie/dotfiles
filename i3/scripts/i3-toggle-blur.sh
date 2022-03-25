#!/bin/bash

CLASSNAME=$(xdotool getactivewindow getwindowclassname)

if [[ "$CLASSNAME" = "Alacritty" ]]; then
    xdotool getactivewindow set_window --class AlacrittyNoBlur
elif [[ "$CLASSNAME" = "AlacrittyNoBlur" ]]; then
    xdotool getactivewindow set_window --class Alacritty
fi
