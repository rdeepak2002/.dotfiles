" --- Plugin Management ---
" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'mattn/emmet-vim'
Plug 'lunacookies/vim-colors-xcode'
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
Plug 'sphamba/smear-cursor.nvim'
Plug 'keith/swift.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

" --- General Settings ---
set encoding=UTF-8

" Ignore build artifacts, dependencies, and generated files in search/wildmenu
set wildignore+=*/build/*,*/dist/*,*/out/*,*/target/*
set wildignore+=*/__pycache__/*,*.pyc,*.pyo,*/.mypy_cache/*,*/.pytest_cache/*
set wildignore+=*/node_modules/*,*/.next/*,*/.nuxt/*
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=*/vendor/*,*/.gradle/*,*/.idea/*,*/.vscode/*
set wildignore+=*.o,*.obj,*.a,*.so,*.dylib,*.dll,*.class,*.jar
set wildignore+=*.swp,*.swo,*~,*.DS_Store
set wildignore+=*/coverage/*,*/.nyc_output/*,*/htmlcov/*
set wildignore+=*/.venv/*,*/.env/*,*/venv/*,*/env/*
" Note: In Neovim, font is handled by the Terminal emulator.
" This line is kept for GUI clients like Neovide/nvr.
set guifont=Cousine\ Nerd\ Font:h12

set number
set relativenumber
set termguicolors
set cursorline
set updatetime=300
set colorcolumn=100
syntax enable

" Error Handling: Only load colorscheme if it exists
silent! colorscheme xcodedarkhc

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
nnoremap <C-S-r> :%s/\v//gc<Left><Left><Left><Left>

" Buffer tabs
nmap <leader>n :bnext<CR>
nmap <leader>p :bprevious<CR>
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" Exit terminal mode with Escape
tnoremap <Esc> <C-\><C-n>

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
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeCreatePrefix = 'silent'
let g:NERDTreeShowHidden = 1
let NERDTreeIgnore = [
  \ '\.\(pyc\|pyo\|o\|obj\|class\|DS_Store\|swp\)$',
  \ '^__pycache__$', '^\.\(mypy_cache\|pytest_cache\)$',
  \ '^node_modules$', '^\.\(next\|nuxt\)$',
  \ '^build$', '^dist$', '^out$', '^target$',
  \ '^\.\(git\|hg\|svn\|gradle\|idea\|vscode\)$',
  \ '^coverage$', '^\.\(nyc_output\)$', '^htmlcov$',
  \ '^\.\(venv\|env\)$', '^venv$', '^env$',
  \ ]

" fzf :Files — use rg to list files, respecting .gitignore + custom ignores
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
  \ . ' --glob "!.git" --glob "!node_modules" --glob "!__pycache__"'
  \ . ' --glob "!build" --glob "!dist" --glob "!out" --glob "!target"'
  \ . ' --glob "!.venv" --glob "!venv" --glob "!.env" --glob "!env"'
  \ . ' --glob "!.mypy_cache" --glob "!.pytest_cache"'
  \ . ' --glob "!.gradle" --glob "!.idea" --glob "!.vscode"'
  \ . ' --glob "!coverage" --glob "!htmlcov" --glob "!.nyc_output"'
  \ . ' --glob "!.next" --glob "!.nuxt" --glob "!vendor"'

" --- CoC Autocompletion Setup ---
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

" --- CoC Inlay Hints Refresh Fix ---
augroup CocInlayHints
    autocmd!
    " Refresh hints when leaving insert mode
    " Force screen redraw to clear visual artifacts
    autocmd InsertLeave * redraw
augroup END

" Manual toggle if needed: <Space>ih
nnoremap <leader>ih :CocCommand document.toggleInlayHint<CR>

" --- C/C++ Header Guards ---
function! s:InsertHeaderGuard()
    " Get the filename and convert to uppercase with underscores
    let filename = expand('%:t')
    let guard = toupper(substitute(filename, '[^a-zA-Z0-9]', '_', 'g'))

    " Insert the header guard template
    call append(0, '#ifndef ' . guard)
    call append(1, '#define ' . guard)
    call append(2, '')
    call append(3, '')
    call append(4, '')
    call append(5, '#endif // ' . guard)

    " Position cursor on line 4 (between the guards)
    normal! 4G
endfunction

augroup HeaderGuards
    autocmd!
    autocmd BufNewFile *.h,*.hpp call s:InsertHeaderGuard()
augroup END

" --- Smear Cursor Configuration ---
lua << EOF
require('smear_cursor').enabled = true
EOF

" --- Treesitter Configuration ---
lua << EOF
local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if status_ok then
  configs.setup {
    ensure_installed = { "c", "cpp", "rust", "cmake", "python", "javascript", "typescript", "json", "lua" },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
    },
    indent = {
      enable = true
    },
  }
end
EOF
