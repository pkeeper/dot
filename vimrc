filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set nocompatible
set autoindent
set smartindent		" умный автоотступ
set ignorecase		" игнорировать регистр при поиске
syntax on
set number
set incsearch		" прокручивать к найденому в процесе набора поискового запроса
set hlsearch		" подсветка искомого выражения
set showmatch
set linebreak		" перенос строк по словам, а не по буквам
set wildmenu        
set backspace=indent,eol,start
set wildignore=*.pyc,.git,*.class,*~
set gdefault  " default /g in regexps
set hidden
set relativenumber
set undofile


" LEADER MAPPINGS

let mapleader = ","
let g:pep8_map = '<leader>8'
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
" yank to clipboard
vmap <silent> <leader>y "+y
nmap <silent> <leader>y "+y

" remove trailing spaces
nmap <leader>ts :%s/\s\+$//e<CR>:noh<CR>

" BUFFERS

"nmap <C-Tab> :bn!<CR>
"nmap <C-S-Tab> :bp!<CR>
"imap <C-Tab> <Esc>:bn!<CR>
"imap <C-S-Tab> <Esc>:bp!<CR>
nmap <F2> :ls<CR>:b<Space>
nmap <silent> <F3> :BufExplorerHorizontalSplit<CR>


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


" FILETYPE RELATED

if has("autocmd")
  " Syntax highlighting
  au BufRead,BufNewFile *.go set filetype=go
  au BufRead,BufNewFile *.less set filetype=css
  au BufRead,BufNewFile *.js set ft=javascript syntax=jquery
  au BufRead,BufNewFile *.html set ft=htmldjango
  au BufRead,BufNewFile *.md set ft=markdown
  " remove all trailing whitespace on file save
  " autocmd BufWritePre *.py,*.html,*.less,*.js,*.sml,*.clj :%s/\s\+$//e
  " autoreload vim configuration on save
  autocmd BufWritePost .vimrc source $MYVIMRC
  autocmd BufWritePost .gvimrc source $MYGVIMRC
endif


" PLUGINS

let NERDTreeIgnore = ['\.pyc$']
let g:pyflakes_use_quickfix = 0
let g:ackprg=" ack-grep -H --nocolor --nogroup --column"
" let commant-t plugin proceed more files in one directory
let g:CommandTMaxFiles=40000

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
  colorscheme molokai
  set columns=101
  set lines=40

  " turn off menu
  set guioptions-=m
  set guioptions-=T
  " turn off gui tabs
  set guioptions-=e
  " turn off scrollbars
  set guioptions-=l
  set guioptions-=L
  set guioptions-=l
  set guioptions-=R
  set guioptions-=b

  set guifont=Terminus\ 13
endif
