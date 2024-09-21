# Neovim Config
Config tested up to NVIM v0.10.1


## Setup
1. Install neovim https://github.com/neovim/neovim/blob/master/INSTALL.md
2. Clone vim repo to ~/.config/nvim `git clone git@github.com:FourSeventy/vim.git ~/.config/nvim`
3. Install the font in the ./fonts directory, and configure your terminal to use it.
4. Install binary dependencies
    1. ripgrep for telescope `sudo port install ripgrep`
    2. delve for debugging `go install github.com/go-delve/delve/cmd/dlv@latest`
5. Install treesitter parsers
```
:TSInstall go
:TSInstall gomod
:TSInstall gosum
:TSInstall ruby
:TSInstall html
:TSInstall vue
:TSInstall sql
:TSInstall yaml
:TSInstall javascript
:TSInstall vim
:TSInstall lua
```
6. Install language servers
    1. Install gopls language server `go install golang.org/x/tools/gopls@latest`
    2. Official vue/language-server for vue/javascript 
    ```
    npm install -g @vue/language-server
    npm install -g @vue/typescript-plugin typescript
    ```


## Main Plugins

### lazy.nvim
https://github.com/folke/lazy.nvim
https://lazy.folke.io/

Plugin manager

### nvim-lspconfig
https://github.com/neovim/nvim-lspconfig

with neovim 0.5 LSP(language server protocol) is built in. The plugin nvim-lspconfig comes with config that
makes it easy to connect the LSP to language servers out of the box. Our autocompletion uses the built in lsp.
All of our diagnostics, linting and formatting are handled through lsps.

### nvim-cmp
https://github.com/hrsh7th/nvim-cmp

This plugin has some dependency plugins that it uses as completion sources. Namely:
* hrsh7th/cmp-nvim-lsp
* hrsh7th/cmp-buffer
* hrsh7th/cmp-vsnip
* hrsh7th/cmp-calc

### nvim-treesitter
https://github.com/nvim-treesitter/nvim-treesitter

Better syntax highlighting and folding
Add languages with :TSInstall
To keep definitions updated run :TSUpdate


### nvim-telescope
https://github.com/nvim-telescope/telescope.nvim

telescope.nvim is a highly extendable fuzzy finder. We used it for for searching and opening files, grepping
in files, grepping git commit history, searching through lsp diagnostic errors and more.

Good video about it: https://www.youtube.com/watch?v=guxLXcG1kzQ

### nvim-dap
https://github.com/mfussenegger/nvim-dap

nvim-dap is a Debug Adapter Protocol client implementation for neovim. Requires plugin adapters per language:
* nvim-dap-go https://github.com/leoluz/nvim-dap-go requires delve in path

### nvim-ufo
https://github.com/kevinhwang91/nvim-ufo

Code folding done right
