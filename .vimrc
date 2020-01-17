" Copyright 2020 (C) Julian Huch
" Original Code by noptrix & elken

" Preamble
set nocompatible               " be iMproved
filetype off                   " required!
 if has('vim_starting')
   set runtimepath+=~/.vim/bundle/neobundle.vim/
 endif

 call neobundle#rc(expand('~/.vim/bundle/'))

" Basic options
" file type and syntax highliting on
filetype plugin indent on
syntax on

" specific settings
set cursorline			" nocursorline for no cursor line.
set nostartofline       " Keep the horizontal cursorline when moving vertically.
set title
set noautoindent
set ruler
set shortmess=aoOTI
set showmode
set splitbelow
set splitright
set laststatus=2
set nomodeline
set showcmd
set showmatch

" Vi command autocompletion
set wildmenu

" Stops Vi from redrawing the screen
set lazyredraw

" Tab Styling
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Do not break long lines.
set nowrap
set listchars=eol:$,extends:>

set cinoptions=(0,m1,:1
set formatoptions=tcqr2
set laststatus=2
set nomodeline
set clipboard=unnamed
set softtabstop=4
set showtabline=1
set smartcase
set sidescroll=5
set scrolloff=4

" Searching
set incsearch
set hlsearch

" Terminal
set ttyfast
set history=10000
set hidden
set number
set backspace=indent,eol,start
set ttimeoutlen=100

" Better completion
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview

" Leader
let mapleader = ";"
let maplocalleader = "\\"

" Cursorline
" Only show cursorline in the current window and in normal mode.
augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

" Line Return
" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Amit
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" Backups
set backup                        " enable backups
set noswapfile                    " it's 2020, Vim.
set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" Color scheme
set background=dark
colorscheme afterglow

" Column Color Stop
set colorcolumn=80
highlight ColorColumn ctermbg=darkgrey

" Statusline
set statusline=
set statusline+=%7*\[%n]                                  "buffernr
set statusline+=%1*\ %<%F\                                "File+path
set statusline+=%2*\ %y\                                  "FileType
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..)
set statusline+=%5*\ %{&spelllang}\                       "Spellanguage
set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
set statusline+=%9*\ col:%03c\                            "Colnr
set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly?  Top/bot.

" Powerline-Vim
" powerline and powerline fonts have to be installed.
" Comment out to use vim-airline (delete comment in plugin section and
" NeoBundeInstall the plugin).
let g:powerline_pycmd="py3"
set laststatus=2

" Folding
set foldenable
set foldlevelstart=10
set foldmethod=indent

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Mappings
" Movement Keys
nnoremap j gj
nnoremap k gk

" Fast Moevement
" Space = pagedown, ShiftSpace = pageup
noremap <Space> <PageDown>
noremap , <PageUp>

" Easy buffer navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Switch Buffer
nnoremap <Tab><Tab> <C-W>w

" Easy split windows and navigate. 
" Vertical split, horizontal split, split filname , hide and close.
nnoremap <leader>v <C-w>v    
nnoremap <leader>h <C-w>S
nnoremap <leader>Q <C-w>Q
nnoremap <leader>a :split
"nnoremap <leader>av :vsplit
nnoremap <leader>q :hide

" Quick editing vimrc file
nnoremap <leader>ev :vsplit ~/.vimrc<cr>

" :noh on <leader> key
"noremap <leader>h :noh<CR>

" Plugin settings 
" NeoBundle 
NeoBundleFetch 'Shougo/neobundle.vim'

" Github
NeoBundle 'ycm-core/YouCompleteMe'
"NeoBundle 'vim-airline/vim-airline'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc', {'build' : {'unix' : 'make -f make_unix.mal',},}

" Toggle NERDTree with <F2> or <leader>t
noremap  <F2>      :NERDTreeToggle<CR>
noremap  <leader>t :NERDTreeToggle<CR>    
inoremap <F2> <esc>:NERDTreeToggle<CR>

augroup ps_nerdtree
     au!

     au Filetype nerdtree setlocal nolist
augroup END

let NERDTreeHighlightCursorline = 1
let NERDTreeIgnore = ['.vim$', '\~$', '.*\.pyc$', 'pip-log\.txt$', 'whoosh_index',
                                 \ 'xapian_index', '.*.pid', 'monitor.py', '.*-fixtures-.*.json',
                                  \ '.*\.o$', 'db.db', 'tags.bak', '.*\.pdf$', '.*\.mid$',
                                  \ '.*\.midi$']

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDChristmasTree = 1
let NERDTreeChDirMode = 2
let NERDTreeMapJumpFirstChild = 'gK'
let NERDTreeQuitOnOpen = 1 " Automatically close NERDTree when you open a file.

" Tagbar
nnoremap <F9> :TagbarToggle<CR>

" Unite
nnoremap <C-s> :Unite file_rec/async<cr>
nnoremap <leader>/ :Unite grep:.<cr>
let g:unite_source_history_yank_enable = 1
nnoremap <leader>y :Unite history/yank<cr>
nnoremap <leader>b :Unite -quick-match buffer<cr>

" Toggle between .h and .cpp with <F4> or <leader>T
function! ToggleBetweenHeaderAndSourceFile()
    let bufname = bufname("%")
    let ext = fnamemodify(bufname, ":e")
    if ext == "h"
        let ext = "cpp"
    elseif ext == "cpp"
        let ext = "h"
    else
        return
    endif
    let bufname_new = fnamemodify(bufname, ":r") . "." . ext
    let bufname_alt = bufname("#")
    if bufname_new == bufname_alt
        execute ":e#"
    else
        execute ":e " . bufname_new
    endif
endfunction
nnoremap <silent> <F4>      :call ToggleBetweenHeaderAndSourceFile()<CR>
nnoremap <silent> <leader>T :call ToggleBetweenHeaderAndSourceFile()<CR>

