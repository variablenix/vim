" vimrc settings
" Last modified Sept 25, 2017

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Backup
set backup
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" set additional options
set history=200		" keep 200 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set t_Co=256
set cursorline " show a visual line under the cursor's current line 
set showmatch " show the matching part of the pair for [] {} and ()
set title
set undolevels=1000
set encoding=utf-8
set hidden
set smartcase
set pastetoggle=<F9> "" toggle proper paste
set tabstop=2 softtabstop=0 shiftwidth=2 smarttab
set whichwrap+=<,>,[,]  "" automatically go to next line: https://stackoverflow.com/questions/2574027/automatically-go-to-next-line-in-vim
set noexpandtab " expand spaces into tabs
"set number " show line numbers
"set ts=2 sw=2 et 

" Set Python
let python_highlight_all = 1 " enable all Python syntax highlighting features
syntax on

au BufNewFile,BufRead *.py
    \ set tabstop=2
    \ set softtabstop=0
    \ set shiftwidth=2
    \ set textwidth=79
    \ set noexpandtab
    \ set autoindent
    \ set fileformat=unix

" Colors
colorscheme molokai
"colorscheme oceandeep
"colorscheme seoul256
"colorscheme euphrasia
"colorscheme euphrasia3
"colorscheme seoul256-light
"colorscheme inkpot
"colorscheme vividchalk
"colorscheme ir_black

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
"if has('mouse')
"  set mouse=cr
"endif

set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.png,.jpg

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on
  " filetype	indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

	set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" When using sudoedit to edit /etc/rsnapshot.conf, the actual editing is done 
" to a temporary file (e.g., /var/tmp/rsnapshotXXqMRN4N.conf), so the 
" condition below has to match the modified name. 
" 

let g:vim_markdown_frontmatter=1

" Vim Plug
" http://www.swamphogg.com/2015/vim-setup/
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
 Plug 'junegunn/seoul256.vim'
 Plug 'junegunn/vim-easy-align'

" Group dependencies, vim-snippets depends on ultisnips
 Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
 Plug 'scrooloose/nerdtree', { 'on':  'NERDTree' }
 Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using git URL
 Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Plugin options
 Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
 Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'
call plug#end()

" Goyo plugin for markdown (MD) 
 Plug 'junegunn/goyo.vim'

" Limelight best served w/ Goyo
 Plug 'junegunn/limelight.vim'

" Surround
 Plug 'https://github.com/tpope/vim-surround.git'

" Vim-Pencil
 Plug 'reedes/vim-pencil'

" Python mode
 Plug 'https://github.com/klen/python-mode.git'

" Python indentation
 Plug 'https://github.com/vim-scripts/indentpython.vim'

" YouCompleteMe
 Plug 'https://github.com/Valloric/YouCompleteMe.git'

" Vim Markdown
 Plug 'https://github.com/plasticboy/vim-markdown.git'

" Syntastic
 Plug 'https://github.com/vim-syntastic/syntastic'

" let Vundle manage Vundle, required
 Plug 'https://github.com/gmarik/Vundle.vim'

" Vundle
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle
call vundle#begin()

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"EOF
