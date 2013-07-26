" Pathogen load
execute pathogen#infect()
" Pathogen load of python-mode
filetype off

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on
version 6.0
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
map! <Home> <Home>
map! <End> <End>
map! <S-F4> <S-F4>
map! <S-F3> <S-F3>
map! <S-F2> <S-F2>
map! <S-F1> <S-F1>
map! <F4> <F4>
map! <F3> <F3>
map! <F2> <F2>
map! <F1> <F1>
cmap <D-g> <D-g>
imap <D-g> <D-g>
cmap <D-f> <D-f>
imap <D-f> <D-f>
cmap <D-a> <D-a>
imap <D-a> <D-a>
cnoremap <D-v> +
cnoremap <D-c> 
cmap <D-z> <D-z>
imap <D-z> <D-z>
cmap <S-D-s> <D-s>
imap <S-D-s> <D-s>
cmap <D-s> <D-s>
imap <D-s> <D-s>
cmap <D-w> <D-w>
imap <D-w> <D-w>
cmap <D-o> <D-o>
imap <D-o> <D-o>
cmap <D-n> <D-n>
imap <D-n> <D-n>
nmap gx <Plug>NetrwBrowseX
map <Home> <Home>
map <End> <End>
map <S-F4> <S-F4>
map <S-F3> <S-F3>
map <S-F2> <S-F2>
map <S-F1> <S-F1>
map <F4> <F4>
" map <F3> <F3>
" map <F2> <F2>
map <F3> <Esc>:setlocal nospell<CR>
map <F2> <Esc>:setlocal spell spelllang=en_us<CR>
map <F1> <F1>
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetBrowseX(expand("<cWORD>"),0)
omap <D-g> <D-g>
vmap <D-g> <D-g>
nnoremap <D-g> n
omap <D-f> <D-f>
vmap <D-f> <D-f>
nnoremap <D-f> /
omap <D-a> <D-a>
vmap <D-a> <D-a>
nnoremap <silent> <D-a> :if &slm != ""|exe ":norm gggHG"| else|exe ":norm ggVG"|endif
omap <D-z> <D-z>
vmap <D-z> <D-z>gv
nnoremap <D-z> u
omap <S-D-s> <D-s>
vmap <S-D-s> <D-s>gv
nnoremap <S-D-s> :browse confirm saveas
omap <D-s> <D-s>
vmap <D-s> <D-s>gv
nnoremap <silent> <D-s> :if expand("%") == ""|browse confirm w| else|confirm w|endif
omap <D-w> <D-w>
vmap <D-w> <D-w>gv
nnoremap <silent> <D-w> :if winheight(2) < 0 | confirm enew | else | confirm close | endif
omap <D-o> <D-o>
vmap <D-o> <D-o>gv
nnoremap <D-o> :browse confirm e
omap <D-n> <D-n>
vmap <D-n> <D-n>gv
nnoremap <D-n> :confirm enew
vmap <BS> "-d
vnoremap <D-x> "+x
vnoremap <D-c> "+y
nnoremap <D-v> "+gP
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set backspace=2
set background=dark
set expandtab
" set helplang=en
set incsearch
set laststatus=2
set mouse=a
set shiftwidth=4
set softtabstop=4
set textwidth=72
set nowrapscan
syntax on
set modelines=3
set hlsearch
set nocompatible
set smartindent
set nospell
set showcmd
set statusline=%f%m%r%h%w\ [%{&ff}]\ %y%=[\%03.3b/\%02.2B]\ (%v,%l/%L)[%p%%]
:command! Rst :!rst2html.py "%" > /tmp/rstprev.html && open /tmp/rstprev.html
:nnoremap <C-p><C-r> :Rst<CR>
au BufReadCmd *.jar,*.xpi,*.egg call zip#Browse(expand("<amatch>"))
"
" open URL under cursor (Mac version)
" from:
" http://stackoverflow.com/questions/9458294/open-url-under-cursor-in-vim-with-browser#abc_def
function! OpenUrlUnderCursor()
    " let path="/Applications/Safari.app"
    execute "normal BvEy"
    " add '#' to match fragments, '&', '?' for query strings
    let url=matchstr(@0, '[a-z]*:\/\/[^ >,;]*')
    if url != ""
        " silent exec "!open -a ".path." '".url."'" | redraw! 
        " silent exec "!open '".url."'" | redraw! 
        exec "!open '".@0."'" 
        echom "opened ".@0
    else
        echo "No URL under cursor."
    endif
endfunction
nmap <leader>u :call OpenUrlUnderCursor()<CR>

filetype plugin indent on

" from kovidgoyal http://www.mobileread.com/forums/showthread.php?t=103114
au BufReadCmd   *.epub      call zip#Browse(expand("<amatch>"))

" test of pylint
let g:pymode_lint_checker = "pyflakes,pylint,pep8" 

" from learning vimscript the hard way
set shiftround  " < & > always work with multiples of sw
" set fileformats=unix
" vim: set ft=vim :
