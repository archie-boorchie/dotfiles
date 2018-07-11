#!/bin/bash

# We will create a list for the links X -> /home/user/.X 
# and another for X -> ~/.config/X 

# Before the symlinks we have to delete
# all the configuration files and folders.
# We can overwite files with ln, but not folders...
# For that, it suffices to delete each file/folder 
# using "rm -rf ..." before creating the symlink. 

# dotfiles belonging to /home/user/
linkstohome=(
archey3.cfg
bash_logout
bash_profile
bashrc
)

# dotfiles belonging to /home/user/.config
linkstoconfig=(
aurman
fish
i3
llpp.conf
neofetch
powerline
qutebrowser
ranger
rofi
termite
vifm
)

# creating softlinks to /home/user/
for X in "${linkstoconfig[@]}"
do
	rm -rf ~/.$X
	ln -sfn ~/dotfiles/x ~/.$X
done

# creating softlinks to /home/user/.config
for X in "${linkstoconfig[@]}"
do
	rm -rf ~/.config/$X
	ln -sfn ~/dotfiles/$X ~/.config/$X
done
