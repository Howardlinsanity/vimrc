if has("win16") || has("win32")

else
    " Set up Vundle (plugin manager)
    set nocompatible              " be iMproved, required
    filetype off                  " required

    " Check if Vundle is installed, and if it's not, then install it.
    " Then use it to install some plugins.
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')

    if !filereadable(vundle_readme)
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
        let iCanHazVundle=0
    endif

    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

    " Manage Vundle with Vundle
    Bundle 'gmarik/vundle'

    " Syntax error checking
    Bundle 'scrooloose/syntastic' 

    "T-H-E colorscheme
    Bundle 'altercation/vim-colors-solarized' 

    " Git wrapper
    Bundle 'https://github.com/tpope/vim-fugitive' 

    " Quick file navigation.
    Bundle 'ctrlp.vim'

    " Vim's best autocomplete
    Bundle 'Valloric/YouCompleteMe'

    " Too popular to avoid
    Bundle 'scrooloose/nerdtree'

    " Fix parenthesis
    Bundle 'https://github.com/Raimondi/delimitMate'

    " Time to try out snippets
    Plugin 'SirVer/ultisnips'
    Plugin 'honza/vim-snippets'

    " If you want :UltiSnipsEdit to split your window.
    "let g:UltiSnipsEditSplit="vertical"

    " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-l>"
    let g:UltiSnipsJumpBackwardTrigger="<c-h>"

    if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
    endif

    filetype plugin indent on     " required
    " Vundle installation done.

endif

" Use spacebar as the leader character for plugins and such.
map <space> <leader>

" Breaks a little bit of old vi behavior to make plugins work right.
:set nocompatible

" Automatically match previous indentation level
:set autoindent

" Automatically indent the cursor when working with C-style syntax
:set cindent

" Automatically turn tabs into spaces
set expandtab

" Settings for avoiding tabs in code.
set shiftwidth=4
set softtabstop=4

" Show cursor position
:set ruler

" Show relative line numbers, except for the current line.
:set relativenumber
:set number

" Enable syntax highlighting
:syntax on

" Backspace through everything, like most programs
set backspace=indent,eol,start

" left and right arrow keys and h and l can go across lines
:set whichwrap+=<,>,h,l

" Turn off line wrapping
:set nowrap

" Enable mouse navigation
:set mouse=a

" Highlight search terms as you type
:set incsearch

" <leader>h to toggle search highlight
" Default is off.
set nohlsearch
nnoremap <silent> <Leader>h :set hlsearch!<cr>

" Make the smartcase below work
:set ignorecase

" Make searches case insensitive when containing only lowercase letters.
:set smartcase

" Set the font to Consolas bold in gvim
:set guifont=Consolas:b

" Make vim turn *off* expandtab for files named Makefile or makefile
" We need the tab literal
:autocmd BufNewFile,BufRead [Mm]akefile* set noexpandtab

" Show matching [] {} ()
:set showmode

" Automatically insert the comment character when you hit <enter> (r) or o/O (o)
" in a block comment. Disabled right now because copy/pasting doesn't work
" well with this.
":set formatoptions+=ro 

" This option is only supported on vim 7.4 and above (technically 7.3.582 or so)
if v:version > 704
    " When joining two commented lines (J on two selected lines), eliminate 
    " leading characters such as # or // and indentation.
    :set formatoptions+=j
endif

if exists('+colorcolumn')
    " Highlight column 81
    :set colorcolumn=100

    " Make the column color blue
    highlight ColorColumn ctermbg=19
else
    " Put a red background on any text that goes beyond 80 characters
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Use colors that show up better against a dark background
:set background=dark

" Set the gui background to black. The guifg changes the color of some
" text, probably anything that isn't picked up by the syntax highlighter.
highlight Normal guibg=black guifg=white

" Claims to make vim a bit faster.
:set lazyredraw

"Make jk leave insert mode (You'll never type it normally)
inoremap jk <ESC>

" Keep the cursor at least 5 lines above the top and bottom edges of the screen
:set scrolloff=5

" Keep the cursor at least 5 characters from the side edge of the screen.
:set sidescrolloff=5

" H and L go to the top and bottom of the screen. This makes them play nicely 
" with scrolloff.
execute 'nnoremap H H'.&l:scrolloff.'k'
execute 'vnoremap H H'.&l:scrolloff.'k'
execute 'nnoremap L L'.&l:scrolloff.'j'
execute 'vnoremap L L'.&l:scrolloff.'j'

" Use ,s to substitute the word under the cursor.
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" Disable arrow keys in normal mode (they slow you down!).
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" When performing a vim split, open the new one below or on the right, depending
" on if it is vertical or horizontal.
:set splitbelow
:set splitright

" Use ctrl + h|j|k|l to navigate between splits.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Automatically update vim when the vimrc changes.
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC
augroup END

" Replace the word under the cursor with r
nnoremap <Leader>r ciw

" Lets you block select text where the characters are beyond the end of the
" line you are working on.
:set virtualedit=block

" Open the filename under the cursor in a new tab with gf
nnoremap gf <C-w>gF

" Use ,f to journey down the ctags tree.
nnoremap <Leader>d <C-]>

" Use ,d to climb up the ctags tree.
nnoremap <Leader>f <C-t>

" Use omnicomplete (language dependent syntax highlighting) if youcompleteme 
" isn't installed. 
if has("win32")
    filetype plugin on
    set omnifunc=syntaxcomplete#Complete
endif

" Use Ctrl+Space for autocompletion of language specific keywords.
if has("gui_running")
    inoremap <C-Space> <C-x><C-O>
else " no gui
  if has("unix")
    inoremap <Nul> <C-x><C-O>
  endif
endif

" Use utf-8 as the encoding.
:set encoding=utf-8

"inoremap {      {}<Left>
"inoremap {<CR>  {<CR>}<Esc>O
"inoremap {{     {
"inoremap {}     {}
 
nnoremap j gj
nnoremap k gk

" Enable spell check for text files.
if v:version >= 700
  autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en
endif

if has("unix")
    " Set solarized as the colorscheme
    colorscheme solarized
    "colorscheme slate
endif

" Hide the toolbar in gvim
if has("gui_running")
    set guioptions-=T
endif

" Select all with ,a
nnoremap <Leader>a ggVG

" Copy current buffer to system clipboard with ,a
nnoremap <Leader>c ggVG"*y

" Copy text to system clipboard with ,c
nnoremap <Leader>c "*y

" Paste from system clipboard with ,v
nnoremap <Leader>v "*p

" Edit vimrc with :ve
:cmap ev tabe $MYVIMRC

" toggle fixed and relative line numbers with <leader>n
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <Leader>n :call NumberToggle()<cr>

" Use two spaces for indentation on ruby files
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2

" Autosave files when focus is lost (ignoring errors about untitled buffers)
:au FocusLost * silent! wa

" Save a file with Ctrl-s
inoremap <C-s> <ESC>:wa

" maximum of 100 tabs
set tabpagemax=100

" Show information on the current command (x,y for block select, etc)
set showcmd

" Automatically refresh a file when it changes on the disk
set autoread

" Start gvim maximized on windows
if !has("unix")
  au GUIEnter * simalt ~x
endif

" Begin and end commands with the same key (enter)
noremap <CR> :

let g:syntastic_c_checkers = ['make']
let g:syntastic_python_python_exec = '/usr/bin/python3'
color desert
