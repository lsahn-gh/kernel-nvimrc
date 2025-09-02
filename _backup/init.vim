source ~/.config/nvim/basic.vim
source ~/.config/nvim/plugins.vim

" colorscheme vim-monokai-tasty
colorscheme monokai

set et
set shiftwidth=4
set nu

set colorcolumn=80
set cursorline

set list listchars=tab:\ \ ┊,trail:●,extends:…,precedes:…

if filereadable(".vimrc_local")
    so .vimrc_local
endif

" Keymaps
source ~/.config/nvim/keymaps.vim

