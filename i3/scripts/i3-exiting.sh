#!/bin/bash

res=$(rofi -dmenu -p "   :" -lines 5 < ~/dotfiles/i3/scripts/.i3-exiting-dmenu)

if [ $res = "lock" ]; then
    # i3lock exit # traditional i3lock
    sh ~/dotfiles/i3/scripts/i3-lock-blur.sh # blured screenshot i3lock
fi

if [ $res = "suspend" ]; then
    # lock screen and suspend
    sh ~/dotfiles/i3/scripts/i3-lock-blur.sh && systemctl suspend
fi

if [ $res = "logout" ]; then
    i3-msg exit
fi

if [ $res = "reboot" ]; then
    reboot
fi

if [ $res = "poweroff" ]; then
    poweroff
fi

exit 0
