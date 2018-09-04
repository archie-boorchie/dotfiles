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
### X.org 
xorg-server # Xorg X server
xorg-xinit # X.Org initialisation program
xorg # Install the whole X group
#
### Terminal 
termite # A simple VTE-based terminal
tmux # A terminal multiplexer	
#
### Python and python modules 
python2 # Python v2. Needed many times for package management
python # Latest version of Python (currently v2)
python-matplotlib # A python plotting library, making publication quality plots
python-numpy # Scientific tools for Python
#
### Packages for pacman
reflector # A script to retrieve and filter the latest Pacman mirror list
pacman-contrib # Contributed scripts and tools for pacman systems 
#
### Core utilities
fd # Simple, fast and user-friendly alternative to find
mlocate # Merging locate/updatedb implementation
htop # Interactive process viewer
lolcat # a colourful alternative to cat 
# 
### Archive management
atool # Script for managing file archives of various types
unzip # For extracting and viewing files in .zip archives
# 
### Display manager
# I do not use a display manager
# 
### Window manager
i3 # install the i3 group - i3gaps is the default
# additionally, to save an i3 session we need
perl-anyevent-i3
perl-json-xs
#
### Desctop notification deamon
dunst # Customizable and lightweight notification-daemon
# 
git # Git is used for aur packages, dotfile management etc
# It is probably already be installed for cloning this repository
#
### Editors
gvim # main editor is vim - I use gvim package to get the +xterm_clipboard option for vim
# something for GUI? maybe atom or gedit
#
### PDF viewer
mupdf # as an alternative I have llpp from AUR
cups # for printing
# something more mainstream? maybe evince or zathura
#
### LaTeX
texlive-most # includes TeX Live applications
texlive-langgreek # fonts and support for typesetting Greek
biber # a Unicode-capable BibTeX replacement for biblatex users
#
### File managers
# console
ranger # A simple, vim-like file manager
# gui
thunar # Modern file manager for Xfce
# make thunar functional
thunar-archive-plugin # Create and extract archives in Thunar
thunar-media-tags-plugin # Adds special features for media files to the Thunar File Manager
thunar-volman # Automatic management of removeable devices in Thunar
#
### Printing
cups  # the CUPS Printing System - daemon package
# You now have to Enable and start org.cups.cupsd.service (maybe automatically from this script)
print-manager # GUI-tool for managing print jobs and printers (KDE)
#
### Launcher
rofi
#
### Fonts
adobe-source-code-pro-fonts # Monospaced font family for user interface and coding environments
adobe-source-sans-pro-fonts # Sans serif font family for user interface environments
adobe-source-serif-pro-fonts # Serif typeface for setting text. Designed to complement Source Sans Pro
terminus-font # Monospace bitmap font (for X11 and console) 
ttf-dejavu
ttf-noto
ttf-font-awesome
awesome-terminal-fonts
#
### Icon themes
adwaita-icon-theme
# 
### Internet browsers
# gui
qutebrowser # A keyboard-driven, vim-like browser based on PyQt5 (main browser)
firefox # Standalone web browser from mozilla.org (for some demanding tasks)
flashplugin # flash plugin for firefox
# console
elinks
#
### Tor 
tor # Anonymizing overlay network
arm # Terminal status monitor for Tor relays
#
### Network utilities 
networkmanager # Network connection manager and user applications
nm-connection-editor # NetworkManager GUI connection editor and widgets
network-manager-applet # Applet for managing network connections
dnsmasq # Lightweight, easy to configure DNS forwarder and DHCP server
curl # An URL retrieval utility and library
wget # Network utility to retrieve files from the Web
#
### Vpn 
openvpn # An easy-to-use, robust and highly configurable VPN (Virtual Private Network)
networkmanager-openvpn # NetworkManager VPN plugin for OpenVPN
#
### Youtube utilities 
minitube # A native YouTube client in Qt. Watch YouTube videos without Flash Player
mps-youtube # Terminal based YouTube jukebox with playlist management
youtube-dl # A small command-line program to download videos from YouTube.com and a few more sites
youtube-viewer # Command line utility for viewing YouTube videos
#
### Irc client 
irssi # Modular text mode IRC client with Perl scripting
#
### Science 
calc # Arbitrary precision console calculator
stellarium # A stellarium with great graphics and a nice database of sky-objects
celestia # Real-time space simulation
units # Converts between different units
kalzium # Periodic Table of Elements
marble # Desktop Globe
## add more map tools and meteorology tools
#
### Office apps 
libreoffice-fresh # with new program enhancements
hunspell # for spell-checking
hunspell-en # for english spell-checking
hunspell-gr # for greek spell-checking
catdoc # A convertor for Microsoft Word, Excel, PowerPoint and RTF Files to text
# 
### Utils to check PDF files for differences 
diffpdf # Diffing pdf files visually or textually
#
### ebook convert etc
calibre # Ebook management application
#
### Time management
calcurse # A text-based personal organizer
remind # A sophisticated calendar and alarm program
#
### Icons
numix-circle
#
### Virtual machines
virtualbox
#
### Media players
feh # Fast and light imlib2-based image viewer 
mplayer # Media player for Linux 
mpv # a free, open source, and cross-platform media player 
#
### Toolkits for image etc convertions and so on 
imagemagick # An image viewing/manipulation program
#
### Screen capturing
maim #  Simple command line utility that takes screenshots (better than scrot)
# add a screencast tool
#
### Presentation, multiscreen etc
pdfpc # pdf presentation console
mons # for easy multiscreen management
#
### For fun
fortune-mod
cowsay
cmatrix
#
### Uncategorised
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
### TTYs 
libtsm # kmscon dependency 
kmscon # Terminal emulator based on Kernel Mode Setting (KMS)
#
### Media players
tiv # A simple image viewer that displays images directly in the terminal
#
### Python modules
python-nmap # A Python library which helps in using the nmap port scanner
# 
### Archive management
dtrx # An intelligent archive extraction tool
#
### Tor 
tor-browser # Tor Browser Bundle: anonymous browsing using Firefox and Tor (international PKGBUILD)
#
### PDF viewer
llpp 
#
### Data syncing
dropbox
owncloud
#
### Network utilities
speedtest # check internet speed in terminal
#
### PDF utilities
pdftk # pdftk is a simple tool for doing everyday things with PDF documents
crop-pdf # command line tool to crop PDF files
#
### Screenshot, video recording
fbgrab # A framebuffer screenshot grabber
screenkey # Show the keys you type on the screen
#
### Screens utils
xorg-xrandr # Primitive command line interface to RandR extension
arandr # Provide a simple visual front end for XRandR 1.2.
xorg-xbacklight # RandR-based backlight control application
#
### Utils to check PDF files for differences 
diff-pdf-git # A simple tool for visually comparing two PDF files
pdiff-git # Find differences between PDF documents
visual-pdf-diff-git # Merges two PDF files into one PDF file and highlights their visual differences
# also check a script in https://gist.github.com/timabell/9616807b2fe3fa60f234
#
### Tabletop RPGs
roll # A tool to roll a user-defined dice sequence and display the result
rolisteam # Virtual tabletop software. It helps you to manage tabletop role playing games with remote friends/players.
pcgen-git # An RPG Character Generator
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
