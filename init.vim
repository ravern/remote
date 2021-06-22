call plug#begin(stdpath('data') . '/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'fxn/vim-monochrome'

call plug#end()

set syntax off
filetype plugin on

set number
set relativenumber

colorscheme monochrome