"	Vim config file
"	Based on an example by Bram Moolenaar <Bram@vim.org>
"	Slowly absorbing a bunch of stuff from Gary Bernhardt (see: https://github.com/garybernhardt/dotfiles/blob/master/.vimrc)

" Make sure that vim's looking for pretty colors from iTerm2
" (from: http://kevin.colyar.net/2011/01/pretty-vim-color-schemes-in-iterm2/?utm_source=rss&utm_medium=rss&utm_campaign=pretty-vim-color-schemes-in-iterm2)

set t_Co=256
colorscheme codeschool

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

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

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

  " Set up assist for closing HTML tags
  " From http://vim.sourceforge.net/scripts/script.php?script_id=13
  " NOT WORKING FOR SOME REASON -- FIXME
  au BufAdd *.html,*.php,*.erb source ~/.vim/scripts/closetag.vim
else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis

" Tab behavior
set tabstop=2
set expandtab
set shiftwidth=2

set backupdir=~/.vim_backup

set pastetoggle=<f2>

" Clear search selection on carriage return
" Courtesy of grb:
" https://github.com/garybernhardt/dotfiles/blob/master/.vimrc

:nnoremap <CR> :nohlsearch<cr>


" Move cursor to beginning of change after using . to repeat a change
" From vim tips wiki: http://vim.wikia.com/wiki/VimTip1142

nmap . .`[


" Use pathogen for runtime path management
" https://github.com/tpope/vim-pathogen
"
" Using this for both slime and vim-ruby, I think

call pathogen#infect()

" Configure slime to use tmux
" https://github.com/jpalardy/vim-slime#readme

let g:slime_target = "tmux"

