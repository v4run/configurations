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
set completeopt-=preview " prevent preview window from opening in completion
set list listchars=tab:\|\  " adding set indent guide lines
" set cursorcolumn " highlight the current col
" set colorcolumn=120 " add a vertical line at column
set cmdheight=1

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
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ayu-theme/ayu-vim'
Plug 'sainnhe/sonokai'
call plug#end()

" Mappings
nnoremap <silent> <Leader><Space> :let @/ = ""<CR> " clear the last used search pattern

" Status line settings
let g:lightline = {
			\ 'colorscheme': 'sonokai',
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
" autocmd vimenter * ++nested colorscheme onedark
" let ayucolor='dark'
" autocmd vimenter * ++nested colorscheme ayu
let g:sonokai_style = 'atlantis'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1
autocmd vimenter * ++nested colorscheme sonokai
" transparent background
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
" transparent not text background
autocmd vimenter * hi EndOfBuffer guibg=NONE ctermbg=NONE

" Go settings
let g:go_metalinter_autosave = 0
" let g:go_debug = ['shell-commands']
let g:go_jump_to_error = 1
let g:go_doc_popup_window = 0
let g:go_def_mapping_enabled = 1
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
let g:go_gopls_complete_unimported = 1


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
" nmap <C-p> :Files<CR>
nmap <C-p> :Telescope find_files<CR>
nmap <Leader>fe :Telescope file_browser<CR>

" Execute :Git command
nmap <Leader>gs :G<CR>

autocmd User TelescopePreviewerLoaded setlocal wrap

" Go custom mappings
function! GoCustomMappings()
	nmap <buffer> gi :GoImplements<CR>
	nmap <buffer> gc :GoCallers<CR>
	nmap <buffer> gr :GoReferrers<CR>
	nmap <buffer> <Leader>x <Plug>(go-run)
	nmap <buffer> <Leader>b <Plug>(go-build)
	nmap <buffer> <Leader>i <Plug>(go-info)
	nmap <buffer> <Leader>gd <Plug>(go-def-tab)
	nmap <buffer> <Leader>e :GoIfErr<CR>
	nmap <buffer> <Leader>p :GoDecls<CR>
	nmap <buffer> <Leader>ta :GoAddTags<Space>
	nmap <buffer> <Leader>td :GoRemoveTags<Space>
	nmap <buffer> <Leader>r :GoRename<CR>
	nmap <buffer> <Leader>l :GoMetaLinter<CR>
	nmap <buffer> <Leader>9 :GoDecls<CR>
	nmap <buffer> <Leader>0 :GoDeclsDir<CR>
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
nmap <silent> gb :call <SID>ToggleGitBlame()<CR>

" Custom command to edit vim config file
:command RC tabnew ~/.config/nvim/init.vim

" Custom command to edit .zshrc
:command ZRC tabnew ~/.zshrc

lua << EOF
local actions = require('telescope.actions')

require('telescope').setup{
	defaults = {
		color_devicons = true,
		mappings = {
			i = {
				['<C-j>'] = actions.move_selection_next,
				['<C-k>'] = actions.move_selection_previous,
			}
		}
	},
	pickers = {
		file_browser = {
			hidden = true,
		}
	},
	extensions = {
		fzf = {
			fuzzy = true,
		}
	},
}

require('telescope').load_extension('fzf')
EOF

