#!/bin/bash

xset r rate 250 60

xmodmap ~/.Xmodmap

setxkbmap -option grp:alt_shift_toggle us,gr

# these two commands remap the lock key to escape (pressed) or ctrl (hold)
setxkbmap -option 'caps:ctrl_modifier'
xcape -e 'Caps_Lock=Escape'
