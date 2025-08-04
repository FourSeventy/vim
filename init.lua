
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



-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

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

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- Here is where you install your plugins.
require('lazy').setup({
  -- nvim-lspconfig
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    -- Use the `dependencies` key to specify the dependencies of a particular plugin
    dependencies = {
      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
      -- Signature autocompletes
      {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {
          hint_enable = false, -- virtual hint enable
          hint_prefix = "",  -- Panda for parameter
        },
        config = function(_, opts) require'lsp_signature'.setup(opts) end
      }
    },
    config = function()
      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
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

      -- lsp diagnostic settings
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
          virtual_text = false,
          signs = true,
          update_in_insert = false,
        }
      )

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())


      -- set up golang lsp server
      require('lspconfig').gopls.setup{
       capabilities = capabilities
      }

      --set up lsp for vue and js/ts
      -- require('lspconfig').volar.setup {
      --   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      --   init_options = {
      --     typescript = {
      --         tsdk = '/usr/local/lib/node_modules/typescript/lib'
      --     },
      --     vue = {
      --       hybridMode = false,
      --     },
      --   },
      --  capabilities = capabilities
      -- }

      --format on save
      vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = buffer,
          callback = function()
              vim.lsp.buf.format { async = false }
          end
      })

    end,
  },

   -- nvim-cmp Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      --REQUIRED - Snippet Engine & its associated nvim-cmp source
      {
        'hrsh7th/vim-vsnip',
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          'rafamadriz/friendly-snippets',
        },
      },
      'hrsh7th/cmp-vsnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-buffer',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      cmp.setup {
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        completion = { completeopt = 'menu,menuone,noinsert,noselect' },
        preselect = cmp.PreselectMode.None,

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {

          -- Select next item
          ['<C-f>'] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}),
          -- Select previous item
          ['<C-b>'] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}),
          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-a>'] = cmp.mapping.confirm({ select = true }), --Set `select` to `false` to only confirm explicitly selected items.
          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<C-e>'] = cmp.mapping.abort(),

          -- Scroll the documentation window [b]ack / [f]orward
          -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
          { name = 'calc' },
          { name = 'buffer' },
        },
       enabled = function()
          -- disable completion in comments
          local context = require 'cmp.config.context'
          if vim.api.nvim_get_mode().mode == 'c' then -- keep command mode completion enabled when cursor is in a comment
            return true
          else
            return not context.in_treesitter_capture("comment") 
              and not context.in_syntax_group("Comment")
             -- Add this line to disable for .txt files
              and vim.bo.filetype ~= 'text'
          end
        end
      }
    end,
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      --providers better % to jump between matching characters
      "andymass/vim-matchup",
      --providers better commenting context based on treesitter
      "JoosepAlviste/nvim-ts-context-commentstring",
      --inserts end in function blocks in ruby
      "RRethy/nvim-treesitter-endwise",
    },
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { "go", "gomod", "gosum", "ruby", "html", "vue", "sql", "yaml", "javascript", "vim", "lua", "json", "embedded_template" },
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,
      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = false,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      matchup = {
        enable = true,              -- mandatory, false will disable the whole extension
        --disable = { "c"},  -- optional, list of language that will be disabled
        -- [options]
      },
      endwise = {
          enable = true,
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },

  --nvim-telescope Fuzzy Finder
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- telescope-ui-select exists to use telescope's UI in more places outside of the :Telescope command.
      -- specifically, it overrides :h vim.ui.select calls. so if you use a different plugin or a builtin command that uses vim.ui.select
      --(like selecting a code action) then it will use telescope.
      { 'nvim-telescope/telescope-ui-select.nvim' },
      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
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
    end,
  },

  -- nvim-ufo code folding
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
    },
    config = function()
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
          open_fold_hl_timeout = 0,
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
    end,
  },

  -- Neo-tree is a Neovim plugin to browse the file system
  -- https://github.com/nvim-neo-tree/neo-tree.nvim
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
      { '<leader>n', ':Neotree toggle<CR>', desc = 'NeoTree toggle', silent = true },
    },
    opts = {
      filesystem = {
        window = {
          mappings = {
            ['\\'] = 'close_window',
          },
        },
      },
    },
  },

  -- nvim-dap Debugger utility
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- Creates a beautiful debugger UI
      'rcarriga/nvim-dap-ui',
      -- Required dependency for nvim-dap-ui
      'nvim-neotest/nvim-nio',
      -- Add your own debuggers here
      'leoluz/nvim-dap-go',
    },
    keys = function(_, keys)
      local dap = require 'dap'
      local dapui = require 'dapui'
      return {
        -- Basic debugging keymaps, feel free to change to your liking!
        { '<leader>dc', dap.continue, desc = 'Debug: Start/Continue' },
        { '<leader>db', dap.toggle_breakpoint, desc = 'Debug: Toggle Breakpoint' },
        { '<leader>dr', dap.run_to_cursor, desc = 'Debug: Run to Cursor' },
        { '<leader>d1', dap.step_into, desc = 'Debug: Step Into' },
        { '<leader>d2', dap.step_over, desc = 'Debug: Step Over' },
        { '<leader>d3', dap.step_out, desc = 'Debug: Step Out' },
        {
          '<leader>dB',
          function()
            dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
          end,
          desc = 'Debug: Set Breakpoint',
        },
        -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
        { '<leader>ds', dapui.toggle, desc = 'Debug: See last session result.' },
        unpack(keys),
      }
    end,
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'
      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      dapui.setup {
        -- Set icons to characters that are more likely to work in every terminal.
        --    Feel free to remove or use ones that you like more! :)
        --    Don't feel like these are good choices.
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
      }

      dap.listeners.after.event_initialized['dapui_config'] = function()
        vim.cmd('Neotree close')
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      -- Install golang specific config
      require('dap-go').setup {
        dap_configurations = {
            {
              type = "go",
              name = "[Nested] Debug Test (go.mod)",
              request = "launch",
              mode = "test",
              program = "${fileDirname}",

              -- Because we are in a subdirevtory, this is needed.
              dlvCwd = "${fileDirname}",
            },
        }
      }
    end,
  },

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
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

      -- Document existing key chains
      spec = {
        { '<leader>f', group = '[F]ind', mode = { 'n' } },
        { '<leader>r', group = '[R]efactor' },
        { '<leader>d', group = '[D]ebug' },
        { '<leader>g', group = '[G]it' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>e', group = '[E]rror' },
      },
    },
  },

  -- installing some colorschemes
  { 'folke/tokyonight.nvim' },
  { "ellisonleao/gruvbox.nvim" },
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'rebelot/kanagawa.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      vim.cmd.colorscheme 'kanagawa'

      -- You can configure highlights by doing something like:
      -- vim.cmd.hi 'Comment gui=none'
    end,
  },

  -- A super powerful autopair plugin for Neovim that supports multiple characters.
  -- Auto inserts matching open and close parens and quotes, etc.
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {}
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },

  -- Collection of various small independent plugins/modules
  { 
    'echasnovski/mini.nvim',
    config = function()
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
    end,
  },
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  --A better user experience for interacting with and manipulating Vim marks
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  --lazygit inside of vim
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
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
      end,
    },
  },

}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
