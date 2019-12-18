#!/bin/bash

# Checks battery status every 5 minutes and sends a notification if there is
# less than 30 percent of battery life left

BATTINFO=`acpi -b`

while true
do
    sleep 300
    if [[ `echo $BATTINFO | grep Discharging` && `echo $BATTINFO | cut -f 2 -d ","` < 30 ]];
    then
        notify-send "Low battery!   " "`echo $BATTINFO | cut -f 2 -d ","` battery remaining...\n
        Please charge!" --icon=dialog-warning
    fi
done
