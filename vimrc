" Vundle setup
if isdirectory($HOME . "/.vim")
set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/Vundle.vim'

" My plugins here:
"
"Bundle 'Rykka/riv.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'klen/python-mode'
"Bundle 'davidoc/taskpaper.vim'
"Plugin 'RST-Tables'
Plugin 'kchmck/vim-coffee-script'
Plugin 'vim-scripts/vimwiki'
Plugin 'chikamichi/mediawiki.vim.git'
Plugin 'mileszs/ack.vim'
Plugin 'will133/vim-dirdiff'
Plugin 'hrj/vim-DrawIt'
Plugin 'mattn/calendar-vim'
Plugin 'scrooloose/nerdtree'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-sleuth'
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'

" original repos on GitHub
""Bundle 'tpope/vim-fugitive'
""Bundle 'Lokaltog/vim-easymotion'
""Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
""Bundle 'tpope/vim-rails.git'
" vim-scripts repos
""Bundle 'L9'
""Bundle 'FuzzyFinder'
" non-GitHub repos
""Bundle 'git://git.wincent.com/command-t.git'
""" Git repos on your local machine (i.e. when working on your own plugin)
""Bundle 'file:///Users/gmarik/path/to/plugin'
""" ...
call vundle#end()

"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed (on same line)
endif

filetype plugin indent on
syntax on
"version 6.0
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
function! PreviewReST()
    silent exec "!rst2html.py '%' > /tmp/rstprev.html && open /tmp/rstprev.html"
    redraw!
endfunction
:nnoremap <C-p><C-r> :call PreviewReST()<CR>
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
        silent exec "!open '".@0."'" 
        echom "opened ".@0 | redraw!
    else
        echo "No URL under cursor."
    endif
endfunction
nnoremap <leader>u :call OpenUrlUnderCursor()<CR>

filetype plugin indent on

" from kovidgoyal http://www.mobileread.com/forums/showthread.php?t=103114
au BufReadCmd   *.epub      call zip#Browse(expand("<amatch>"))

" test of pylint
let g:pymode_lint_checker = "pyflakes,pylint,pep8" 

" from learning vimscript the hard way  
set shiftround  " < & > always work with multiples of sw
" edit vimrc, then source it
:nnoremap <leader>ev :split $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>
" set a new escape from insert, and disable the old one
:inoremap jk <esc>
:inoremap <esc> <nop>
" sign
:iabbrev @@ --Hal Wine<cr>hwine@mozilla.com
set fileformats="unix,dos"

set hidden
" workaround for https://github.com/klen/python-mode/issues/342
" plus mkdir ~/.ropeproject ; chmod $_ 0000
let g:pymode_rope_lookup_project = 0
" from :help DiffOrig (via
" http://stackoverflow.com/questions/63104/smarter-vim-recovery#comment-33100858
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
    \ | diffthis | wincmd p | diffthis
" vim: set ft=vim :
