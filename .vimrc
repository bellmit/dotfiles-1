" ----------- All plugin related stuff --------------
call plug#begin('~/.vim/plugged')
Plug 'ycm-core/YouCompleteMe'
Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'git@github.com:kien/ctrlp.vim.git'
Plug 'mbbill/undotree'
Plug 'vimwiki/vimwiki'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" ----------- Files related -----------------------------
nnoremap <silent> <Leader>; :Files<CR>
nnoremap <silent> <Leader>. :Files <C-r>=expand("%:h")<CR>/<CR>
nnoremap <leader>b :buffers<cr>:b<space>

" ----------- Actual configurations -------------------
" Leader mapping
let mapleader=";"       " change leader key to ;
let maplocalleader=";"  " change local leader key to ;

" Always yank/paste to/from system clipboard
noremap <silent> <leader>y "+y
noremap <silent> <leader>Y "+Y
noremap <silent> <leader>p "+p
noremap <silent> <leader>P "+P

" ------------ Regular configurations --------------------
" <leader>ev edits .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>

" <leader>sv sources .vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>:redraw<CR>:echo $MYVIMRC 'reloaded'<CR>

" <leader>w writes the whole buffer to the current file
nnoremap <silent> <leader>w :w!<CR>
inoremap <silent> <leader>w <ESC>:w!<CR>

" <leader>q quits the current window
nnoremap <silent> <leader>q :wq!<CR>
inoremap <silent> <leader>q <ESC>:wq!<CR>

" Clear highlighted search with Ctrl + L
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" use <leader>d to delete a line without adding it to yank
nnoremap <silent> <leader>d "_d
vnoremap <silent> <leader>d "_d

" d to delete and <leader>d to actually cut
nnoremap x "_x
nnoremap d "_d
nnoremap D "_d
vnoremap d "_d
nnoremap <leader>d ""d
nnoremap <leader>D ""D
vnoremap <leader>d ""d

" exit from insert mode without cursor movement
inoremap jk <ESC>`^

" Automatically close braces
inoremap {<CR> {<CR>}<Esc>ko<tab>
inoremap [<CR> [<CR>]<Esc>ko<tab>
inoremap (<CR> (<CR>)<Esc>ko<tab>

" ==========  Start Plugin configurations ==============
" ------- Vim wiki specific --------------------
filetype plugin on
set nocompatible
let wiki_1 = {}
let wiki_1.path = '~/Github/personal/notes/'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'
let g:vimwiki_list = [wiki_1]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

" ----- vim-instant-markdown - Instant Markdown previews from Vim ---
" https://github.com/suan/vim-instant-markdown
let g:instant_markdown_autostart = 0	" disable autostart
map <leader>md :InstantMarkdownPreview<CR>


" ==========  End Plugin configurations ==============

" ----------- Setting sane defaults --------------
syntax on
colorscheme gruvbox
set background=dark
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set nowrap
set number relativenumber
set backspace=indent,eol,start
set incsearch
set hlsearch
set ignorecase smartcase
set showcmd
set cursorline  " highlight current line
set autoindent
set noswapfile
set nobackup
set undodir=~/.vim/undodir " make sure this directory exists
set undofile

" ---------- Advanced Configurations Sourced from ThePrimeagen -------
" Lets rgrep derive the git root of the current working directory
if executable('rg')
    let g:rg_derive_root='true'
endif

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Filetree configuration
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

" ag is fast enough. No need for caching
let g:ctrlp_use_caching = 0

" Configuration related to resizing filetree window and switching between tabs
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

" YCM remappings
nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <buffer> <silent> <leader>gr :YcmCompleter GoToReferences<CR>

" Move chunks of code up or down with Shift J or Shift K
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
