
-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = false

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- don't wrap lines
vim.opt.wrap = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Use spaces instead of tabs
vim.opt.expandtab = true
-- Be smart when using tabs
vim.opt.smarttab = true
-- 2 spaces per indent
vim.opt.shiftwidth = 2
-- 1 tab == 2 spaces
vim.opt.tabstop = 2
vim.opt.shiftround = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = false
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = false

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlighting of words when searching
vim.opt.hlsearch = true

-- Allows us to switch buffers without saving them
vim.opt.hidden = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set jk to esc 
vim.keymap.set('i', 'jk', '<ESC>', { noremap = true})

-- quick saving
vim.keymap.set('n', '<Leader>w', ':w<BAR>:noh<CR>', { noremap = true, silent = true })

-- close the current buffer and move to the previous one
vim.keymap.set('n', '<Leader>q', ':bp<BAR>bd#<CR>', { noremap = true, silent = true })

--json formatting
vim.keymap.set('n', '<leader>y', ':%!python -m json.tool <CR>', { noremap = true, silent = true })

--copy current buffer directory to + register
--TODO: fix
vim.keymap.set('n', '<leader>p', ':let @+ = expand("%")<CR>', { noremap = true, silent = true })

--hotkey to open a new tab
vim.keymap.set('n', '<C-W>t', ':tabnew<CR>', { noremap = true, silent = true })

--hotkey to close a tab
vim.keymap.set('n', '<C-W>c', ':tabclose<CR>', { noremap = true, silent = true })

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<leader>h', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<leader>l', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<leader>j', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<leader>k', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')


-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})






------------------------------------------------------
------------------- Plugins --------------------------
------------------------------------------------------




--------------- LSP -----------------------
vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/ray-x/lsp_signature.nvim" },
})
require'lsp_signature'.setup({ hint_enable = false, hint_prefix = "", })

-- LSP servers and clients are able to communicate to each other what features they support.
--  By default, Neovim doesn't support everything that is in the LSP specification.
--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = vim.tbl_deep_extend('force', capabilities)

-- set up golang lsp server
vim.lsp.config("gopls",{
  capabilities = capabilities
})
vim.lsp.enable({"gopls"})

--format on save
vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = buffer,
    callback = function()
        vim.lsp.buf.format { async = false }
    end
})


vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-t>.
    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

    -- Find references for the word under your cursor.
    map('ge', require('telescope.builtin').lsp_references, '[G]oto r[E]ferences')

    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    map('gy', require('telescope.builtin').lsp_type_definitions, '[G]oto t[Y]pe')

    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    map('<leader>fy', require('telescope.builtin').lsp_document_symbols, '[F]ind s[Y]mbols')

    -- Fuzzy find all the symbols in your current workspace.
    --  Similar to document symbols, except searches over your entire project.
    map('<leader>fY', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[F]ind s[Y]mbols')

    --jump to next or previous diagnostic message
    vim.keymap.set("n","<leader>ej", vim.diagnostic.goto_next, {buffer=0})
    vim.keymap.set("n","<leader>ek", vim.diagnostic.goto_prev, {buffer=0})

    -- Rename the variable under your cursor.
    --  Most Language Servers support renaming across files, etc.
    map('<leader>rr', vim.lsp.buf.rename, '[R]efactor [R]ename')

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    map('<leader>ra', vim.lsp.buf.code_action, '[R]efactor [A]ction', { 'n' })
  end,
})



--------- autocomplete --------------
-- We are using built-in autocomplete
vim.opt.completeopt = "menu,menuone,noselect,popup" -- Ensures the menu appears even for a single match and uses the native popup window.
vim.o.autocomplete = true -- Enables the overall completion feature.
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_completion", { clear = true }),
  callback = function(args)
    local client_id = args.data.client_id
    if not client_id then
      return
    end

    local client = vim.lsp.get_client_by_id(client_id)
    if client and client:supports_method("textDocument/completion") then
      -- Enable native LSP completion for this client + buffer
      vim.lsp.completion.enable(true, client_id, args.buf, {
        autotrigger = true,   -- auto-show menu as you type (recommended)
        -- You can also set { autotrigger = false } and trigger manually with <C-x><C-o>
      })
    end
  end,
})


----------  Treesitter -----------------
vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = 'main' },
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = { "go", "gomod", "gosum", "ruby", "html", "vue", "sql", "yaml", "javascript", "vim", "lua", "json", "embedded_template" },
  callback = function()
    -- syntax highlighting, provided by Neovim
    vim.treesitter.start()
    -- -- folds, provided by Neovim
    -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- vim.wo.foldmethod = 'expr'
    -- indentation, provided by nvim-treesitter
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})


----------- Telescope -------------------
vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim"},
  { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim"},
})
-- Telescope is a fuzzy finder that comes with a lot of different things that
-- it can fuzzy find! It's more than just a "file finder", it can search
-- many different aspects of Neovim, your workspace, LSP, and more!
--
-- The easiest way to use Telescope, is to start by doing something like:
--  :Telescope help_tags
--
-- After running this command, a window will open up and you're able to
-- type in the prompt window. You'll see a list of `help_tags` options and
-- a corresponding preview of the help.
--
-- Two important keymaps to use while in Telescope are:
--  - Insert mode: <c-/>
--  - Normal mode: ?
--
-- This opens a window that shows you all of the keymaps for the current
-- Telescope picker. This is really useful to discover what Telescope can
-- do as well as how to actually do it!

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  -- You can put your default mappings / updates / etc. in here
  --  All the info you're looking for is in `:help telescope.setup()`
  --
  defaults = {
    -- ignore folders we don't want to search in
    file_ignore_patterns = {"node_modules", "vendor"},
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      }
    },
  },
  -- pickers = {}
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
  },
}

-- Enable Telescope extensions if they are installed
pcall(require('telescope').load_extension, 'ui-select')

-- See `:help telescope.builtin`
local builtin = require 'telescope.builtin'
--Search for files
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
--Grep for strings in files
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
--Grep for string under cursor
vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = '[F]ind current [S]tring' })
-- search git commits
vim.keymap.set('n', '<leader>fc', builtin.git_commits, { desc = '[F]ind [C]ommits' })
--Search diagnostic errors
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
--Search buffers
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]find [H]elp' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]find [K]eymaps' })
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = '[F]find Recent Files ("." for repeat)' })
--<C-q> will dump search results into quickfix


--------- neo tree -------------
-- Sidebar file nav
vim.pack.add({
  { src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
})
vim.keymap.set("n", "<leader>n", ":Neotree toggle<CR>", { silent = true, desc = "Toggle Neotree" })


---------- color scheme ------------
vim.pack.add({
  { src = "https://github.com/rebelot/kanagawa.nvim" },
})
vim.cmd.colorscheme 'kanagawa'


------------ misc plugins ---------
-- which key 

vim.pack.add({
  { src = "https://github.com/folke/which-key.nvim" },
})
-- Configure it
require("which-key").setup({
  icons = {
    mappings = vim.g.have_nerd_font,
    keys = vim.g.have_nerd_font and {} or {
      Up = '<Up> ',
      Down = '<Down> ',
      Left = '<Left> ',
      Right = '<Right> ',
      C = '<C-…> ',
      M = '<M-…> ',
      D = '<D-…> ',
      S = '<S-…> ',
      CR = '<CR> ',
      Esc = '<Esc> ',
      ScrollWheelDown = '<ScrollWheelDown> ',
      ScrollWheelUp = '<ScrollWheelUp> ',
      NL = '<NL> ',
      BS = '<BS> ',
      Space = '<Space> ',
      Tab = '<Tab> ',
      F1 = '<F1>',
      F2 = '<F2>',
      F3 = '<F3>',
      F4 = '<F4>',
      F5 = '<F5>',
      F6 = '<F6>',
      F7 = '<F7>',
      F8 = '<F8>',
      F9 = '<F9>',
      F10 = '<F10>',
      F11 = '<F11>',
      F12 = '<F12>',
    },
  },
  spec = {
    { '<leader>f', group = '[F]ind', mode = { 'n' } },
    { '<leader>r', group = '[R]efactor' },
    { '<leader>d', group = '[D]ebug' },
    { '<leader>g', group = '[G]it' },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>e', group = '[E]rror' },
  },
})



-- A super powerful autopair plugin for Neovim that supports multiple characters.
-- Auto inserts matching open and close parens and quotes, etc.
vim.pack.add({
  { src = "https://github.com/windwp/nvim-autopairs" },
})
require("nvim-autopairs").setup {}


-- Highlight todo, notes, etc in comments
vim.pack.add({
  { src = "https://github.com/folke/todo-comments.nvim" },
})

--A better user experience for interacting with and manipulating Vim marks
vim.pack.add({
  { src = "https://github.com/chentoast/marks.nvim" },
})
require'marks'.setup {}

-- Collection of various small independent plugins/modules
vim.pack.add({
  { src = "https://github.com/echasnovski/mini.nvim" },
})
-- Better Around/Inside textobjects
--
-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
require('mini.ai').setup { n_lines = 500 }

-- Add/delete/replace surroundings (brackets, quotes, etc.)
--
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
require('mini.surround').setup()

--replace with register and other stuff
require('mini.operators').setup()

--commenting
require('mini.comment').setup()

-- Simple and easy statusline.
--  You could remove this setup call if you don't like it,
--  and try some other statusline plugin
local statusline = require 'mini.statusline'
-- set use_icons to true if you have a Nerd Font
statusline.setup { use_icons = vim.g.have_nerd_font }

-- You can configure sections in the statusline by overriding their
-- default behavior. For example, here we set the section for
-- cursor location to LINE:COLUMN
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function()
  return '%2l:%-2v'
end

-- ... and there is more!
--  Check out: https://github.com/echasnovski/mini.nvim


vim.pack.add({
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
})
local gitsigns = require 'gitsigns'

local function map(mode, l, r, opts)
  opts = opts or {}
  opts.buffer = bufnr
  vim.keymap.set(mode, l, r, opts)
end

-- Navigation
map('n', ']c', function()
  if vim.wo.diff then
    vim.cmd.normal { ']c', bang = true }
  else
    gitsigns.nav_hunk 'next'
  end
end, { desc = 'Jump to next git [c]hange' })

map('n', '[c', function()
  if vim.wo.diff then
    vim.cmd.normal { '[c', bang = true }
  else
    gitsigns.nav_hunk 'prev'
  end
end, { desc = 'Jump to previous git [c]hange' })

-- Actions
-- visual mode
map('v', '<leader>gs', function()
  gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
end, { desc = 'stage git hunk' })
map('v', '<leader>gr', function()
  gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
end, { desc = 'reset git hunk' })
-- normal mode
map('n', '<leader>gs', gitsigns.stage_hunk, { desc = '[G]it [s]tage hunk' })
map('n', '<leader>gr', gitsigns.reset_hunk, { desc = '[G]it [r]eset hunk' })
map('n', '<leader>gS', gitsigns.stage_buffer, { desc = '[G]it [S]tage buffer' })
map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = '[G]it [u]ndo stage hunk' })
map('n', '<leader>gR', gitsigns.reset_buffer, { desc = '[G]it [R]eset buffer' })
map('n', '<leader>gp', gitsigns.preview_hunk, { desc = '[G]it [p]review hunk' })
map('n', '<leader>gb', gitsigns.blame_line, { desc = '[G]it [b]lame line' })
map('n', '<leader>gd', gitsigns.diffthis, { desc = '[G]it [d]iff against index' })
map('n', '<leader>gD', function()
  gitsigns.diffthis '@'
end, { desc = '[G]it [D]iff against last commit' })
-- Toggles
map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })





--lazygit inside of vim
vim.pack.add({
  { src = "https://github.com/kdheepak/lazygit.nvim" },
})
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { silent = true, desc = "LazyGit" })


-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
