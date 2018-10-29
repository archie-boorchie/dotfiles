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

" Directory to store backup files
set backupdir=~/.cache/vim/backup//

" Directory to store swap files
set dir=~/.cache/vim/swap//

" Keep 10000 lines of command line history
set history=10000

" Show current position of cursor
set noruler

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

" Disable audible and visual bells
set noerrorbells
set novisualbell
set t_vb=

" Delete comment characters when joining lines
set formatoptions+=j

" to use with explore
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_winsize = 50

" Change cursor shape according to mode
if empty($TMUX)
  let &t_SI = "\<esc>[5 q"
  let &t_EI = "\<esc>[2 q"
  let &t_SR = "\<esc>[3 q"
else
  let &t_SI = "\<esc>Ptmux;\<esc>\<esc>[5 q\<esc>\\"
  let &t_EI = "\<esc>Ptmux;\<esc>\<esc>[2 q\<esc>\\"
  let &t_SR = "\<esc>Ptmux;\<esc>\<esc>[3 q\<esc>\\"
endif

" Set default browser to be used with gx command in links


" " Placeholders
" " Pressing ;; jumps to the next match
" :imap <buffer> ;; <C-O>/<++><CR><C-O>c4l
" :nmap <buffer> ;; /<++><CR>c4l


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
  autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh
  autocmd BufNewFile *.tex 0r ~/.vim/templates/skeleton.tex
  augroup END
endif

" Automatic installation for vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins (to use with vim-plug; install with :PlugInstall)
call plug#begin('~/.vim/plugged')
    " Distraction-free writing in Vim
    Plug 'junegunn/goyo.vim'
    "
    " Hyperfocus-writing in Vim
    Plug 'junegunn/limelight.vim'
    "
    " A modern vim plugin for editing LaTeX files
    Plug 'lervag/vimtex'
    "
    " Retro groove color scheme for Vim
    Plug 'morhetz/gruvbox'
    "
    "   " Vim script for text filtering and alignment 
    "   Plug 'godlygeek/tabular'
    "
    " A light and configurable statusline/tabline plugin for Vim
    Plug 'itchyny/lightline.vim' 
    "
    " Provides the branch name of the current git repository
    Plug 'itchyny/vim-gitbranch'
    "
    "   " A Git wrapper so awesome, it should be illegal
    "   Plug 'tpope/vim-fugitive'
    "
    " The ultimate snippet solution for Vim
    Plug 'SirVer/ultisnips'
    "
    " Pandoc integration and utilities for vim 
    Plug 'vim-pandoc/vim-pandoc'
    "
    " Pandoc markdown syntax, to be installed alongside vim-pandoc
    Plug 'vim-pandoc/vim-pandoc-syntax'
    "
    " Repeat resizing commands without repeating <c-w>
    Plug 'roxma/vim-window-resize-easy'
    "
    " Easily search for, substitute, and abbreviate multiple variants of a word
    Plug 'tpope/vim-abolish'
    "
    "   " Combine with netrw to create a delicious salad dressing
    "   Plug 'tpope/vim-vinegar'
    "
    " Directory viewer for Vim
    Plug 'justinmk/vim-dirvish'
    "
    " Quoting/parenthesizing made simple
    Plug 'tpope/vim-surround'
    "
    " Brings physics-based smooth scrolling to the Vim world!
    Plug 'yuttie/comfortable-motion.vim'
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
let g:gruvbox_contrast_light='hard'
colorscheme gruvbox

" LimeLight settings
let g:limelight_default_coefficient = 0.7
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
let g:limelight_priority = -1 " not to overrule hlsearch

" lightline settings
set laststatus=2
if !has('gui_running')
    set t_Co=256
endif
set noshowmode
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'filename' ] ],
      \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'gitbranch' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'filename' ] ],
      \   'right': [ [ 'percent' ], [ 'gitbranch' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }
" merge modify symbol in filename
function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' ' : ''
  return filename . modified
endfunction

" UltiSnips settings
" use absolute path, not ~  or $HOME:
let g:UltiSnipsSnippetDirectories = ['/home/lampros/.vim/UltiSnips']
let g:UltiSnipsEditSplit = "vertical"
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" vimtex settings
let g:vimtex_fold_automatic=0 
let g:vimtex_fold_enabled=0

" vim-pandoc settings
let g:pandoc#modules#disabled = ["folding"] " turn off folding

" comfortable-motion.vim settings
let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"
let g:comfortable_motion_friction = 80.0
let g:comfortable_motion_air_drag = 2.0
