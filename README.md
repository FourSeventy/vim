## Setup:

### neovim
1. Install neovim `brew install neovim/neovim/neovim`
2. Clone vim repo to ~/.vim `git clone git@github.com:FourSeventy/vim.git .vim`
3. Initialize vim submodules `cd ~/.vim/bundle; git submodule init; git submodule update`
4. Symlink init.vim `cd ~/.config/nvim; ln -s ~/.vim/init.vim init.vim`
5. Install the font in the ./fonts directory, and configure your terminal to use it.
6. Install silver searcher `brew install the_silver_searcher`
7. Install python3 `brew install python3`
8. Install the neovim python module `sudo pip3 install --upgrade --force-reinstall neovim`
