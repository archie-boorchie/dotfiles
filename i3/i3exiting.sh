#!/bin/bash

res=$(rofi -dmenu -p "   :" -lines 5 < ~/dotfiles/i3/.dmenu-i3exit)

if [ $res = "lock" ]; then
    # i3lock exit # traditional i3lock
    sh ~/dotfiles/i3/i3lock-blur.sh # blured screenshot i3lock
fi

if [ $res = "logout" ]; then
    i3-msg exit
fi

if [ $res = "suspend" ]; then
    sh ~/dotfiles/i3/i3lock-blur.sh && systemctl suspend
fi

if [ $res = "reboot" ]; then
    reboot
fi

if [ $res = "poweroff" ]; then
    poweroff
fi

exit 0
