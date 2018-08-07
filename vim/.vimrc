set nocompatible				" be iMproved, required
filetype off					" setting file type off for vundle. Enabled after vundle#end()

set rtp+=~/.vim/bundle/Vundle.vim	" set the runtime path to include Vundle and initialize
call vundle#begin()				" vundle begin
Plugin 'VundleVim/Vundle.vim'	" let Vundle manage Vundle, required
Plugin 'itchyny/lightline.vim'	" statusline plugin
Plugin 'jacoborus/tender.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/nerdtree'
Plugin 'flazz/vim-colorschemes'
call vundle#end()				" vundle end
filetype plugin indent on		" setting filetype, plugin, indent to on 

if (has("termguicolors"))
		set termguicolors
endif

syntax enable					" enable syntax highlighting 
colorscheme tender
let g:lightline = { 'colorscheme': 'tender' }	" set lighline theme inside lightline config

set laststatus=2				" always show status line
set noshowmode					" hiding the default display of mode
set number						" show line number
set tabstop=4					" setting number of spaces in tab to 4
set incsearch					" enable incremental search
set hlsearch					" enable search highlighting

nnoremap <CR> G					" mapping enter to goto line

