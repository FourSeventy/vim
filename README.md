## Setup
1. Install neovim https://github.com/neovim/neovim/wiki/Installing-Neovim
2. Clone vim repo to ~/.vim `git clone git@github.com:FourSeventy/vim.git .vim`
3. Initialize vim submodules `cd ~/.vim/pack/plugins/start; git submodule init; git submodule update`
4. Symlink init.vim `cd ~/.config/nvim; ln -s ~/.vim/init.vim init.vim`
5. Install the font in the ./fonts directory, and configure your terminal to use it.
6. Install gopls language server `go install golang.org/x/tools/gopls@latest`
7. Install ruby language server `gem install solargraph`
    a.) Generate YARD documentation  `solargraph bundle` (in root of project)
    b.) Enhance rails intellisense https://gist.github.com/castwide/28b349566a223dfb439a337aea29713e
8. Install ripgrep for telescope `sudo port install ripgrep`
9. Install treesitter parsers
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

## Plugin Description

### lsp
https://github.com/neovim/nvim-lspconfig

with neovim 0.5 LSP(language server protocol) is built in. The plugin nvim-lspconfig comes with config that
makes it easy to connect the LSP to language servers out of the box. Our autocompletion uses the built in lsp.
Ale should use the buit in lsp but I don't have that set up correctly yet.

### nvim-compe
https://github.com/hrsh7th/nvim-compe

nvim-compe handles autocompletion and snippets. It uses the neovim LSP to get completions.

### nvim-telescope
https://github.com/nvim-telescope/telescope.nvim

telescope.nvim is a highly extendable fuzzy finder. We used it for for searching and opening files, grepping
in files, grepping git commit history, searching through lsp diagnostic errors and more.

Good video about it: https://www.youtube.com/watch?v=guxLXcG1kzQ

Depencencies:
nvim-lua/plenary.nvim
BurntSushi/ripgrep --required for fast grepping

### vim-vsnip
https://github.com/hrsh7th/vim-vsnip

Snippet functionality

Depencencies: 
friendly-snippets

### nvim-treesitter
https://github.com/nvim-treesitter/nvim-treesitter

Better syntax highlighting and folding
Add languages with :TSInstall
To keep definitions updated run :TSUpdate

### vim-matchup
https://github.com/andymass/vim-matchup

vim-matchup extends vim's % to make it work much more accurately. It integrates with
treesitter to make sure it works well.




## Maintenance

### Add a plugin
`
cd pack/plugins/start/
git submodule add <git repo>
`

### Update plugins
`git submodule update --recursive --remote`

### Remove a plugin
```
git submodule deinit -f pack/plugins/start/vim-go
git rm pack/plugins/start/vim-go
rm -Rf .git/modules/pack/plugins/start/vim-go
```
