## Setup
1. Install neovim https://github.com/neovim/neovim/wiki/Installing-Neovim
2. Clone vim repo to ~/.vim `git clone git@github.com:FourSeventy/vim.git .vim`
3. Initialize vim submodules `cd ~/.vim/pack/plugins/start; git submodule init; git submodule update`
4. Symlink init.vim `cd ~/.config/nvim; ln -s ~/.vim/init.vim init.vim`
6. Install the font in the ./fonts directory, and configure your terminal to use it.
7. Install silver searcher `brew install the_silver_searcher`
8. Install go binaries `:GoInstallBinaries` 
9. Install gopls language server `GO111MODULE=on go get golang.org/x/tools/gopls@latest`
10. Install fzy `brew install fzy` 

## Plugin Description

### lsp
https://github.com/neovim/nvim-lspconfig

with neovim 0.5 LSP(language server protocol) is built in. The plugin nvim-lspconfig comes with config that
makes it easy to connect the LSP to language servers out of the box. Our autocompletion uses the built in lsp.
Ale should use the buit in lsp but I don't have that set up correctly yet.

### nvim-compe
https://github.com/hrsh7th/nvim-compe

nvim-compe handles autocompletion and snippets. It uses the neovim LSP to get completions.


### ale
https://github.com/dense-analysis/ale


ale handles syntax checking and linting. It also autocorrects and formats.

### vim-vsnip && friendly-snippets
https://github.com/hrsh7th/vim-vsnip

Snippet functionality



### Add a plugin
`
cd pack/plugins/start/
git submodule add <git repo>
`

### Update plugins
`git submodule update --recursive --remote`

### Remove a plugin
```
git submodule deinit vim/pack/shapeshed/start/vim-airline
git rm vim/pack/shapeshed/start/vim-airline
rm -Rf .git/modules/vim/pack/shapeshed/start/vim-airline
```
