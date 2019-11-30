# Don't wait too long after <Esc>
# (Warning: Setting this too low can break some zsh functionality, eg:
#  https://github.com/zsh-users/zsh-autosuggestions/issues/254#issuecomment-345175735)
export KEYTIMEOUT=5

# Use fish-like syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# fish-like autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Use vim keybings and a vim mode right prompt
# (the right prompt overwites the previous one)
source ~/dotfiles/vim-mode.zsh
# # Or, if you prefer the standard vi mode:
# bindkey -v

# Complete the next suggested word when in instert mode
bindkey '^W' forward-word

# Set up the prompt
source ~/dotfiles/minimal-prompt.zsh
# # Or, if you prefer a standard one:
# autoload -Uz promptinit
# promptinit
# prompt fade black

# Note: the order of zsh-syntax-highlighting, zsh-autosuggestions, vim-mode is
# chosen this way to avoid conficts. Also, if the prompt is after vim-mode it
# gets redrawn.

# Use a pkgfile hook to automatically search the official repositories when
# entering an unrecognized command
source /usr/share/doc/pkgfile/command-not-found.zsh

# History settings
# set history file
HISTFILE=~/.zsh_history
# ignore all duplicates in history
setopt histignorealldups
# share history between terminals
setopt sharehistory
# keep 1000 lines of history
HISTSIZE=1000
SAVEHIST=1000
# don't add commands that start with space in history
setopt HIST_IGNORE_SPACE
# don't add failed commands in history
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }
# fish-like history search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Automatically reset the terminal if needed
ttyctl -f

# Enable help command
autoload -Uz run-help
# also enable helper functions that need to be enabled separately
autoload -Uz run-help-git
autoload -Uz run-help-ip
autoload -Uz run-help-openssl
autoload -Uz run-help-p4
autoload -Uz run-help-sudo
autoload -Uz run-help-svk
autoload -Uz run-help-svn
# and rename run-help to help
unalias run-help
alias help=run-help

# Have new executables included in the completion
zstyle ':completion:*' rehash true

# Add ~/bin to PATH (used for custom scripts)
export PATH=$PATH:~/bin

# Import user defined aliases and functions
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi
if [ -f ~/.functions ]; then
    . ~/.functions
fi

# Use modern completion system
autoload -U compinit
compinit

# To autocomplete "/" after "cd .."
zstyle ':completion:*' special-dirs true

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Directory navigation
# omit cd prefix
setopt autocd
# add each visited directory to dirs list
setopt autopushd
# ignore directory duplicates
setopt pushdignoredups
# keep 10 most recently visit directories in memory
DIRSTACKSIZE=11

# Set default apps
export EDITOR=vim
export TERMINAL=termite
export BROWSER=qutebrowser

# Edit command in editor
export VISUAL=vim
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd V edit-command-line

# Customize TTY 
if [ "$TERM" = "linux" ]; then
  prompt fade black
  /bin/echo -e "
  \e]P0151515
  \e]P1fb9fb1
  \e]P2acc267
  \e]P3ddb26f
  \e]P46fc2ef
  \e]P5e1a3ee
  \e]P612cfc0
  \e]P7d0d0d0
  \e]P8505050
  \e]P9fb9fb1
  \e]PAacc267
  \e]PBddb26f
  \e]PC6fc2ef
  \e]PDe1a3ee
  \e]PE12cfc0
  \e]PFf5f5f5
  "
  # get rid of artifacts
  clear
fi

# Pressing tab on an empty buffer starts autocompletion of files and directories
function complete_pwd_items_on_empty_buffer
{
    if [[ -z $BUFFER ]]; then
        BUFFER="./"
        CURSOR=2
        zle list-choices
    else
        zle expand-or-complete
    fi
}
zle -N complete_pwd_items_on_empty_buffer
# bind to tab
bindkey '^I' complete_pwd_items_on_empty_buffer

# Window title
case $TERM in
  termite|*xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term)
    precmd () {
      print -Pn "\e]0;%n@%M [%~]\a"
    }
    preexec () { print -Pn "\e]0;%n@%M [%~] ($1)\a" }
    ;;
  screen|screen-256color)
    precmd () {
      print -Pn "\e]83;title \"$1\"\a"
      print -Pn "\e]0;$TERM - (%L) %n@%M [%~]\a"
    }
    preexec () {
      print -Pn "\e]83;title \"$1\"\a"
      print -Pn "\e]0;$TERM - (%L) %n@%M %# [%~] ($1)\a"
    }
    ;;
esac
