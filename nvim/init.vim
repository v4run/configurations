" Basic Settings
set showmatch " show matching bracket for a brief moment
set autowrite " auto write buffer to file on some commands
set ignorecase " ignore case by default when searching
set nohlsearch " dont highlight all matches
set incsearch " highlight during search
set tabstop=4 " number of spaces for a tab
set softtabstop=0 " disable soft tab
set autoindent	" use previous line's indent
set shiftwidth=4 " number of spaces for autoindent
set number " add line number
set relativenumber " enable relative numbering
set wildmenu
set wildmode=longest:full,full " on first tab complete till longest common pattern, on next show a full menu
set cursorline " highlight the current line
" set cursorcolumn " highlight the current col
set ttyfast " indicates a fast terminal connection [removed in neovim]
set scrolloff=1 " keep N lines above or below when scrolling
set showcmd " show the partial command in last line. eg. for diw show di till w is pressed
set showmode " show the current mode
set splitright " put new window on right side on vsplit
set splitbelow " put new window below on split
set noerrorbells " disable bell on error
set termguicolors " enable 24-bit color
set noshowmode " don't show current mode [will be displayed in the status line]
set nowrap " don't wrap the line
" set colorcolumn=120 " add a vertical line at column

filetype plugin on " enable loading plugin files for the file type
filetype indent on " enable loading indent files for the file type

let mapleader = ' '

" Plugins
call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'joshdick/onedark.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

" Mappings
nnoremap <silent> <Leader><Space> :let @/ = ""<CR> " clear the last used search pattern

" Status line settings
let g:lightline = {
			\ 'colorscheme': 'one',
			\ 'active': {
				\ 'left': [ [ 'mode', 'paste'],
				\			[ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
				\ },
				\ 'component_function': {
					\ 	'gitbranch': 'FugitiveHead'
					\ },
					\ }

" Old status line [replaced by lightline]
function! SetStatusLine()
	set statusline=
	set statusline+=\ %f\ %m\ %y\ %R " show filename, modified flag, file type, readonly flag
	set statusline+=%= " separate left and right part
	set statusline+=%{FugitiveStatusline()} " git details (current branch)
	set statusline+=\ [%l,\ %c]\ %p%%\  " add line number, column number and percent
	set laststatus=2 " always show statusline
endfunction

" call SetStatusLine()

" Colorscheme
set background=dark
autocmd vimenter * ++nested colorscheme onedark

" Go settings
let g:go_metalinter_autosave = 0
let g:go_auto_type_info = 0
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = 'goimports'
let g:go_list_type = 'quickfix'
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'
let g:go_rename_command = 'gopls'
let g:go_metalinter_command = 'golangci-lint'


" Mappings
nmap <silent> <Leader>a :cclose<CR>:lclose<CR>
nmap <silent> <C-j> :cnext<CR>
nmap <silent> <C-k> :cprev<CR>
nmap <silent> <Leader>z :set wrap!<CR>

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" go to next match and move current line to center
nnoremap n nzzzv
" go to prev match and move current line to center
nnoremap N Nzzzv

" move selection up and down using J and K. reselect reindent and select again
" in visual mode
vnoremap J :move '>+1<CR>gv=gv
vnoremap K :move '<-2<CR>gv=gv

" move line up and down using J and K. reselect reindent and select again
" in visual mode
nnoremap <leader>j :move .+1<CR>==
nnoremap <leader>k :move .-2<CR>==

" delete the selected content to void (register - _) and paste before
vnoremap <Leader>d "_d
vnoremap <Leader>p "_dP

" Fuzzy search files in current directory
nmap <C-p> :Files<CR>

" Execute :Git command
nmap <Leader>gs :G<CR>


" Go custom mappings
function! GoCustomMappings()
	nmap <buffer> gi :GoImplements<CR>
	nmap <buffer> gc :GoCallers<CR>
	nmap <buffer> <Leader>x <Plug>(go-run)
	nmap <buffer> <Leader>b <Plug>(go-build)
	nmap <buffer> <Leader>i <Plug>(go-info)
	nmap <buffer> <Leader>gd <Plug>(go-def-tab)
	nmap <buffer> <Leader>p :GoDecls<CR>
	nmap <buffer> <Leader>ta :GoAddTags
	nmap <buffer> <Leader>td :GoRemoveTags
	vmap <buffer> <Leader>ta :GoAddTags
	vmap <buffer> <Leader>td :GoRemoveTags
	nmap <buffer> <Leader>r :GoRename<Space>
	nmap <buffer> <Leader>l :GoMetaLinter<CR>
	inoremap <buffer> <C-p> <C-x><C-o>
	inoremap <buffer> <C-n> <C-x><C-o>
endfunction

au FileType go call GoCustomMappings()

" Function removes all trailing white spaces
function! RemoveTrailingWhiteSpaces()
	let l:save = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(l:save)
endfunction

au BufWritePre * call RemoveTrailingWhiteSpaces() " Automatically remove trailing white spaces on save

" Toggle git blame
function! s:ToggleGitBlame()
	let found = 0
	for windownumber in range(1, winnr('$'))
		if getbufvar(winbufnr(windownumber), '&filetype') ==# 'fugitiveblame'
			exe windownumber . 'close'
			let found = 1
		endif
	endfor
	if !found
		Git blame
	endif
endfunction

" Mapping to toggle git blame window
nmap <silent> <Leader>gb :call <SID>ToggleGitBlame()<CR>

" Custom command to edit vim config file
:command RC tabnew ~/.config/nvim/init.vim

" Custom command to edit .zshrc
:command ZRC tabnew ~/.zshrc


