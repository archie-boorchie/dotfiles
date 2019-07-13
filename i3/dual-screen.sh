#!/bin/bash

# This script detects and auto-configures one (1) external monitor. It is
# designed to be used either as a mode in i3wm or as an independent script.


# If no argument is provided start interactive mode
arg=${1:-i}

# Interactive mode
if [[ $arg = "i" ]]; then
    echo "Auto-configure the external monitor. Pass argument [d]ual, [l]aptop, [e]xternal, [m]irror, [q]uit."
    read -e arg
    if [[ $arg = "q" ]]; then
        exit
    fi
fi

# Help mode
if [ $arg = "h" -o $arg = "-h" -o $arg = "--help" ]; then
    echo "Auto-configure an external monitor. Optional arguments: [d]ual, [l]aptop, [e]xternal, [m]irror, or empty for [i]nteractive mode."
    exit
fi

# Configuring mode
if [[ $arg = "d" ]]; then
# enable both monitors
    xrandr | grep -q "HDMI1 connected" && xrandr --output eDP1 --auto --primary --output HDMI1 --auto --left-of eDP1
    xrandr | grep -q "DP1 connected" && xrandr --output eDP1 --auto --primary --output DP1 --auto --left-of eDP1
elif [[ $arg = "l" ]]; then
# enable laptop monitor / disable external monitor
    xrandr | grep -q "HDMI1 connected" && xrandr --output HDMI1 --off --output eDP1 --auto --primary
    xrandr | grep -q "DP1 connected" && xrandr --output DP1 --off --output eDP1 --auto --primary
elif [[ $arg = "e" ]]; then
# enable external monitor / disable laptop monitor
    xrandr | grep -q "HDMI1 connected" && xrandr --output HDMI1 --auto --primary --output eDP1 --off
    xrandr | grep -q "DP1 connected" && xrandr --output DP1 --auto --primary --output eDP1 --off
elif [[ $arg = "m" ]]; then
# enable both monitors in 'mirror' mode
    xrandr | grep -q "HDMI1 connected" && xrandr --output eDP1 --auto --output HDMI1 --auto --same-as eDP1
    xrandr | grep -q "DP1 connected" && xrandr --output eDP1 --auto --output DP1 --auto --same-as eDP1
else
    echo "Unknown command. Read help for details."
fi

# Restart i3wm in place to use the new configuration
i3-msg restart
