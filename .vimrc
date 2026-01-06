call plug#begin()
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
set encoding=UTF-8
set guifont=Cousine\ Nerd\ Font,\ Regular
nmap <F6> :NERDTreeToggle<CR>
map <C-Up> :m -2<CR>
map <C-k> :m -2<CR>
map <C-Down> :m +1<CR>
map <C-j> :m +1<CR>
nnoremap d "_d
nnoremap c d
nnoremap C D
vnoremap c d
nnoremap x "_x
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv

set number
set relativenumber
set termguicolors
set colorcolumn=100
syntax enable
silent! colorscheme rosepine
set cursorline
set updatetime=300
set clipboard=unnamedplus

" --- NERDTree Configuration ---
augroup MyNerdTree
    autocmd!
    " Open NERDTree automatically when vim starts up on a directory
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

    " Exit Vim if NERDTree is the only window remaining in the only tab.
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

    " Open NERDTree when Vim starts with no files specified
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

    " Enable line numbers specifically for NERDTree
    autocmd FileType nerdtree setlocal number relativenumber
augroup END

" Alternative shortcut to open/close the tree
nnoremap <C-n> :NERDTreeToggle<CR>

" Automatically reveal the current file in NERDTree on buffer switch
"autocmd BufEnter * if &buftype ==# '' && !&previewwindow && bufname('%') !=# '' && !exists('g:NERDTree') && g:NERDTree.IsOpen() | NERDTreeFind | wincmd p | endif

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename
nmap <leader>n :bnext<CR> " Use \n to go to next tab
nmap <leader>p :bprevious<CR> " Use \p to go to previous tab

runtime macros/matchit.vim

" --- IDE Autocompletion (CoC) Setup ---

function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Tab accepts the selected completion
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#confirm() :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

" Ctrl+n navigates to next completion item
inoremap <expr> <C-n> coc#pum#visible() ? coc#pum#next(1) : "\<C-n>"

" Ctrl+p navigates to previous completion item
inoremap <expr> <C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<C-p>"

" Enter always creates a new line and closes completion menu
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#cancel() . "\<CR>" : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Keep the tree in sync with the file system
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeCreatePrefix = 'silent'
let g:NERDTreeShowHidden = 1

" --- Navigation ---
" Ctrl+P: Search for File Name (IntelliJ Cmd+Shift+O / Shift+Shift)
nnoremap <C-p> :Files<CR>

" Ctrl+E: Recent Files (IntelliJ Cmd+E)
nnoremap <C-e> :History<CR>

" --- Searching & Replacing ---
" Ctrl+F: Find in current file
nnoremap <C-f> :noh<CR>/
inoremap <C-f> <Esc>:noh<CR>/

" Ctrl+Shift+F: Search text in whole project (IntelliJ Cmd+Shift+F)
" Note: In many terminals, Ctrl+Shift+F sends a specific code or just Ctrl+F.
" If this doesn't work, use <Leader>f
nnoremap <C-g> :Rg 

" Ctrl+Shift+R: Replace in file (IntelliJ Cmd+R)
" Preps the command and puts cursor between slashes
nnoremap <C-S-r> :%s/\v//gc<Left><Left><Left><Left>

" --- Code Intelligence ---
" Ctrl+B: Go to Definition (IntelliJ Cmd+B)
nmap <silent> <C-b> <Plug>(coc-definition)

" GoTo code navigation (Classic IDE behavior)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" --- CoC Inlay Hints Refresh Fix ---
augroup CocInlayHints
    autocmd!
    " Refresh hints when leaving insert mode
    " Force screen redraw to clear visual artifacts
    autocmd InsertLeave * redraw
augroup END

" Manual toggle if needed: <Space>ih
nnoremap <leader>ih :CocCommand document.toggleInlayHint<CR>
