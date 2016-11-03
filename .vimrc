"---------------------------------------
" General
" --------------------------------------

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" pathogen
execute pathogen#infect() 

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on
 
" Enable syntax highlighting
syntax enable

"color scheme
if !has("gui_running")
    let g:solarized_termtrans=1
    let g:solarized_termcolors=256
endif
colorscheme solarized
set background=dark

" set line numbers
set number

"remap esc to jk
inoremap jk <ESC>

"remap leader key
let mapleader = "\<Space>"

"No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"Make sure that extra margin on left is removed
set foldcolumn=0

"Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

"Use Unix as the standard file type
set ffs=unix,dos,mac

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"Use spaces instead of tabs
set expandtab

"Be smart when using tabs ;)
set smarttab

"1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

"Round indent to multiple of 'shiftwidth' for > and < commands
set shiftround

"Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set nowrap "Don't Wrap lines (it is stupid)

" :w!! saves a file as root
cmap w!! w !sudo tee % >/dev/null

"------------------------------------------------
" Plugins
" -----------------------------------------------

"------------------ ctrl-p ------------------
let g:ctrlp_map = '<c-o>'
let g:ctrlp_cmd = 'CtrlP'


"------------------ NERDTree -----------------------
"toggle
map <C-n> :NERDTreeToggle<CR>

" General properties
let NERDTreeDirArrows=1
let NERDTreeMinimalUI=1
let NERDTreeWinSize = 35

" Make sure that when NT root is changed, Vim's pwd is also updated
let NERDTreeChDirMode = 2
let NERDTreeShowLineNumbers = 0 
let NERDTreeAutoCenter = 1

" Open NERDTree on startup, when no file has been specified
autocmd VimEnter * if !argc() | NERDTree | endif


"------------------ Airline ---------------------------
let g:airline_powerline_fonts = 1
let g:airline_theme='distinguished'
set laststatus=2


"------------------ Go-vim ----------------------------
"enable highlighting
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

"fmt fail silent
let g:go_fmt_fail_silently = 1
