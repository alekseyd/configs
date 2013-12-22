" Pathogen
filetype off " Pathogen needs to run before plugin indent on
call pathogen#infect()
call pathogen#helptags() " generate helptags for everything in 'runtimepath'
filetype plugin indent on

"setup whitespaces, indentations etc.
set tabstop=4 expandtab autoindent cindent shiftwidth=4

"syntax highlight
set nocompatible
syntax on

"status bar
set ruler
set laststatus=2

"search options
set ignorecase
set incsearch
set wrapscan

set autowrite
set autoread

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" see http://www.linuxquestions.org/questions/debian-26/remember-last-cursor-position-in-vim-552503/ or here
" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

