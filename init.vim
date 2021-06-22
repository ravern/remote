call plug#begin(stdpath('data') . '/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'Jorengarenar/vim-darkness'

call plug#end()

set syntax
filetype plugin on

set number
set relativenumber

colorscheme darkness