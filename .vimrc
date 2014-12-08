" Pathogen/Vundle
filetype off " Pathogen/Vundle needs to run before plugin indent on
" call pathogen#infect()
" call pathogen#helptags() " generate helptags for everything in 'runtimepath'
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/
call vundle#begin('~/.vim/bundle')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'elzr/vim-json.git'
Plugin 'majutsushi/tagbar.git'

" Color schemes
Plugin 'dsolstad/vim-wombat256i.git'
Plugin 'vim-scripts/Wombat.git'
Plugin 'vim-scripts/wombat256.vim.git'
Plugin 'ercolanelli-leo/candyVirus'

" All of your Plugins must be added before the following line
call vundle#end()            " required
set nocompatible
filetype plugin on
filetype plugin indent on

" Setup vim command and menu completion
set wildmode=full
set wildmenu

"setup whitespaces, indentations etc.
set tabstop=4 softtabstop=4 expandtab smarttab smartindent  shiftwidth=4 formatoptions=croql

" Tagbar key mapping and tuning
call tagbar#autoopen(0)
map <F8> :TagbarOpenAutoClose<CR>
map <S-F8> :TagbarClose<CR>
map <M-F8> :Tagbar<CR>

"doesn't work.....     ##########call NERDTree#autoopen(0)
" Nerdtree key mapping and tuning
map <F10> :NERDTreeToggle<CR>
map <S-F10> :NERDTreeFind<CR>

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

" Show trailing whitepace and spaces before a tab:
" http://makandracards.com/makandra/11541-how-to-not-leave-trailing-whitespace-using-your-editor-or-git
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

" Configuration for YouCompleteMe
" let g:ycm_extra_conf_globlist = ['contents/server']
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_server_log_level = 'error'
map <F6> :YcmCompleter GoTo<CR>
map <F5> :YcmDiags<CR>

"Set working dir to location of the current file
"For more details http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
set autochdir

"keep searching for "tags" from current directory up until "tags" are found
set tags=./tags;
set tags+=/Users/alekseyd/.vim/tags/glibc
set tags+=/Users/alekseyd/.vim/tags/stdcpp

" reload personal vim configuration when it's updated by ourselves
augroup myvimrchook
    au!
    au BufWritePost $MYVIMRC so $MYVIMRC
    au BufWritePost $MYGVIMRC if has('gui_running') | so $MYGVIMRC | endif
augroup END

" If only 2 windows left, NERDTree and Tag_List, close vim or current tab
fun! NoExcitingBuffersLeft()
  if winnr("$") == 3
      let w1 = bufname(winbufnr(1))
        let w2 = bufname(winbufnr(2))
        let w3 = bufname(winbufnr(3))
        if (exists(":NERDTree")) && (w1 == "__Tag_List__" || w2 == "__Tag_List__" || w3 == "__Tag_List__")
            if tabpagenr("$") == 1
                exec 'qa'
            else
                exec 'tabclose'
            endif
        endif
    endif
endfun
autocmd BufWinLeave * call NoExcitingBuffersLeft()
