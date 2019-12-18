#!/bin/bash

# Sends a message every half hour to remind you to take a break :-)

while true
sleep 1800
do notify-send 'Time flies!' \
    "It's been half-an-hour already...\n
    Why don't you take a break?    \n
    Remember to do some stretching\n and to relax your eyes!" \
    --icon=dialog-information
done
