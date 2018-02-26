"""""""""""""""""""" Plugins
" using vim-plug

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/Canop/patine'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/othree/yajs.vim'
Plug 'https://github.com/othree/es.next.syntax.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'Shougo/deoplete.nvim'
call plug#end()


"""""""""""""""""""" Colors

colorscheme patine
 
" for vim-airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme='distinguished'
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing', 'long']


""""""""""""""""""""" Global Behavior

" Eliminate delay when switching modes
" (note that tmux needs its own additionnal setting for fast escape handling)
set ttimeoutlen=0

set updatetime=250

" ensures there's at least 5 lines visible around the current one
set so=5

" Prevents inserting two spaces after punctuation on a join (J)
set nojoinspaces        

" Keep the cursor in the same place when switching buffers
set nostartofline

" clear search highlight on esc
nnoremap <esc> :noh<return><esc>

set inccommand=nosplit

""""""""""""""""""""" Deoplete

let g:deoplete#enable_at_startup = 1

""""""""""""""""""""" Terminal

" Make escape work in the Neovim terminal.
tnoremap <Esc> <C-\><C-n>

""""""""""""""""""""" Files

autocmd FileType gradle setlocal shiftwidth=2 tabstop=2
autocmd FileType pug setlocal shiftwidth=2 tabstop=2

" speed up searches in node projects
set wildignore+=**/node_modules/**
set wildignore+=**/build/**
set wildignore+=*.class,*.so,*.csv

" Auto save changes before switching buffer
set autowrite

" remove trailing spaces on save
autocmd BufWritePre *.py,*.js,*.txt,*.md,*.hs,*.rs,*.html,*.css,*.less,*.scss,*.java :%s/\s\+$//e

"""""""""""""""""""" Keys & Shortcuts

let mapleader="\<space>"

" find files using FZF
nnoremap <c-p> :FZF<cr>

" console.log word under cursor
nmap <Leader>cl yiwoconsole.log('<c-r>":', <c-r>");<Esc>^
nmap <Leader>cL yiwOconsole.log('<c-r>":', <c-r>");<Esc>^

" markdown edition:
" surround current (w|W)ord with quotes or code marks
nnoremap <Leader>k ciw``<Esc>P
vnoremap <Leader>k :s/\%V\(.*\)\%V/`\1`/<Esc>
nnoremap <Leader>q ciw""<Esc>P
vnoremap <Leader>q :s/\%V\(.*\)\%V/"\1"/<Esc>
nnoremap <Leader>K ciW``<Esc>P
nnoremap <Leader>Q ciW""<Esc>P

" gp selects the last selection
nnoremap gp `[v`]

" open a file in current file's directory
map <Leader>e :w<CR>:e <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>sp :split <C-R>=expand("%:p:h") . "/" <CR>

" find current word in current (adjustable) directory
map <Leader>f :w<CR>yiw:vim /\<<C-R>"\>/ <C-R>=expand("%:p:h") . "/" <CR>

" find current word in current directory
map <Leader>ff :w<CR>yiw:vim /\<<C-R>"\>/ <C-R>=expand("%:p:h") . "/*" <CR><CR>

" go to next file
nmap ù :cn<CR>

" easier buffer switching
nnoremap <Tab> :w<CR>:b#<CR>
nnoremap <C-Tab> :w<CR>:b3<CR>
" shows the list of buffers and let you choose one
nnoremap <leader>b :w<CR>:buffers<CR>:buffer<space>

" adds an empty line before the current one (don't make it a comment line if
" the current one is commented)
nmap OO ko<Esc>j
" adds an empty line below the current one
nmap oo o<Esc>k

" Delete line but preserve the space
nnoremap dD S<Esc>

" Make `Y` work from the cursor to the end of line
nnoremap Y y$

" Use K to join current line with line above, just like J does with line below
nnoremap K kJ

"Switch to current dir
nnoremap <Leader>cd :cd %:p:h<cr>

" I always go to that file...
nmap <Leader>tt :e ~/todo.txt<CR>

" :w!! 
" write the file when you accidentally opened it without the right (root) privileges
" Courtesy CIA ( https://wikileaks.org/ciav7p1/cms/page_4849889.html )
cmap w!! w !sudo tee % > /dev/null

" indent/dedent shortcut for the current line
nmap < V<
nmap > V>

" Shortcuts relevant for my current projects
noremap <Leader>i :w<CR>:!./install.sh<CR>
noremap <Leader>me :w<CR>:e ~/dev/miaou/

"""""""""""""""""""" Markdown

" display current markdown file as HTML in browser
" (grip must be installed)
nmap <Leader>md <Esc>:!grip -b %<CR><CR>

nmap <Leader>-- yyp:s/./-/g<CR><Esc>

"""""""""""""""""""" Git

" diff unsaved vs saved file
" command DiffOrig let g:diffline = line('.') | vert new | set bt=nofile | r # | 0d_ | diffthis | :exe "norm! ".g:diffline."G" | wincmd p | diffthis | wincmd p
" nnoremap <Leader>do :DiffOrig<cr>
" nnoremap <leader>dc :q<cr>:diffoff<cr>:exe "norm! ".g:diffline."G"<cr>

