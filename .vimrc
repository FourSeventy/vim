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

"-- Solarized --
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

"tab to 4 spaces
set tabstop=4

"-- ctrl-p --
let g:ctrlp_map = '<c-o>'
let g:ctrlp_cmd = 'CtrlP'

" :w!! saves a file as root
cmap w!! w !sudo tee % >/dev/null

"-- NERDTree --
"autocmd vimenter * NERDTree "auto enables nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endi

"-- Airline --
let g:airline_powerline_fonts = 1
let g:airline_theme='distinguished'
set laststatus=2

"golang settings
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1


