filetype off
filetype plugin indent on

set nocompatible

" Security
set modelines=0

" Tabs/spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Basic options
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set relativenumber
set laststatus=2
"set undofile

" Backups
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups

" Leader
let mapleader = ","

" Searching
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault
map <leader><space> :noh<cr>
runtime macros/matchit.vim
nmap <tab> %
vmap <tab> %

" Soft/hard wrapping
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

" Color scheme (terminal)
syntax on
set background=dark
colorscheme delek

" Use Pathogen to load bundles
call pathogen#runtime_append_all_bundles()

" NERD Tree
map <F2> :NERDTreeToggle<cr>
let NERDTreeIgnore=['.vim$', '\~$', '.*\.pyc$', 'pip-log\.txt$']

" Use the damn hjkl keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" And make them fucking work, too.
nnoremap j gj
nnoremap k gk

" Easy buffer navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <leader>w <C-w>v<C-w>l

" Folding
set foldlevelstart=0
nnoremap <Space> za
vnoremap <Space> za
au BufNewFile,BufRead *.html map <leader>ft Vatzf

function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction
set foldtext=MyFoldText()

" Fuck you, help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Sort CSS
map <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

" Clean whitespace
map <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Ack
map <leader>a :Ack

" Yankring
nnoremap <silent> <F3> :YRShow<cr>
nnoremap <silent> <leader>y :YRShow<cr>

" Formatting, TextMate-style
map <leader>q gqip
nmap <leader>m :make<cr>

" Easier linewise reselection
map <leader>v V`]

" HTML tag closing
inoremap <C-_> <Space><BS><Esc>:call InsertCloseTag()<cr>a

" Faster Esc
inoremap <Esc> <nop>
inoremap jj <ESC>

" Scratch
nmap <leader><tab> :Sscratch<cr><C-W>x<C-j>:resize 15<cr>

" Diff
nmap <leader>d :!hg diff %<cr>

" Rainbows!
nmap <leader>R :RainbowParenthesesToggle<CR>

" Edit .vimrc
nmap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nmap <leader>sv :source $MYVIMRC<cr>

" VCS Stuff
let VCSCommandMapPrefix = "<leader>h"

" Shouldn't need shift
nnoremap ; :

" Save when losing focus
au FocusLost * :wa

" Stop it, hash key
inoremap # X<BS>#

" Perforce Settings
nnoremap <leader>p4a :!p4 add %<cr>
nnoremap <leader>p4e :!p4 edit %<cr>
nnoremap <leader>p4r :!p4 revert %<cr>
nnoremap <leader>p4d :!p4 diff %<cr>

if has('gui_running')
    set guifont=Monaco:h12
    colorscheme molokai
    set background=dark

    set go-=T
    set go-=l
    set go-=L
    set go-=r
    set go-=R

    if has("gui_macvim")
        macmenu &File.New\ Tab key=<nop>
        map <leader>t <Plug>PeepOpen
    end

    let g:sparkupExecuteMapping = '<D-e>'

    highlight SpellBad term=underline gui=undercurl guisp=Orange
endif                             

