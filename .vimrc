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

" Set colors

" set line numbers
set number

"remap esc to jk
inoremap jk <ESC>

"remap leader key
let mapleader = "\<Space>"

"control-p fuzzy search
 let g:ctrlp_map = '<c-o>'
 let g:ctrlp_cmd = 'CtrlP'
