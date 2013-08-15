" Vim syntax file
" Language:         reStructuredText documentation format
" Local modification

" set formatoptions+=a " auto format, with <F9> to toggle
map <F9>   :se fo-=a<CR>
map <S-F9> :se fo+=a<CR>
set comments=fb:#.,fb:-,fb:*    " get rid of C comments
                                " * for bullet list

set nosmartindent   " don't want "comments in column 0" feature
