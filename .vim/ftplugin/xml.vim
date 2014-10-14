setlocal number

" turn syntax highlighting off for XML files
syntax off
" restore syntax highlight
autocmd BufLeave * :syntax on

" colorscheme wombat256

" Remove trailing whitespaces when writing buffer down:
" http://makandracards.com/makandra/11541-how-to-not-leave-trailing-whitespace-using-your-editor-or-git
autocmd BufWritePre * :%s/\s\+$//e
