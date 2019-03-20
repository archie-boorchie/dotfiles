" Use Vim rather than Vi settings (this command must be first)
set nocompatible

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
    finish
endif

" Fast terminal
set ttyfast

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Set word wrap to 80 characters
set textwidth=80

" Highlight column after wrap 
set colorcolumn=+1

" Keep some lines above and below cursor always visible
set scrolloff=3

" Don't put two spaces after a period when joining lines
set nojoinspaces

" Delete comment characters when joining lines
set formatoptions+=j

" Better movement for snake_case words
set iskeyword-=_

" Set leader to spacebar
noremap <SPACE> <Nop>
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

" Amount of time to wait for key sequence
set timeoutlen=1000

" Don't wait for other keys after Escape
set ttimeoutlen=1

" Scroll the screen and advance the cursor at the same time
map <c-j> j<c-e>
map <c-k> k<c-y>

" Yank till the end of line
nnoremap Y y$

" Paste the last yanked text
nnoremap <leader>p "0p
nnoremap <leader>P "0P
xnoremap <leader>p "0p
xnoremap <leader>P "0P

" Exchange ; and : to easily access command mode
nno : ;
nno ; :
vno : ;
vno ; :

" In insert mode use j+direction for action
imap jk <Esc>
imap jj <C-O>dd
imap jh <C-O>b
imap jl <C-O>w

" Keep a backup file
set backup

" Directory to store backup files
set backupdir=~/.cache/vim/backup//

" Directory to store swap files
set dir=~/.cache/vim/swap//

" Keeping an undo file
set undofile
set undodir=~/.cache/vim/undo//

" Keep 1000 lines of command line history
set history=1000

" Show current position of cursor
set ruler

" Show line numbers relevant to current line
set relativenumber

" Instead of 0 show real line number in current line, when relativenumber is set
set number

" Enable file type detection and language-dependent indentation
filetype plugin indent on

" Set autoindenting on
set autoindent
 
" Enable syntax highlighting
syntax enable

" Set omnicompletion on
set omnifunc=syntaxcomplete#Complete

" Jump to the last known cursor position when opening a file
autocmd BufReadPost * normal `"

" Search highlighting
" enable search highlighting
set hlsearch 
" ignore case when searching
set ignorecase
" switch search to case-sensitive when search query contains uppercase letters
set smartcase 
" incremental search that shows partial matches
set incsearch

" Easily turn-off search highlighting
noremap <Leader>/ :nohlsearch<CR>:<backspace>

" Set standard encoding
set encoding=utf8

" Display incomplete commands
set showcmd

" Faster update time
set updatetime=100

" Preview changes of current file before saving
function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

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

" Change cursor shape according to mode
if empty($TMUX)
    let &t_SI = "\<esc>[5 q"
    let &t_EI = "\<esc>[1 q"
    let &t_SR = "\<esc>[3 q"
else
    let &t_SI = "\<esc>Ptmux;\<esc>\<esc>[5 q\<esc>\\"
    let &t_EI = "\<esc>Ptmux;\<esc>\<esc>[1 q\<esc>\\"
    let &t_SR = "\<esc>Ptmux;\<esc>\<esc>[3 q\<esc>\\"
endif

" Set default browser to be used with gx command in links

" Hide menus etc in gvim 
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" " Placeholders
" " Pressing ;; jumps to the next match
" :imap <buffer> ;; <C-O>/<++><CR><C-O>c4l
" :nmap <buffer> ;; /<++><CR>c4l

" Spell check options
set nospell
set spelllang=en_gb
set spellfile=~/.vim/spell/en-gb.utf-8.add

" Use smart tabs
set smarttab

" 1 tab == 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Use spaces instead of tabs
set expandtab

" Show command matches above the command line
set wildmenu
set wildmode=longest:full,full

" Ignore case in filenames
set wildignorecase

" Insert template according to the file's extension
augroup templates
autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh
autocmd BufNewFile *.tex 0r ~/.vim/templates/skeleton.tex
augroup END


""" Plugins and their settings 

" Automatically install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins (to manage with vim-plug; update all with :PlugUpdate)
call plug#begin('~/.vim/plugged')
    "
    " Minimalist Vim Plugin Manager
    Plug 'junegunn/vim-plug'
    "
    " Helpers for UNIX
    Plug 'tpope/vim-eunuch'
    "
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
    "   " Provides the branch name of the current git repository
    "   Plug 'itchyny/vim-gitbranch'
    "
    " A Git wrapper so awesome, it should be illegal
    Plug 'tpope/vim-fugitive'
    "
    " A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.
    Plug 'airblade/vim-gitgutter'
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
    " Easily search for, substitute, and abbreviate multiple variants of a word
    Plug 'tpope/vim-abolish'
    "
    " Combine with netrw to create a delicious salad dressing
    Plug 'tpope/vim-vinegar'
    "
    "   " Directory viewer for Vim
    "   Plug 'justinmk/vim-dirvish'
    "
    " Quoting/parenthesizing made simple
    Plug 'tpope/vim-surround'
    "
    " Enable repeating supported plugin maps with .
    Plug 'tpope/vim-repeat'
    "
    " Make the yanked region apparent!
    Plug 'machakann/vim-highlightedyank'
    "
    " Brings physics-based smooth scrolling to the Vim world!
    Plug 'yuttie/comfortable-motion.vim'
    "
    " Undo a :quit -- reopen the last window you closed
    Plug 'AndrewRadev/undoquit.vim'
    "
    " A Vim plugin for visually displaying indent levels in code
    Plug 'nathanaelkane/vim-indent-guides'
    "
    " Start a * or # search from a visual block
    Plug 'nelstrom/vim-visual-star-search'
    "
    " The fancy start screen for Vim
    Plug 'mhinz/vim-startify'
    "
    " Text outlining and task management for Vim based on Emacs' Org-Mode
    Plug 'jceb/vim-orgmode'
    "
    " Use CTRL-A/CTRL-X to increment dates, times, and more
    Plug 'tpope/vim-speeddating'
    "
    " Only show line numbers in the active window
    Plug 'auwsmit/vim-active-numbers'
    "
    " A Vim cheat sheet that makes sense, inside Vim!
    Plug 'lifepillar/vim-cheat40'
    "
    " Block-breaking game in vim 8.0
    Plug 'johngrib/vim-game-code-break'
    "
    " Simpler Rainbow Parentheses
    Plug 'junegunn/rainbow_parentheses.vim'
    "   "
    "   " Vim plugin to dim inactive windows
    "   Plug 'blueyed/vim-diminactive'
    "
    " A calendar application for Vim
    Plug 'itchyny/calendar.vim'
    "
    " Vim plugin for intensely orgasmic commenting
    Plug 'scrooloose/nerdcommenter'
    "
    " A powerful grammar checker for Vim using LanguageTool
    Plug 'rhysd/vim-grammarous'
    "
call plug#end()

" NerdCommenter settings
" add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" Goyo settings
let g:goyo_width = 80
" integrate Limelight to Goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" LimeLight settings
let g:limelight_default_coefficient = 0.7
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
let g:limelight_priority = -1 " don't overrule hlsearch

" Gruvbox settings
set background=dark
let g:gruvbox_italic=0
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='hard'
colorscheme gruvbox

" Lightline settings
set laststatus=2
if !has('gui_running')
    set t_Co=256
endif
set noshowmode
let g:lightline = {
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'filename' ] ],
        \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'gitbranch' ], [ 'readonly' ] ]
        \ },
        \ 'inactive': {
        \   'left': [ [ 'filename' ] ],
        \   'right': [ [ 'percent' ], [ 'gitbranch' ], [ 'readonly' ] ]
        \ },
        \ 'component_function': {
        \   'filename': 'LightlineFilename',
        \   'gitbranch': 'GitBranchWithSymbol'
        \ },
        \ }
" merge modify symbol in filename
function! LightlineFilename()
    let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
    let modified = &modified ? ' ' : ''
    return filename . modified
endfunction
" add git symbol in gitbranch
function! GitBranchWithSymbol()
    let gitbranchname = fugitive#head() !=# '' ? fugitive#head() : ''
    let gitbranchsymbol = fugitive#head() !=# '' ? "  " : ''
    return gitbranchsymbol . gitbranchname
endfunction

" UltiSnips settings
" use absolute path, not ~ or $HOME:
let g:UltiSnipsSnippetDirectories = ['/home/lampros/.vim/UltiSnips']
let g:UltiSnipsEditSplit = "context"
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Gitgutter settings
" using h for hunks
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
omap ih <Plug>GitGutterTextObjectInnerPending
omap ah <Plug>GitGutterTextObjectOuterPending
xmap ih <Plug>GitGutterTextObjectInnerVisual
xmap ah <Plug>GitGutterTextObjectOuterVisual
" refresh gitgutter when focusing
let g:gitgutter_terminal_reports_focus = 0

" Vimtex settings
let g:vimtex_quickfix_mode = 0
let g:vimtex_fold_automatic = 0
let g:vimtex_fold_enabled = 0
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
if has('nvim')
  let g:vimtex_compiler_progname = 'nvr'
endif
if get(g:, 'vimtex_enabled', 1)
    nmap \ <plug>(vimtex-cmd-create)
    xmap \ <plug>(vimtex-cmd-create)
endif

" Vim-pandoc settings
let g:pandoc#modules#disabled = ["folding"]

" Comfortable-motion settings
let g:comfortable_motion_friction = 80.0
let g:comfortable_motion_air_drag = 2.0
let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"

" Highlightedyank settings
let g:highlightedyank_highlight_duration = 150

" Startify settings
let g:startify_fortune_use_unicode = 1
let g:ascii = [
        \ '                                ',
        \ '            __                  ',
        \ '    __  __ /\_\    ___ ___      ',
        \ '   /\ \/\ \\/\ \ /'' __` __`\   ',
        \ '   \ \ \_/ |\ \ \/\ \/\ \/\ \   ',
        \ '    \ \___/  \ \_\ \_\ \_\ \_\  ',
        \ '     \/__/    \/_/\/_/\/_/\/_/  ',
        \ ]
let g:startify_custom_header =
      \ map(g:ascii + startify#fortune#boxed(), '"   ".v:val')
let g:startify_lists = [
        \ { 'type': 'files',     'header': ['   Recently opened'] },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks'] },
        \ { 'type': 'sessions',  'header': ['   Sessions'] },
        \ { 'type': 'commands',  'header': ['   Commands'] }
        \ ]
let g:startify_bookmarks = [ 
        \ { 'bi': '~/dotfiles/i3/config' },
        \ { 'bp': '~/dotfiles/polybar/config' },
        \ { 'bt': '~/dotfiles/termite/config' },
        \ { 'bv': '~/dotfiles/vimrc' },
        \ { 'bz': '~/dotfiles/zshrc' }
        \ ]

" GrammarCheck settings
let g:grammarous#use_vim_spelllang = 1

" Rainbow parentheses settings
let g:rainbow#max_level = 36
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}'], ['<', '>']]
