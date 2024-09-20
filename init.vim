"---------------------------------------
" General
" --------------------------------------

" some runtime path stuff
set runtimepath^=~/.vim
let &packpath = &runtimepath

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
let g:gruvbox_material_background = 'medium'
set background=dark
set termguicolors
let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_disable_italic_comment = 1
let g:gruvbox_material_enable_bold = 1
colorscheme gruvbox-material

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

"disable auto comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"hotkey to close quickfix and location list windows
nmap <leader>x :ccl <CR> <bar> :lclose <CR>

"hotkey to open a new tab
nnoremap <C-W>t :tabnew<CR>

"hotkey to close a tab
nnoremap <C-W>c :tabclose<CR>

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

"always show sign column
set signcolumn=yes

" Initialize a global variable for tracking diff mode status
let g:is_diff_mode_active = 0

function! ToggleDiff()
    " Check the global diff mode status
    if g:is_diff_mode_active
        " If diff mode is active, turn it off
        exe "windo diffoff"
        let g:is_diff_mode_active = 0
    else
        " If diff mode is not active, turn it on for all windows
        exe "windo diffthis"
        let g:is_diff_mode_active = 1
    endif
endfunction

" Map <leader>d to toggle diff mode
" nnoremap <leader>d :call ToggleDiff()<CR>

"------------------------------------------------
" Plugins
" -----------------------------------------------


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
let g:airline_theme = 'gruvbox_material'

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

" get rid of file encoding section
let g:airline_section_y = ''
let g:airline_skip_empty_sections = 1

" Customize the look of the line and column indicator
let g:airline_section_z = '%3p%% %3l/%L:%3v'

" Customize vim airline per filetype
" 'nerdtree'  - Hide nerdtree status line
" 'list'      - Only show file type plus current line number out of total
let g:airline_filetype_overrides = {
  \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', ''), '' ],
  \ 'list': [ '%y', '%l/%L'],
  \ }

"----------------------- Undo tree -----------------------
nnoremap <leader>U :UndotreeToggle<CR>


"----------------------- Telescope -----------------------
"search for files
nnoremap <leader>ff <cmd>Telescope find_files<cr>
"grep for strings in files
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
"grep for string under cursor
nnoremap <leader>fs <cmd>Telescope grep_string<cr>
"grep git commits
nnoremap <leader>fc <cmd>Telescope git_commits<cr>
"grep lsp errors
nnoremap <leader>fd <cmd>Telescope diagnostics<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fk <cmd>Telescope keymaps<cr>
"<C-q> will dump search results into quickfix

lua << EOF
require('telescope').setup{
  defaults = {
    prompt_prefix = "> ",
    file_ignore_patterns = {"node_modules", "vendor"}, -- ignore folders we don't want to search in
    mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          }
        }
    }
}
EOF

"----------------------- TreeSitter -----------------------
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "go", "gomod", "gosum", "ruby", "html", "vue", "sql", "yaml", "javascript", "vim", "lua" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  matchup = {
    enable = true,              -- mandatory, false will disable the whole extension
    --disable = { "c"},  -- optional, list of language that will be disabled
    -- [options]
  }
}
EOF


"----------------------- vsnip  ----------------------
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.vue = ['html']
let g:vsnip_filetypes.ruby = ['rails']



"----------------------- nvim-cmp ----------------------
lua <<EOF
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.select_prev_item(),
      ['<C-f>'] = cmp.mapping.select_next_item(),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-a>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'calc' },
    }, {
      { name = 'buffer' },
    }),
    enabled = function()
          -- disable completion in comments
          local context = require 'cmp.config.context'
          if vim.api.nvim_get_mode().mode == 'c' then -- keep command mode completion enabled when cursor is in a comment
            return true
          else
            return not context.in_treesitter_capture("comment") 
              and not context.in_syntax_group("Comment")
          end
        end
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- set up lsp for gopls
  require('lspconfig')['gopls'].setup {
    capabilities = capabilities
  }

  -- disable for txt files
  vim.api.nvim_create_autocmd("BufReadPre", {
    pattern = "*.txt",
    callback = function()
      cmp.setup.buffer {
        sources = cmp.config.sources({})
        }
    end,
  })
EOF

"------------------------ lsp setup --------------------------

" Auto-format *.go (go) files prior to saving them
autocmd BufWritePre *.go lua vim.lsp.buf.format()
autocmd BufWritePre *.vue lua vim.lsp.buf.format()
autocmd BufWritePre *.ts lua vim.lsp.buf.format()
autocmd BufWritePre *.js lua vim.lsp.buf.format()
autocmd BufWritePre *.rb lua vim.lsp.buf.format()

lua << EOF


-- lsp diagnostic settings
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)

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
require'lspconfig'.gopls.setup{
  on_attach = function(client, bufnr)
    -- configure lsp_signature
    require'lsp_signature'.on_attach{
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
  --show definition
  vim.keymap.set("n","K", vim.lsp.buf.hover, {buffer=0})
  --jump to definition
  vim.keymap.set("n","gd", vim.lsp.buf.definition, {buffer=0})
  --jump to type definition
  vim.keymap.set("n","gy", vim.lsp.buf.type_definition, {buffer=0})
  --jump to next or previous diagnostic message
  vim.keymap.set("n","<leader>dj", vim.diagnostic.goto_next, {buffer=0})
  vim.keymap.set("n","<leader>dk", vim.diagnostic.goto_prev, {buffer=0})
  --rename
  vim.keymap.set("n","<leader>rr", vim.lsp.buf.rename, {buffer=0})
  --code actions
  vim.keymap.set("n","<leader>ra", vim.lsp.buf.code_action, {buffer=0})
  end,
  capabilities = capabilities
}


--set up lsp for vue and js/ts
-- lspconfig.tsserver.setup {} 
local lspconfig = require('lspconfig')
lspconfig.volar.setup {
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  init_options = {
    typescript = {
        tsdk = '/usr/local/lib/node_modules/typescript/lib'
    },
    vue = {
      hybridMode = false,
    },
  },
  on_attach = function(client, bufnr)
  --show definition
  vim.keymap.set("n","K", vim.lsp.buf.hover, {buffer=0})
  --jump to definition
  vim.keymap.set("n","gd", vim.lsp.buf.definition, {buffer=0})
  --jump to type definition
  vim.keymap.set("n","gy", vim.lsp.buf.type_definition, {buffer=0})
  --jump to next or previous diagnostic message
  vim.keymap.set("n","<leader>dj", vim.diagnostic.goto_next, {buffer=0})
  vim.keymap.set("n","<leader>dk", vim.diagnostic.goto_prev, {buffer=0})
  --rename
  vim.keymap.set("n","<leader>rr", vim.lsp.buf.rename, {buffer=0})
  --code actions
  vim.keymap.set("n","<leader>ra", vim.lsp.buf.code_action, {buffer=0})
  end,
}

EOF

"------------------------ nvim-dap --------------------------
lua << EOF
local dap = require "dap"
local ui = require "dapui"
--golang setup
require('dapui').setup()
require('dap-go').setup({
    dap_configurations = {
        {
          type = "go",
          name = "[githooks] Debug Test (go.mod)",
          request = "launch",
          mode = "test",
          program = "${fileDirname}",

          -- Because we are in a subdirevtory, this is needed.
          dlvCwd = "${fileDirname}",
        },
    }
})

vim.keymap.set("n", "<leader>eb", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>er", dap.run_to_cursor)

-- Eval var under cursor
vim.keymap.set("n", "<leader>ek", function()
  require("dapui").eval(nil, { enter = true })
end)

vim.keymap.set("n", "<leader>ec", dap.continue)
vim.keymap.set("n", "<leader>e2", dap.step_into)
vim.keymap.set("n", "<leader>e3", dap.step_over)
vim.keymap.set("n", "<leader>e4", dap.step_out)
vim.keymap.set("n", "<leader>e5", dap.step_back)
vim.keymap.set("n", "<leader>e6", dap.restart)

dap.listeners.before.attach.dapui_config = function()
  ui.open()
end
dap.listeners.before.launch.dapui_config = function()
  ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  ui.close()
end


EOF


"--------------- nvim-autopairs -------------------
lua << EOF
require("nvim-autopairs").setup {}
EOF


"---------------- nvim-ufo ---------------------
lua << EOF
vim.o.foldcolumn = '0' -- '0' is not bad
--This sets the maximum fold level to display when you open a file.
--A high value like 99 means essentially all folds will be open by default.
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
-- This sets the starting fold level when you open a new buffer or window.
-- Again, a high value like 99 means all folds will start open.
vim.o.foldlevelstart = 99
-- This enables folding functionality in Neovim.
vim.o.foldenable = true


-- select preferred provider for each file type lsp, treesitter, indent
local ftMap = {
    go = 'treesitter',
    js = 'treesitter',
    vue = 'treesitter',
    rb = 'treesitter',
}
require('ufo').setup({
    open_fold_hl_timeout = 150,
    --fold types to be autoclosed
    --based on treesitter node types, use :InspectTree in a file to see what they are
    close_fold_kinds_for_ft = {
        default = {'imports'},
        go = {'import_declaration', 'function_declaration' },
        vue = {'method_definition'},
        ruby = {'method'}
    },
    provider_selector = function(bufnr, filetype, buftype)
        --uses configured provider from ftMap or falls back to treesitter
        return ftMap[filetype] or {'treesitter', 'indent'}
    end
})

vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)

EOF











