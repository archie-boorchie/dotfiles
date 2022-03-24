#!/bin/bash

i3-msg 'workspace 0; exec alacritty --command gotop'
sleep 0.5
i3-msg 'splith'
i3-msg 'exec alacritty --command tty-clock -scnf %d/%m/%Y'
sleep 0.5
i3-msg 'splitv'
i3-msg 'exec alacritty --command battop'
sleep 1.0
i3-msg 'resize grow height 100 px'
i3-msg 'resize shrink width 220 px'
i3-msg 'focus up'
