set nocompatible				" be iMproved, required

" Plugin list {{{
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'fatih/vim-go', { 'tag': '*', 'do': ':GoUpdateBinaries' }
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-line'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'christoomey/vim-system-copy'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'flazz/vim-colorschemes'
Plug 'Yggdroot/indentLine'
Plug 'w0rp/ale'
Plug 'rust-lang/rust.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'ayu-theme/ayu-vim'
" Plug 'dylanaraps/wal.vim'
call plug#end()
" }}}

set termguicolors				" enable true color in vim
set cursorline					" highlight current line
set list lcs=tab:\|\ 			" highlight tabs in tab indented files
set background=dark     " enable dark mode
set wildmenu            " enable better(visual) autocomplete for commands
set showcmd             " show the current command

" gitgutter configurations
let g:gitgutter_override_sign_column_highlight = 0

" gruvbox configuration
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_sign_column = 'bg1'
let g:gruvbox_number_column = 'bg0'
let g:gruvbox_vert_split = 'bg1'
let ayucolor="dark"
colorscheme ayu
" colorscheme gruvbox
" colorscheme wal

" airline configurations
let g:airline_powerline_fonts = 1

filetype plugin indent on
set laststatus=2				" always show status line
set noshowmode					" hiding the default display of mode
set tabstop=2					" setting number of spaces in tab to 2 2 
set expandtab					" use 2 space when tab is pressed
set backspace=eol,start  "enable deleting indents, end of line, and text before previous inserts
set shiftwidth=2				" use 2 space when indenting with >
set incsearch					" enable incremental search
set hlsearch					" enable search highlighting
set number						" enable line number
set relativenumber				" enable relative numbering
set encoding=utf-8				" set encoding to utf-8

autocmd CompleteDone * pclose " automatically close the preview window

" custom mappings
nnoremap <CR> G					" mapping enter to goto line
noremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-p> :FZF<CR>
nnoremap <C-j> <PageDown>
nnoremap <C-k> <PageUp>

" vim-go configurations
let g:go_fmt_command = "goimports"

" NERDTree related stuffs

" close vim if only nerdtree remains
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" open NERDTree when opening a folder
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_layout = { 'down': '~20%' }

" rust related configurations
let g:rustfmt_autosave = 1

set conceallevel=0
