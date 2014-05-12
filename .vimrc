" Pathogen
filetype off " Pathogen needs to run before plugin indent on
call pathogen#infect()
call pathogen#helptags() " generate helptags for everything in 'runtimepath'
set nocompatible
filetype plugin on
filetype plugin indent on

"setup whitespaces, indentations etc.
set tabstop=4 softtabstop=4 expandtab smarttab smartindent  shiftwidth=4 formatoptions=croql

"syntax highlight
set t_Co=256
syntax enable

"status bar
set ruler
set laststatus=2

"search options
set ignorecase
set smartcase           " Override the 'ignorecase' option if the search pattern contains upper
                        "case characters.  Only used when the search pattern is typed and
                        "'ignorecase' option is on.
set incsearch
set wrapscan

set autowrite
set autoread

"always ask for confirmation when in doubt
set confirm

"set mouse=a

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" see http://www.linuxquestions.org/questions/debian-26/remember-last-cursor-position-in-vim-552503/ or here
" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

" Configuration for YouCompleteMe
" let g:ycm_extra_conf_globlist = ['contents/server']
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
