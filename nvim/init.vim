"""""""""""""""""""" Plugins
" using vim-plug

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug '~/dev/nvim-bacon'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" show modified lines in the left gutter
" ]c and [c jump to next and previous hunk
" :GitGutterFold keeps only modifications
" more about staging and undoing chunks: https://github.com/airblade/vim-gitgutter#hunks
Plug 'https://github.com/airblade/vim-gitgutter'
"Plug 'https://github.com/Canop/patine'
"Plug '~/dev/patine'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/tpope/vim-abolish'
Plug 'https://github.com/othree/yajs.vim'
Plug 'https://github.com/othree/es.next.syntax.vim'
Plug 'https://github.com/cocopon/iceberg.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'rust-lang/rust.vim'
"Plug 'racer-rust/vim-racer'
Plug 'zxqfl/tabnine-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" buffers
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
"Plug 'ryanoasis/vim-devicons'
" Plug 'akinsho/bufferline.nvim'

" easymotion add shortcuts leader-leader-w, leader-leader-l, leader-leader-f
" which, when followed by a letter, will highlight places where we can then
" jump with just a letter
Plug 'easymotion/vim-easymotion'

" add the :GenTocGFM command to generate a markdown TOC. As the toc is
" auto-updated, one may want to use :RemoveToc
" Plug 'mzlogin/vim-markdown-toc'

" Plug 'https://gitlab.com/lstwn/broot.vim'

call plug#end()

" Plugins I should try to make work:
"https://github.com/junegunn/fzf.vim
"https://github.com/neoclide/coc.nvim " is it so slow it's useless ? or was
"there a bug in the config ?


"""""""""""""""""""" Colors

colorscheme iceberg

" for vim-airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme='distinguished'
let g:airline_section_x=''
let g:airline#extensions#hunks#enabled=0
let g:airline_detect_spell=0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
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

set history=1000

" I want all saves to be visible from inotify, so I need to change
" the backup strategy
set nowritebackup

""""""""""""""""""""" For Terminator

":let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0
set guicursor=

""""""""""""""""""""" Search

" case insensitive search...
"set ignorecase

" ... unless there's some uppercase in the pattern
"set smartcase

""""""""""""""""""""" Deoplete

let g:deoplete#enable_at_startup = 1

""""""""""""""""""""" Terminal

" Make escape work in the Neovim terminal.
tnoremap <Esc> <C-\><C-n>

""""""""""""""""""""" Files

set hidden

autocmd FileType gradle setlocal shiftwidth=2 tabstop=2
autocmd FileType pug setlocal shiftwidth=2 tabstop=2
autocmd FileType rs setlocal shiftwidth=4 tabstop=4

" speed up searches in node projects
set wildignore+=**/node_modules/**
set wildignore+=**/build/**
set wildignore+=*.class,*.so,*.csv

" Auto save changes before switching buffer
set autowrite

" remove trailing spaces on save
augroup autotrim
    autocmd!
    autocmd BufWritePre *.vim,*.py,*.js,*.txt,*.md,*.hs,*.rs,*.html,*.css,*.less,*.scss,*.java :%s/\s\+$//e
augroup end

"""""""""""""""""""" Keys & Shortcuts

let mapleader="\<space>"

" change buffer
nnoremap <Leader>l :ls<CR>:b<Space>

" find files using FZF
nnoremap <c-p> :w<cr>:FZF<cr>

" console.log word under cursor
nnoremap <Leader>cl yiwoconsole.log('<c-r>":', <c-r>");<Esc>^
nnoremap <Leader>cL yiwOconsole.log('<c-r>":', <c-r>");<Esc>^

" debug! word under cursor
nnoremap <Leader>d yiwodebug!("<c-r>"={:?}", &<c-r>");<Esc>^
nnoremap <Leader>D yiwOdebug!("<c-r>"={:?}", &<c-r>");<Esc>^

" and the same for rust...
nnoremap <Leader>db yiwodebug!("<c-r>"={:?}", &<c-r>");<Esc>^

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

nnoremap <Leader>l :ls<CR>:b<Space>

" open a file in current file's directory
nnoremap <Leader>e :w<CR>:e <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <Leader>sp :split <C-R>=expand("%:p:h") . "/" <CR>

" find current word in current (adjustable) directory
nnoremap <Leader>f :w<CR>yiw:vim /\<<C-R>"\>/ <C-R>=expand("%:p:h") . "/" <CR>

" find current word in current directory using vimgrep
nnoremap <Leader>ff :w<CR>yiw:vim /\<<C-R>"\>/ <C-R>=expand("%:p:h") . "/*" <CR><CR>

" find current word in current repository using gitgrep
nnoremap <Leader>gg :w<CR>yiw:Ggrep <C-R>" <CR>

" go to next file
nnoremap ù :w<CR>:cn<CR>

" easier buffer switching
nnoremap <Tab> :w<CR>:b#<CR>
" nnoremap <Tab> :w<CR>:b#<CR>
nnoremap <C-Tab> :w<CR>:b3<CR>
" shows the list of buffers and let you choose one
nnoremap <leader>b :w<CR>:buffers<CR>:buffer<space>

" adds an empty line before the current one (don't make it a comment line if
" the current one is commented)
nnoremap OO ko<Esc>j
" adds an empty line below the current one
nnoremap oo o<Esc>k

" Delete line but preserve the space
nnoremap dD S<Esc>

" Make `Y` work from the cursor to the end of line
nnoremap Y y$

" Use K to join current line with line above, just like J does with line below
nnoremap K kJ

"Switch to current dir
nnoremap <Leader>cd :cd %:p:h<cr>

" I always go to that file...
nnoremap <Leader>tt :e ~/todo.txt<CR>

" :w!!
" write the file when you accidentally opened it without the right (root) privileges
" Courtesy CIA ( https://wikileaks.org/ciav7p1/cms/page_4849889.html )
cmap w!! w !sudo tee % > /dev/null

" indent/dedent shortcut for the current line
nnoremap < V<
nnoremap > V>

" Shortcuts relevant for my current projects
nnoremap <Leader>i :w<CR>:!./install.sh<CR>
nnoremap <Leader>me :w<CR>:e ~/dev/miaou/

"""""""""""""""""""" Abolish

cnoreabbrev S Subvert

"""""""""""""""""""" Markdown

" display current markdown file as HTML in browser
" (grip must be installed)
nnoremap <Leader>md <Esc>:!grip -b %<CR><CR>

nnoremap <Leader>-- yyp:s/./-/g<CR><Esc>

"""""""""""""""""""" Git

" diff unsaved vs saved file
" command DiffOrig let g:diffline = line('.') | vert new | set bt=nofile | r # | 0d_ | diffthis | :exe "norm! ".g:diffline."G" | wincmd p | diffthis | wincmd p
" nnoremap <Leader>do :DiffOrig<cr>
" nnoremap <leader>dc :q<cr>:diffoff<cr>:exe "norm! ".g:diffline."G"<cr>

"""""""""""""""""""" Rust

let g:racer_experimental_completer = 1

au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

"""""""""""""""""""" Broot

" nnoremap <silent> <leader>b :Broot<CR>

" you might want to:
command! BrootWorkingDirectoryNewTab call g:OpenBrootIn(".", "tabedit")

" adjust path to config (this defaults to '~/.config/broot/conf.toml'):
let g:broot_default_conf_path = "~/.config/broot/conf.toml"

" set this to replace netrw with broot (off per default):
"let g:broot_replace_netrw = 1

" if you want to change the config that is appended on top of your regular
" broot conf.toml set this array of strings (default shown):
let g:broot_vim_conf = [
            \ '[[verbs]]',
            \ 'key = "enter"',
            \ 'execution = ":print_path"',
            \ 'apply_to = "file"',
            \ ]

" adjust broot command with (this defaults to 'br'):
let g:broot_command = 'br'

" adjust default edit/open command (this defaults to 'edit'):
" let g:broot_default_edit_command = 'tabedit'



""""""""""""""""""""""""""""""""""""""""""""""
" Indentation management
""""""""""""""""""""""""""""""""""""""""""""""
" By default, use spaced tabs.
set expandtab

" Display tabs as 4 spaces wide. When expandtab is set, use 4 spaces.
set shiftwidth=4
set tabstop=4

function TabsOrSpaces()
    " " Determines whether to use spaces or tabs on the current buffer.
    " if getfsize(bufname("%")) > 956000
    "     " File is very large, just use the default.
    "     return
    " endif

    let numTabs=len(filter(getbufline(bufname("%"), 1, 250), 'v:val =~ "^\\t"'))
    let numSpaces=len(filter(getbufline(bufname("%"), 1, 250), 'v:val =~ "^ "'))

    if numTabs > numSpaces
        setlocal noexpandtab
    endif
endfunction

" Call the function after opening a buffer
autocmd BufReadPost * call TabsOrSpaces()
""""""""""""""""""""""""""""""""""""""""""""""

" https://github.com/akinsho/bufferline.nvim
" nnoremap <silent> gb :BufferLinePick<CR>

nnoremap ! :BaconLoad<CR>:w<CR>:BaconNext<CR>
nnoremap , :BaconList<CR>

lua require('init')

"""""""""""""""""""""""""""""""""""""""""""""
" bacon shortcuts
"""""""""""""""""""""""""""""""""""""""""""""

nnoremap ! :BaconLoad<CR>:w<CR>:BaconNext<CR>
nnoremap , :BaconList<CR>
