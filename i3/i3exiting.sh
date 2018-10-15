#!/bin/bash

res=$(rofi -dmenu -lines 4 < ~/dotfiles/i3/.dmenu-i3exit)

if [ $res = "lock" ]; then
    i3lock exit
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
