set breakindent
set linebreak
set spell
set backspace=indent,eol,start
syntax on

set tabstop=2
set shiftwidth=2
set noexpandtab

set number
set relativenumber

set smartindent

set wildmenu
set foldmethod=syntax

set ruler

filetype plugin on
filetype indent on
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRuleComplete_pdf='mupdf $*.pdf &'

colorscheme onehalflight

autocmd BufNewFile,BufRead *.hs *.cabal set expandtab

execute pathogen#infect()

set guifont=Courier\ New
set guioptions-=T
