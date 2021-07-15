"---------------------------------------
" General
" --------------------------------------

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

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
nmap <Leader>= <C-w>=

" Close the current buffer and move to the previous one
" This closes the buffer but keeps the window open
nmap <leader>q :bp <BAR> bd #<CR>

"quick saving
nnoremap <Leader>w :w <BAR> :noh<CR>

"saving the file as sudo
noremap <Leader>W :w !sudo tee % > /dev/null

"json formatting
nmap <leader>y :%!python -m json.tool <CR>

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

"set diff mode to vertical
set diffopt+=vertical

"case insensitive search
set ic

"turn off command characters in bottom right
set noshowcmd

"------------------------------------------------
" Plugins
" -----------------------------------------------

"------------------ vim-picker ------------------
nmap <unique> <leader>o :PickerEdit<CR>



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
au FileType go nmap <leader>gr <Plug>(go-run)
au FileType go nmap <leader>gt <Plug>(go-test)
au FileType go nmap <leader>gT <Plug>(go-test-func)
au FileType go nmap <leader>gc :GoCoverageToggle<CR>
au FileType go nmap <leader>gi :GoInfo<CR>
au FileType go nmap <leader>gd :GoDoc<CR>
au FileType go nmap <leader>gf :GoDef<CR>

"Open godoc in a browser
au FileType go nmap <leader>gb <Plug>(go-doc-browser)

"use gopls for def and info
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

"code folding
au FileType go setlocal foldmethod=indent
" let g:go_fold_enable = ['block']
au FileType go setlocal foldnestmax=1
"makes saving the file not close folds https://github.com/fatih/vim-go/issues/502
let g:go_fmt_experimental = 1

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
\   'go': ['gopls', 'golint', 'go vet'],
\   'ruby': ['ruby', 'rubocop'],
\   'eruby': [],
\   'vue': ['eslint'],
\   'javascript': ['eslint']
\}

" Set the fixers 
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'vue': ['prettier'],
\   'ruby': ['rubocop'],
\}

" auto-fix on save
let g:ale_fix_on_save = 1

" Set error msg format
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warn'
let g:ale_echo_msg_format = '%severity%: %s [%linter%]'

" Disable auto linting
let g:ale_lint_on_text_changed = 'never'

" Error and warning signs.
let g:ale_sign_error = '>>'

" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1

"----------------------- nvim compe ----------------------
set completeopt=menuone,noselect

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.vsnip = v:true
" let g:compe.source.nvim_lua = v:true
" let g:compe.source.ultisnips = v:true
" let g:compe.source.luasnip = v:true
" let g:compe.source.emoji = v:true


" inoremap <silent><expr> <C-Space> compe#complete()
" inoremap <silent><expr> <C-a>      compe#confirm('<C-a>')
lua << EOF
vim.api.nvim_set_keymap("i", "<C-a>", "compe#confirm({ 'keys': '<C-a>', 'select': v:true })", { expr = true })
EOF
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

"set up tab and s-tab mappings (idk why it takes all the below code to do this)
lua << EOF
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn['vsnip#available'](1) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

"------------------------ lsp setup --------------------------
lua << EOF

-- set up lsp snippet capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
    }
  }

-- set up golang lsp server
local golang_setup = {
  -- configure lsp_signature
  on_attach = function(client, bufnr)
    cfg = {
      bind = true, -- This is mandatory, otherwise border config won't get registered.
                  -- If you want to hook lspsaga or other signature handler, pls set to false
      floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
      --fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
      hint_enable = false, -- virtual hint enable
      hint_prefix = "",  -- Panda for parameter
      hint_scheme = "String",
      use_lspsaga = false,  -- set to true if you want to use lspsaga popup
      hi_parameter = "Search", -- how your parameter will be highlight
      max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
                      -- to view the hiding contents
      max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
      handler_opts = {
        border = "none"   -- double, single, shadow, none
      },
      extra_trigger_chars = {} -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
    }
    require'lsp_signature'.on_attach(cfg)
  end,
  capabilities = capabilities
}

require'lspconfig'.gopls.setup(golang_setup)
EOF


