# Neovim Config
Config requires at least NVIM v0.12.0


## Setup
1. Install neovim https://github.com/neovim/neovim/blob/master/INSTALL.md
2. Clone vim repo to ~/.config/nvim `git clone git@github.com:FourSeventy/vim.git ~/.config/nvim`
3. Install the font in the ./fonts directory, and configure your terminal to use it.
4. Install binary dependencies
    1. ripgrep for telescope `sudo port install ripgrep`
    2. delve for debugging `go install github.com/go-delve/delve/cmd/dlv@latest`
    3. lazygit `https://github.com/jesseduffield/lazygit`
    4. tree-sitter cli `npm install -g tree-sitter-cli` 
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
:TSInstall embedded_template
```
6. Install language servers
    1. Install gopls language server `go install golang.org/x/tools/gopls@latest`

## Updating plugins

`:lua vim.pack.update()`




