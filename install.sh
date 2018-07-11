#!/bin/bash

######################################################
#   This is a script that can be used to create      #
#   a user's environment, after a basic arch linux   #
#   installation and the creation of a sudo user.    #
#                                                    #
#   Created by:                                      #
#   Lampros Trifyllis [archie-boorchie @ GitHub]     #
######################################################

# During basic installation base and base-devel 
# are assumed to be installed.

# First, we create a list of the packages from [CORE]
corepackages=(
# Window manager
i3 # install the i3 group
#
# Git is used for aur packages, dotfile management etc
git # install git
#
# Editors
vim # main editor
# something for GUI? maybe atom or gedit
#
# PDF viewer
mupdf # as an alternative I have llpp
cups # for printing
# something more mainstream? maybe evince or zathura
#
# File managers
ranger # main
thunar # for GUI
#
# Launcher
rofi
#
# Fonts
adobe-source-code-pro-fonts
ttf-dejavu # needs the correct package
#
# Internet browsers
qutebrowser # main
firefox # for some demanding tasks
#
# office apps
libreoffice-fresh # with new program enhancements
hunspell # for spell-checking
hunspell-en # for english spell-checking
hunspell-gr # for greek spell-checking
# 
# Icons
numix-circle
#
# virtual machines
virtualbox
#
# Screenshot, video recording
#
# Presentation, multiscreen etc
pdfpc # pdf presentation console
mons # for easy multiscreen management
#
# For fun
fortune-mod
cowsay
cmatrix
)

# update and synchronise pacman
echo -ne "\nsynchronising pacman\n"
sudo pacman -Syy

# install core packages
echo -ne "\ninstalling packages from CORE repository\n"
for X in "${corepackages[@]}"
do
	sudo pacman -S --noconfirm $X
done

echo -ne "\nCORE packages are ready\n"

# Install aurman to help with the AUR package management
echo -ne "\nInstalling aurman to help with the AUR package management\n"
cd ~
git clone https://aur.archlinux.org/aurman.git
cd aurman
makepkg -sic
cd ~
rm -rf aurman/

echo -ne "\naurman will now be used to manage the AUR packages\n"

# List of programs from [AUR]
# aurman is installed via git
# and then it is used to install the rest
aurpackages=(
#
# PDF viewer
llpp 
# Data syncing
dropbox
#
speedtest # check internet speed in terminal
pdftk # command line pdf file modifier
screenkey # show the keys you type on the screen
)

# install aur packages
echo -ne "\nInstalling aur packages with aurman\n"
for Y in "${aurpackages[@]}"
do
	aurman -S --noconfirm $Y
done

echo -ne "\nAUR packages are ready\n"

# Final step: manage dotfiles, create symlinks for them
echo -ne "\nCreating symlinks for the dotfiles\n"

sh ~/dotfiles/symlinks.sh

echo -ne "\nSystem is now ready to use!\n"
