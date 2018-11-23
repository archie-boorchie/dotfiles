# Set up the prompt
source /home/lampros/dotfiles/minimal-prompt.zsh
# Or, if you prefer a standard one:
#   autoload -Uz promptinit
#   promptinit
#   prompt fade black

# Use vi keybings
bindkey -v

# Use fish-like syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Ignore all duplicates in history
setopt histignorealldups

# Share history between terminals
setopt sharehistory

# Keep 10000 lines of history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Use a pkgfile hook to automatically search the official repositories when
# entering an unrecognized command
source /usr/share/doc/pkgfile/command-not-found.zsh

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

# Wait only 10ms for key sequences
KEYTIMEOUT=1

# Have new executables included in the completion
zstyle ':completion:*' rehash true

# Add ~/bin to PATH (used for custom scripts)
export PATH=$PATH:~/bin

# Import user defined aliases
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

# Import user defined functions
if [ -f ~/.functions ]; then
    . ~/.functions
fi

# Use modern completion system
autoload -Uz compinit
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

# History autocompletion
# fish-like history search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# fish-like autosuggestion
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^W' forward-word

# Set default apps
export EDITOR=vim
export TERMINAL=termite
export BROWSER=qutebrowser

# Edit command in editor
export VISUAL=vim
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line

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
