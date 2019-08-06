syntax on
colorscheme desert

set number
set showcmd

set cursorline
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

set wildmode=longest,list,full
set wildmenu

set showmatch

set incsearch
set hlsearch

set completeopt+=menuone
set completeopt+=noselect
set completeopt+=noinsert

set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " If Vim beeps during completion

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

nnoremap <space> za

set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'bash-support.vim'
Plugin 'rickhowe/diffchar.vim'
Plugin 'lifepillar/vim-mucomplete'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
call vundle#end() 

filetype plugin indent on

autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree harman | endif

let g:pydiction_location = '/home/madamek/.vim/bundle/pydiction/complete-dict' 
let g:mucomplete#enable_auto_at_startup = 1
au BufNewFile,BufRead Jenkinsfile setf groovy

