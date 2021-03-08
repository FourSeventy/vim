## Setup
1. Install neovim `brew install neovim/neovim/neovim`
2. Clone vim repo to ~/.vim `git clone git@github.com:FourSeventy/vim.git .vim`
3. Initialize vim submodules `cd ~/.vim/bundle; git submodule init; git submodule update`
4. Symlink init.vim `cd ~/.config/nvim; ln -s ~/.vim/init.vim init.vim`
5. Symlink cocsettings `cd ~/.config/nvim; ln -s ~/.vim/coc-settings.json coc-settings.json`
6. Install the font in the ./fonts directory, and configure your terminal to use it.
7. Install silver searcher `brew install the_silver_searcher`
8. Install python3 `brew install python3` (python needed for coc and ultisnips)
9. Install the neovim python module `sudo pip3 install --upgrade --force-reinstall neovim`
10. Install go binaries `:GoInstallBinaries` 
11. Install gopls `GO111MODULE=on go get golang.org/x/tools/gopls@latest`
12. Install fzy `brew install fzy` 
13. Use yarn to build coc `cd /.vim/bundle/coc.nvim; yarn install --frozen-lockfile`
14. Install coc snippets `:CocInstall coc-snippets`

### Update submodules
`git submodule update --recursive --remote`


### coc-settings.json
this is a configuration file for the coc completion engine. It helps configure
what language servers to use
