#!/bin/bash

# We will create a list for the links X -> /home/user/.X 
# and another for X -> ~/.config/X 

# Before the symlinks we have to delete
# all the configuration files and folders.
# We can overwite files with ln, but not folders...
# For that, it suffices to delete each file/folder 
# using "rm -rf ..." before creating the symlink. 
# This is done automatically by this script.


# Since this script is quite dangerous, we ask user for confirmation.
echo -ne "\nWARNING! This script may be harmfull for your system.\nDo you want to continue?\n\n\n"
read -p "Type 'yes' to continue.    " yn

if [ "$yn" = "yes" ]; then
    echo "Running the script symlinks.sh"
    
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
    
    echo -ne "\ncreating softlinks to /home/user/\n"
    for X in "${linkstohome[@]}"
        do
        	rm -rf ~/.$X
        	ln -sfn ~/dotfiles/x ~/.$X
        done

    echo -ne "\ncreating softlinks to /home/user/.config\n"
    for X in "${linkstoconfig[@]}"
        do
        	rm -rf ~/.config/$X
        	ln -sfn ~/dotfiles/$X ~/.config/$X
        done
    echo -ne "\ndone!\n"

    echo -ne "\ncreating softlinks to program-specific directories\n"
 	ln -sfn ~/dotfiles/elinks.conf ~/.elinks/

    echo -ne "\nYour config files are now loaded!\n"
else
    echo -ne "\nYou may run the script symlinks.sh manually at any time.\n"
fi

echo -ne "Exiting script symlinks.sh"
