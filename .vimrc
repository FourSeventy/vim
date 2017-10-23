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
colorscheme gruvbox
let g:gruvbox_contrast_dark='soft'
set background=dark
set termguicolors

" set line numbers
set number

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

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
set shiftwidth=2
set tabstop=2

"Round indent to multiple of 'shiftwidth' for > and < commands
set shiftround

"Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set nowrap "Don't Wrap lines (it is stupid)

"enable mouse scrolling
set mouse=a

"allows us to switch buffers without saving them 
set hidden

"set highlighting of words when searching
set hlsearch

" remap window movement 
nmap <leader>h <C-W><C-H>
nmap <leader>j <C-W><C-J>
nmap <leader>k <C-W><C-K>
nmap <leader>l <C-W><C-L>

" Close the current buffer and move to the previous one
" This closes the buffer but keeps the window open
nmap <leader>q :bp <BAR> bd #<CR>

"quick saving
nnoremap <Leader>w :w <BAR> :noh<CR>

"saving the file as sudo
noremap <Leader>W :w !sudo tee % > /dev/null

"enable manual code folding
set foldenable
set foldmethod=manual

"disable auto comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"hotkey to close quickfix and location list windows
nmap <leader>r :ccl <CR> <bar> :lclose <CR>

"hotkey to open location list window
nmap <leader>e :lopen <CR>

"hotkey to open a new tab
nmap <leader>t :tabnew <CR>

"hotkey to close a tab
nmap <leader>c :tabclose <CR>

"remove pipe characters in vertical split gutter
set fillchars+=vert:\ 

"copy current buffer directory to + register
nmap <leader>p :let @+ = expand("%") <CR>

"auto load external changes into buffers
set autoread

"------------------------------------------------
" Plugins
" -----------------------------------------------

"------------------ ctrl-p ------------------
let g:ctrlp_map = '<c-o>'
let g:ctrlp_cmd = 'CtrlP'

if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  " let g:ctrlp_use_caching = 0
endif

"use py-matcher plugin for matching
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

"------------------ NERDTree -----------------------
"toggle
map <leader>n :NERDTreeToggle<CR>

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
" Set font and theme
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'

" Always display status line
set laststatus=2

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Dont show tabs in main buffer list
let g:airline#extensions#tabline#show_tabs = 0

" Enable airline index mode which enables switching to 
" buffers by index number
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>. <Plug>AirlineSelectPrevTab
nmap <leader>, <Plug>AirlineSelectNextTab

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'"

"------------------ Go-vim ----------------------------
"enable highlighting
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_trailing_whitespace_error=0

"fmt fail silent
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "gofmt"

"proper tab settings for go
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 

"Run commands such as go run for the current file with <leader>r or go test for the current package with <leader>t. 
"Display beautifully annotated source code to see which functions are covered with <leader>c.
au FileType go nmap <leader>y <Plug>(go-run)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>T <Plug>(go-test-func)
au FileType go nmap <leader>c :GoCoverageToggle<CR>

"Open godoc in a browser
au FileType go nmap <leader>gb <Plug>(go-doc-browser)

"----------------- Ack.vim ----------------------------
if executable('ag')
  " Use ag over grep
  let g:ackprg = 'ag --vimgrep'
endif

" Search for word under cursor
nmap <leader>f :Ack!<CR>

"----------------- Ale  --------------------------

" Set the linters to use
let g:ale_linters = {
\   'go': ['go build', 'golint', 'go vet'],
\   'ruby': ['ruby', 'rubocop'],
\   'eruby': [],
\   'javascript': ['standard'],
\}

" Set error msg format
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warn'
let g:ale_echo_msg_format = '%severity%: %s [%linter%]'

" Disable auto linting
let g:ale_lint_on_text_changed = 'never'

"---------------- Neocomplete -------------------------
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1

" Use smartcase.
let g:neocomplete#enable_smart_case = 1

" Ignore case when finding matches
let g:neocomplete#enable_ignore_case = 1

" enable fuzzy completion
let g:neocomplete#enable_fuzzy_completion = 1

" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" AutoComplPop like behavior.
let g:neocomplete#enable_auto_select = 1

" disable preview window
set completeopt-=preview

" Tab to scroll throgh options, shift-tab to scroll backwards
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-Tab>  pumvisible() ? "\<C-p>" : "\<TAB>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Only enable completion for the file types that i want
" autocmd FileType ruby NeoCompleteLock
" autocmd FileType javascript NeoCompleteLock
" autocmd FileType go NeoCompleteUnlock
" autocmd FileType java NeoCompleteUnlock

" disable member and buffer sources
call neocomplete#custom#source('member', 'disabled', 1)
call neocomplete#custom#source('buffer', 'disabled', 1)



"---------------------- UltiSnip ---------------------------

" Trigger configuration.  TODO: make this a better hotkey
let g:UltiSnipsExpandTrigger="<c-z>"
let g:UltiSnipsJumpForwardTrigger="<c-z>"

" Set up where our custom snippet directory is
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
