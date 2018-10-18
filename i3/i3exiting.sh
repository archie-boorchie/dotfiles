#!/bin/bash

res=$(rofi -dmenu -p "" -lines 4 < ~/dotfiles/i3/.dmenu-i3exit)

if [ $res = "lock" ]; then
    # i3lock exit # traditional i3lock
    sh ~/dotfiles/i3/i3lock-blur.sh exit # blured screenshot i3lock
fi

if [ $res = "logout" ]; then
    i3-msg exit
fi

if [ $res = "restart" ]; then
    reboot
fi

if [ $res = "shutdown" ]; then
    poweroff
fi

exit 0
