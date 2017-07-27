colorscheme desert
syntax on

set hlsearch
set cursorline

set wildmenu
set expandtab
set wildignore=*.dll,*.o,*.pyc,*.bak,*.exe,*.jpg,*.jpeg,*.png,*.gif
set wildmode=list:full
set autochdir
let g:netrw_list_hide='^\.,.\(pyc\|pyo\|o\)$'

set invnumber
:nmap <C-N><C-N> :set invnumber<CR>

" Pathogen load
filetype off

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
