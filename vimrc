filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarick/Vundle.vim'

" General
Plugin 'mileszs/ack.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/YankRing.vim'
" for snipmate (run :BundleInstall)
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'

" python
Plugin 'nvie/vim-flake8'

" html
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" clojure
Plugin 'vim-scripts/paredit.vim'
Plugin 'guns/vim-clojure-static'
Plugin 'tpope/vim-fireplace'

" rust
Plugin 'wting/rust.vim'

" themes
Plugin 'altercation/vim-colors-solarized'

call vundle#end()
filetype plugin indent on

colorscheme ir_black
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set nocompatible
set autoindent
set smartindent		" умный автоотступ
set ignorecase		" игнорировать регистр при поиске
syntax off
" set number
set incsearch		" прокручивать к найденому в процесе набора поискового запроса
set hlsearch		" подсветка искомого выражения
set showmatch
set linebreak		" перенос строк по словам, а не по буквам
set wildmenu
set backspace=indent,eol,start
set wildignore=*.pyc,*.pyo,.git,*.class,*~,#*#,*.egg-info
set gdefault  " default /g in regexps
set hidden
" set relativenumber
set undofile

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz,№#


" LEADER MAPPINGS

let mapleader = ","
let g:pep8_map = '<leader>8'
let g:ctrlp_match_window_reversed = 0
map <silent> <leader>td <Plug>TaskList
map <silent> <leader>u :GundoToggle<CR>
map <silent> <leader>n :NERDTreeToggle<CR>
map <leader>j :JSHint<CR>
nmap <leader>a <Esc>:Ack!
" open .vimrc in vsplit window
nnoremap <leader>ev <C-w><C-v><C-w><C-l>:e $MYVIMRC<cr>
" kill search highlighting
nnoremap <silent> <leader><space> :noh<cr>
" toggle invisible chars
nmap <silent> <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬
" toggle spellcheck
nmap <silent> <leader>s :set spell!<CR>
set spelllang=en_gb

nmap <silent> <leader>0 :only<CR>

" copy current filename to clipboard
nmap <silent> <leader>f :let @+ = expand("%")<CR>
" paste from clipboard
nmap <silent> <leader>p "+p
nmap <silent> <leader>P "+P
vmap <silent> <leader>p "+p
" yank to clipboard
vmap <silent> <leader>y "+y
nmap <silent> <leader>y "+y

" remove trailing spaces
nmap <leader>ts :%s/\s\+$//e<CR>:noh<CR>

nmap <Space> <C-D>


" BUFFERS

"nmap <C-Tab> :bn!<CR>
"nmap <C-S-Tab> :bp!<CR>
"imap <C-Tab> <Esc>:bn!<CR>
"imap <C-S-Tab> <Esc>:bp!<CR>
nmap <F2> :CtrlPBuffer<CR>
nmap <F3> :ls<CR>:b<Space>


" SPLIT WINDOWS

nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" split window size
nmap + <C-w>+
nmap - <C-w>-
nmap _ <C-w>-
nmap <C-q> <C-w>q


" TEXT

" tweak movements
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" restore selection after indentation command in visual mode
vmap > >gv
vmap < <gv


" command-line mode aliases
:ca WQ wq
:ca Wq wq
:ca W w
:ca Q q
:ca Q q
:ca E e
:ca Qa qa
:ca QA qa


" FILETYPE RELATED

if has("autocmd")
  " Syntax highlighting
  au BufRead,BufNewFile *.go set filetype=go
  au BufRead,BufNewFile *.less set filetype=css
  au BufRead,BufNewFile *.js set ft=javascript syntax=jquery
  au BufRead,BufNewFile *.html set ft=htmldjango
  au BufRead,BufNewFile *.md set ft=markdown
  au BufRead,BufNewFile *.cljs set filetype=clojure
  " remove all trailing whitespace on file save
  " autocmd BufWritePre *.py,*.html,*.less,*.js,*.sml,*.clj :%s/\s\+$//e
  " autoreload vim configuration on save
  autocmd BufWritePost .vimrc source $MYVIMRC
  autocmd BufWritePost .gvimrc source $MYGVIMRC

  " fix html indentation
  " see http://www.morearty.com/blog/2013/01/22/fixing-vims-indenting-of-html-files/
  autocmd FileType html setlocal indentkeys-=*<Return>
endif


" PLUGINS

let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
let g:NERDTreeWinPos = "right"
let g:pyflakes_use_quickfix = 0
let g:ackprg=" ack-grep -H --nocolor --nogroup --column"

let g:paredit_smartjump = 1
let g:paredit_mode = 1

let g:yankring_replace_n_pkey = '<C-\>'


"set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set laststatus=2


function! ToggleFullscreen()
  exec('silent !wmctrl -r :ACTIVE: -b toggle,fullscreen')
  exec('set lines=50')
  exec('set columns=160')
endfunction

nnoremap <F11> :call ToggleFullscreen()<CR>
inoremap <F11> :call ToggleFullscreen()<CR>

if has('gui_running')
  syntax on
  " colorscheme molokai
  " colorscheme codeschool
  colorscheme min
  set columns=95
  set lines=25

  " turn off menu
  set guioptions-=m
  set guioptions-=T
  " turn off gui tabs
  set guioptions-=e
  " turn off scrollbars
  set guioptions-=l
  set guioptions-=L
  set guioptions-=l
  set guioptions-=r
  set guioptions-=b
  
  " turn off cursor blinking
  set guicursor+=a:blinkon0

  " set guifont=Terminus\ 13
  " set guifont=Inconsolata\ 12
  " set guifont=Droid\ Sans\ Mono\ 12
  " set guifont=Ubuntu\ Mono\ 14
  " set guifont=Anonymous\ Pro\ 14
  " set linespace=7
  set guifont=Fira\ Mono\ 14
  set linespace=3
endif
