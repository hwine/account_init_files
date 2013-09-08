" Vim syntax file
" Language:         Python
" Local modification


"set nosmartindent   " don't want "comments start in column 0" feature
:inoremap # X#
:setlocal colorcolumn=80
" ipython breakpoint
:nnoremap <leader>i Ofrom IPython import embed; embed(header="IPy")  # XXX
" rail -- missing BadFormat in my setup
"autocmd BufRead,BufnewFile *.py match BadFormat /\(\%80v.\+\)\|\(^\t\+\)\|\(\s\+$\)/
