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

"enable code folding
set foldenable
set foldmethod=manual

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
nnoremap <leader>d :call ToggleDiff()<CR>

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
  },
  context_commentstring = {
    enable = true
  }
}
EOF


"----------------------- vsnip  ----------------------
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.vue = ['html']
let g:vsnip_filetypes.ruby = ['rails']


"----------------------- nvim compe ----------------------
set completeopt=menuone,noselect

let g:compe = {}
let g:compe.enabled = v:true
" Disable compe for text files or markdown files
au! Filetype text call compe#setup({'enabled': v:false})
au! Filetype markdown call compe#setup({'enabled': v:false})
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

" Auto-format *.go (go) files prior to saving them
autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.rb lua vim.lsp.buf.formatting_sync(nil, 1000)

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


-- ruby lsp setup
require'lspconfig'.solargraph.setup{
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
  end
}

EOF


"------------------- golang autotest runner ----------------------

lua << EOF

local test_function_query_string = [[
(
 (function_declaration
  name: (identifier) @name
  parameters:
    (parameter_list
     (parameter_declaration
      name: (identifier)
      type: (pointer_type
          (qualified_type
           package: (package_identifier) @_package_name
           name: (type_identifier) @_type_name)))))

 (#eq? @_package_name "testing")
 (#eq? @_type_name "T")
 (#eq? @name "%s")
)
]]

local find_test_line = function(go_bufnr, name)
  local formatted = string.format(test_function_query_string, name)
  local query = vim.treesitter.parse_query("go", formatted)
  local parser = vim.treesitter.get_parser(go_bufnr, "go", {})
  local tree = parser:parse()[1]
  local root = tree:root()

  for id, node in query:iter_captures(root, go_bufnr, 0, -1) do
    if id == 1 then
      local range = { node:range() }
      return range[1]
    end
  end
end

local make_key = function(entry)
  assert(entry.Package, "Must have Package:" .. vim.inspect(entry))
  assert(entry.Test, "Must have Test:" .. vim.inspect(entry))
  return string.format("%s/%s", entry.Package, entry.Test)
end

local add_golang_test = function(state, entry)
  state.tests[make_key(entry)] = {
    name = entry.Test,
    line = find_test_line(state.bufnr, entry.Test),
    output = {},
  }
end

local add_golang_output = function(state, entry)
  assert(state.tests, vim.inspect(state))
  table.insert(state.tests[make_key(entry)].output, vim.trim(entry.Output))
end

local mark_success = function(state, entry)
  state.tests[make_key(entry)].success = entry.Action == "pass"
end

local ns = vim.api.nvim_create_namespace "live-tests"
local group = vim.api.nvim_create_augroup("teej-automagic", { clear = true })

local clear_go_testing = function(bufnr)
  -- clear highlights and marks from buffer
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  --clear diagnostics
  vim.diagnostic.set(ns, bufnr, {}, {})
end

local run_go_testing = function(bufnr, command)
  local state = {
    bufnr = bufnr,
    tests = {},
  }

  --clear old highlights and marks from buffer
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  --start background job that actually runs the tests
  vim.fn.jobstart(command, {
    stdout_buffered = true,
    -- when we get data back from the test, we'll call this function to parse it
    on_stdout = function(_, data)

      -- if we didnt get any data, then we're done
      if not data then
        return
      end

      -- parse the data
      for _, line in ipairs(data) do
        local decoded = vim.json.decode(line)
        if decoded.Action == "run" then
          add_golang_test(state, decoded)
        elseif decoded.Action == "output" then
          if not decoded.Test then
            return
          end

          add_golang_output(state, decoded)
        elseif decoded.Action == "pass" or decoded.Action == "fail" then
          mark_success(state, decoded)

          local test = state.tests[make_key(decoded)]
          if test.success and test.line then
            local text = { "✓ Pass" }
            vim.api.nvim_buf_set_extmark(bufnr, ns, test.line, 0, {
              virt_text = { text },
            })
          end
        elseif decoded.Action == "pause" or decoded.Action == "cont" then
          -- Do nothing
        else
          error("Failed to handle" .. vim.inspect(data))
        end
      end
    end,

    --once all the tests are done running, add to diagnostics the ones that failed
    on_exit = function()
      local failed = {}
      for _, test in pairs(state.tests) do
        if test.line then
          if not test.success then
            table.insert(failed, {
              bufnr = bufnr,
              lnum = test.line,
              col = 0,
              severity = vim.diagnostic.severity.ERROR,
              source = "go-test",
              message = "Test Failed",
              user_data = {},
            })
          end
        end
      end

      vim.diagnostic.set(ns, bufnr, failed, {})
    end,
  })

  --create a user command to see the output of the test
  vim.api.nvim_buf_create_user_command(bufnr, "GoTestDiag", function()
      local line = vim.fn.line "." - 1
      for _, test in pairs(state.tests) do
        if test.line == line then
          vim.cmd.new()
          vim.api.nvim_buf_set_lines(vim.api.nvim_get_current_buf(), 0, -1, false, test.output)
        end
      end
    end, {})
end

--main user command that will run testing
vim.api.nvim_create_user_command("GoTest", function()
    if vim.fn.expand("%:e") ~= "go" then
      print("Not a go file")
      return
    end

    run_go_testing(vim.api.nvim_get_current_buf(), "(cd " .. vim.fn.expand("%:p:h") .. " && go test ./... -v -json)" )
end, {})

--user command that will clear testing results
vim.api.nvim_create_user_command("GoTestClear", function()
    clear_go_testing(vim.api.nvim_get_current_buf())
end, {})

--keymaps
vim.api.nvim_set_keymap('n', '<leader>tg', '<cmd>GoTest<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tc', '<cmd>GoTestClear<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>td', '<cmd>GoTestDiag<CR>', { noremap = true, silent = true })

EOF


