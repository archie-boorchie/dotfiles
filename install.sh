#!/bin/bash

######################################################
#                                                    #
#   This is a script that can be used to create      #
#   a user's environment, after a basic arch linux   #
#   installation and the creation of a sudo user.    #
#   More on that on file tips_for_installation.      #
#                                                    #
#   Created by:                                      #
#   Lampros Trifyllis [archie-boorchie @ GitHub]     #
#                                                    #
######################################################


# During basic installation base and base-devel 
# are assumed to be installed.


# First, we create a list of the packages from the 
# official repositories.

corepackages=(
#
# Python and python modules
python2 # Python v2. Needed many times for package management
python # Latest version of Python (currently v2)
python-matplotlib # A python plotting library, making publication quality plots
python-numpy # Scientific tools for Python
#
# Packages for pacman
reflector # A script to retrieve and filter the latest Pacman mirror list
pacman-contrib # Contributed scripts and tools for pacman systems 
#
# Core utilities
fd # Simple, fast and user-friendly alternative to find
mlocate # Merging locate/updatedb implementation
htop # Interactive process viewer
# 
# Archive management
atool # Script for managing file archives of various types
# 
# I do not use a display manager
# 
# Window manager
i3 # install the i3 group
# additionally, to save an i3 session we need
perl-anyevent-i3
perl-json-xs
#
git # Git is used for aur packages, dotfile management etc
# It is probably already be installed for cloning this repository
#
# Editors
gvim # main editor is vim - I use gvim package to get the +xterm_clipboard option for vim
# something for GUI? maybe atom or gedit
#
# PDF viewer
mupdf # as an alternative I have llpp from AUR
cups # for printing
# something more mainstream? maybe evince or zathura
#
# LaTeX
texlive-most # includes TeX Live applications
texlive-langgreek # fonts and support for typesetting Greek
biber # a Unicode-capable BibTeX replacement for biblatex users
#
# File managers
ranger # main
thunar # for GUI
#
# Printing
cups  # the CUPS Printing System - daemon package
# You now have to Enable and start org.cups.cupsd.service (maybe automatically from this script)
print-manager # GUI-tool for managing print jobs and printers (KDE)
#
# Launcher
rofi
#
# Fonts
adobe-source-code-pro-fonts
ttf-dejavu # needs the correct package
#
# Internet browsers
qutebrowser # A keyboard-driven, vim-like browser based on PyQt5 (main browser)
opera # A fast and secure web browser (for some demanding tasks)
firefox # Standalone web browser from mozilla.org (for some demanding tasks)
flashplugin # flash plugin for firefox
#
# Tor 
tor # Anonymizing overlay network
arm # Terminal status monitor for Tor relays
#
# Network utilities
curl # An URL retrieval utility and library
wget # Network utility to retrieve files from the Web
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
# Virtual machines
virtualbox
#
# Toolkits for image etc convertions and so on 
imagemagick # An image viewing/manipulation program
#
# Screen capturing
maim #  Simple command line utility that takes screenshots (better than scrot)
# add a screencast tool
#
# Presentation, multiscreen etc
pdfpc # pdf presentation console
mons # for easy multiscreen management
#
# For fun
fortune-mod
cowsay
cmatrix
#
# Uncategorised
nmap # Utility for network discovery and security auditing
#
)

# update and synchronise pacman
echo -ne "\nSynchronising pacman\n"
sudo pacman -Syy

# install official repository packages
echo -ne "\nInstalling packages from official repositories\n"
for X in "${corepackages[@]}"
do
	sudo pacman -S --noconfirm --needed $X
done

echo -ne "\nOfficial repository packages are ready\n"

# Install aurman to help with the AUR package management
echo -ne "\nInstalling aurman to help with the AUR package management\n"
cd ~
git clone https://aur.archlinux.org/aurman.git
cd aurman
makepkg -sic
cd ~
rm -rf aurman/

echo -ne "\naurman will now be used to manage the AUR packages\n"


# Now we create a list of packages from [AUR].
# aurman is already installed via git,
# and then it will be used to install the rest aur packages.

aurpackages=(
#
# Python modules
python-nmap # A Python library which helps in using the nmap port scanner
# 
# Archive management
dtrx # An intelligent archive extraction tool
#
# Tor 
tor-browser # Tor Browser Bundle: anonymous browsing using Firefox and Tor (international PKGBUILD)
#
# PDF viewer
llpp 
#
# Data syncing
dropbox
owncloud
#
speedtest # check internet speed in terminal
#
# pdf utilities
pdftk # pdftk is a simple tool for doing everyday things with PDF documents
crop-pdf # command line tool to crop PDF files
#
# Screenshot, video recording
screenkey # Show the keys you type on the screen
#
# Screens utils
xorg-xrandr # Primitive command line interface to RandR extension
arandr # Provide a simple visual front end for XRandR 1.2.
xorg-xbacklight # RandR-based backlight control application
#
)

# install aur packages
echo -ne "\nInstalling aur packages with aurman\n"
for Y in "${aurpackages[@]}"
do
	aurman -S --noconfirm --needed $Y
done

echo -ne "\nAUR packages are ready\n"

# Final step: manage dotfiles, create symlinks for them
echo -ne "\nCreating symlinks for the dotfiles\n"

sh ~/dotfiles/symlinks.sh

echo -ne "\nSystem is now ready to use!\n"

echo -ne "\nExiting script install.sh\n"
