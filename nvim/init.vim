" --- Plugin Management ---
" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'mattn/emmet-vim'
Plug 'rose-pine/vim', {'as': 'rose-pine'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'metakirby5/codi.vim'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'

call plug#end()

" --- General Settings ---
set encoding=UTF-8
" Note: In Neovim, font is handled by the Terminal emulator.
" This line is kept for GUI clients like Neovide/nvr.
set guifont=Cousine\ Nerd\ Font:h12

set number
set relativenumber
set termguicolors
set cursorline
syntax enable

" Error Handling: Only load colorscheme if it exists
silent! colorscheme rosepine

" --- Keymaps ---
let mapleader = " "

nmap <F6> :NERDTreeToggle<CR>
nnoremap <C-n> :NERDTreeToggle<CR>

" Move lines (Alt/Ctrl behavior)
nnoremap <C-Up> :m -2<CR>
nnoremap <C-k> :m -2<CR>
nnoremap <C-Down> :m +1<CR>
nnoremap <C-j> :m +1<CR>

" Black hole register mappings
nnoremap d "_d
nnoremap c d
nnoremap C D
vnoremap c d
nnoremap x "_x

" NERDCommenter (Ctrl + /)
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv

" Navigation & Search
nnoremap <C-p> :Files<CR>
nnoremap <C-e> :History<CR>
nnoremap <C-f> :noh<CR>/
inoremap <C-f> <Esc>:noh<CR>/
nnoremap <C-g> :Rg
nnoremap <C-r> :%s/\v//gc<Left><Left><Left><Left>

" Buffer tabs
nmap <leader>n :bnext<CR>
nmap <leader>p :bprevious<CR>

" --- Autocommands & NERDTree Logic ---

" Fix E492: Only run NERDTree commands if the plugin is loaded
augroup MyNerdTree
    autocmd!
    autocmd StdinReadPre * let s:std_in=1

    " Open NERDTree on directory
    autocmd VimEnter * if exists(':NERDTree') && argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

    " Open NERDTree on empty start
    autocmd VimEnter * if exists(':NERDTree') && argc() == 0 && !exists("s:std_in") | NERDTree | endif

    " Exit if NERDTree is last window
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

    " Line numbers in NERDTree
    autocmd FileType nerdtree setlocal number relativenumber
augroup END

" --- Plugin Configurations ---
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeCreatePrefix = 'silent'

" --- CoC Autocompletion Setup ---
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" CoC GoTo definitions
nmap <silent> <C-b> <Plug>(coc-definition)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Neovim usually has matchit built-in, but this keeps compatibility
silent! runtime macros/matchit.vim

" Sync clipboard
set clipboard=unnamedplus
