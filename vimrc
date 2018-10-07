" Use Vim rather than Vi settings (this command must be first)
set nocompatible

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Hide menus etc in gvim 
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" Fast terminal
set ttyfast

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Set word wrap to 80 characters
set textwidth=80

" Highlight column after wrap 
set colorcolumn=+1

" Keep a backup file
set backup

" Keep 100 lines of command line history
set history=100

" Show current position of cursor
set ruler

" Show line numbers relevant to current line
set relativenumber

" Instead of 0 show real line number in current line, when relativenumber is set
set number

" Enable syntax highlighting
syntax enable
 
" Search highlighting
" enable search highlighting
set hlsearch 
" ignore case when searching
set ignorecase
" switch search to case-sensitive when search query contains an uppercase letter
set smartcase 
" incremental search that shows partial matches
set incsearch

" Set standard encoding
set encoding=utf8

" Display incomplete commands
set showcmd

" Use Q for fast formatting
" format selection
vmap Q gq 
" format current paragraph
nmap Q gqap

" Enable mouse
set mouse=a

" Turn off error sounds and flashes
set noerrorbells " disable beep 
set novisualbell " disable flash

" Directory to store swap files
set dir=~/.cache/vim

" Delete comment characters when joining lines
set formatoptions+=j

" Placeholders
" Pressing ;; jumps to the next match
:imap <buffer> ;; <C-O>/<++><CR><C-O>c4l
:nmap <buffer> ;; /<++><CR>c4l


"""""""""""

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 68 characters.
  autocmd FileType text setlocal textwidth=68

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

"""""""""""

" Set autoindenting on
set autoindent

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Spell check options
set nospell
set spelllang=en_gb 
set spellfile=~/.vim/spell/en_gb.utf-8.add

" Use smart tabs
set smarttab

" 1 tab == 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Use spaces instead of tabs
set expandtab

" Set omnicompletion on
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Insert template according to the file's extension
if has("autocmd")
  augroup templates
  autocmd BufNewFile *.sh 0r ~/Templates/skeleton.sh
  autocmd BufNewFile *.apstex 0r ~/Templates/apssamp.tex
  autocmd BufNewFile *.tex 0r ~/Templates/Template_LT/main.tex
  augroup END
endif

" Plugins (to use with vim-plug; install with :PlugInstall)
call plug#begin('~/.vim/plugged')
    " Distraction-free writing in Vim
    Plug 'junegunn/goyo.vim'
    " Hyperfocus-writing in Vim
    Plug 'junegunn/limelight.vim'
    " A modern vim plugin for editing LaTeX files
    Plug 'lervag/vimtex'
    " Retro groove color scheme for Vim
    Plug 'morhetz/gruvbox'
    " Vim script for text filtering and alignment 
    Plug 'godlygeek/tabular'
    " A light and configurable statusline/tabline plugin for Vim
    Plug 'itchyny/lightline.vim' 
    " Provides the branch name of the current git repository
    Plug 'itchyny/vim-gitbranch'
    " The ultimate snippet solution for Vim
    Plug 'SirVer/ultisnips'
call plug#end()

" Integrate Limelight to Goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Goyo settings
let g:goyo_width = 80

" For gruvbox colors
" set termguicolors
set background=dark
let g:gruvbox_italic=0
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='medium'
colorscheme gruvbox

" LimeLight settings
let g:limelight_default_coefficient = 0.7
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
" Set highlighting priority to -1 not to overrule hlsearch
let g:limelight_priority = -1

" lightline settings
set laststatus=2
if !has('gui_running')
    set t_Co=256
endif
set noshowmode
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

" UltiSnips settings
let g:UltiSnipsSnippetsDir = "~/.vim/bundle/ultisnips/UltiSnips"
let g:UltiSnipsEditSplit = "vertical"
let g:UltiSnipsExpandTrigger="<tabs>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
