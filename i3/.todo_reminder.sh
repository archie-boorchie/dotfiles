#!/bin/bash

# Sends a message every hour to remind you about your to-do list

sleep 900 # to appear 15 minutes after the "Take a break" notifications

while true
    sleep 1800
do 
    notify-send 'To-do list' \
        "`cat -b /home/lampros/.todolist.txt`" \
        --icon=dialog-information
done
