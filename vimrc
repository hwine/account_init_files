" Plug setup
if isdirectory($HOME . "/.vim")
    " For a paranoia.
    " Normally `:set nocp` is not needed, because it is done automatically
    " when .vimrc is found.
    if &compatible
        " `:set nocp` has many side effects. Therefore this should be done
        " only when 'compatible' is set.
        set nocompatible
    endif

    " just one set of packages, for vim8 & neovim
    set packpath^=~/.vim

    " only load minpac if we have packaging work to do. See commands below
    if exists('*minpac#init')
        " minpac is loaded.
        call minpac#init()
        call minpac#add('k-takata/minpac', {'type': 'opt'})

        """" vim-plug helper functions and settings
        """let g:ycm_server_python_interpreter = '/Users/hwine/.pyenv/versions/2.7.12/bin/python2'
        """function! BuildYCM(info)
        """  if a:info.status == 'installed' || a:info.force
        """    !./install.sh
        """  endif
        """endfunction

        " My plugins here:
        "
        call minpac#add('tbabej/taskwiki', { 'type': 'opt' })
        " call minpac#add('Rykka/riv.vim')
        "call minpac#add('Rykka/InstantRst')
        call minpac#add('kien/ctrlp.vim')
        call minpac#add('davidhalter/jedi-vim')
        call minpac#add('klen/python-mode')
        call minpac#add('christoomey/vim-tmux-navigator')
        "Bundle 'davidoc/taskpaper.vim')
        "call minpac#add(in 'RST-Tables')
        call minpac#add('Shutnik/jshint2.vim')
        call minpac#add('kchmck/vim-coffee-script')
        call minpac#add('vim-scripts/vimwiki')  " using RiV now
        call minpac#add('chikamichi/mediawiki.vim', { 'type': 'opt' })
        call minpac#add('mileszs/ack.vim')
        call minpac#add('will133/vim-dirdiff')
        call minpac#add('hrj/vim-DrawIt', { 'type': 'opt' })
        call minpac#add('mattn/calendar-vim')
        call minpac#add('scrooloose/nerdtree')
        """call minpac#add('Valloric/YouCompleteMe', { 'do': function('BuildYCM') })
        "call minpac#add('floobits/floobits-neovim')
        call minpac#add('tpope/vim-sleuth')
        call minpac#add('tpope/vim-surround')
        call minpac#add('tpope/vim-unimpaired')
        call minpac#add('tpope/vim-scriptease', {'type': 'opt'})
        call minpac#add('bling/vim-airline')
        call minpac#add('airblade/vim-gitgutter')
        call minpac#add('tpope/vim-fugitive')
        " from https://github.com/jbranchaud/til/blob/master/vim/view-commit-history-of-a-file.md
        call minpac#add('gregsexton/gitv')
        call minpac#add('chase/vim-ansible-yaml')
        call minpac#add('rhysd/committia.vim')
        call minpac#add('elmcast/elm-vim')
        call minpac#add('editorconfig/editorconfig-vim')
        call minpac#add('kannokanno/previm')

    endif

    " Define user commands for updating/cleaning the plugins.
    " Each of them loads minpac, reloads .vimrc to register the
    " information of plugins, then performs the task.
    command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
    command! PackClean packadd minpac | source $MYVIMRC | call minpac#clean()

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

" Don't autofold python
let g:pymode_folding = 0
" test of pylint
let g:pymode_lint_checker = "pyflakes,pylint,pep8"  " not working with
" latest pymode
" let g:pymode_lint_checker = "pyflakes,pep8" 
" turn the darn thing off (rope refactoring, with .ropeproject
" directories)
let g:pymode_rope = 0
" workaround for https://github.com/klen/python-mode/issues/342
" plus mkdir ~/.ropeproject ; chmod $_ 0000
let g:pymode_rope_lookup_project = 0
" From
" https://github.com/klen/python-mode/issues/342#issuecomment-167665367
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0


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
:if exists("*strftime")
" insert date & time from https://www.ibm.com/developerworks/library/l-vim-script-1/index.html
" done 2017-11-09 at 18:22
:inoremap <silent> <C-D><C-D> <C-R>=strftime("%Y-%m-%d")<CR>
:inoremap <silent> <C-T><C-T> <C-R>=strftime("%H:%M")<CR>
endif

set hidden
" from :help DiffOrig (via
" http://stackoverflow.com/questions/63104/smarter-vim-recovery#comment-33100858
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
    \ | diffthis | wincmd p | diffthis

" From http://unix.stackexchange.com/a/71631/150027
if has("gui_running")
    "echo "yes, we have a GUI"
    set mouse=a
else
    "echo "Boring old console"
    set mouse=
endif

" From http://calebthompson.io/crontab-and-vim-sitting-in-a-tree/
" allow edit of crontab on osx
autocmd filetype crontab setlocal nobackup nowritebackup

" From https://web-design-weekly.com/2013/09/01/a-better-git-commit/
" Improve handling of git commit messages
" Now done via Plug 'rhysd/committia.vim'
" autocmd Filetype gitcommit spell textwidth=72

"let &t_Co=256
colorscheme desert

" elm_format support
let g:elm_format_autosave = 1

" support for 'rg' if available
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" RiV Settings
" use sphinx style local links: :doc: & :download:
let g:riv_file_link_style=2
" set up projects
let p1 = { 'Name': 'SecOps', 'path': '~/wip/foxsec', }
let p2 = { 'Name': 'Geolocation API Key', 'path': '~/wip/projects',}
let p3 = { 'Name': 'My Note', 'path': '~/Documents/Riv', }
let g:riv_projects = [p1, p2, p3]
" Don't fold small chunks - more annoying in Riv
set foldminlines=10

" Previm settings
" Required setting to open files
let g:previm_open_cmd='open '
" 1=realtime; 0=on save only
let g:previm_enable_realtime = 1
" disable CSS
let g:previm_disable_default_css = 1
" show header with timestamp
let g:previm_show_header = 1

" Setup for vimwikis
" define just one wiki, use temporary wikis elsewhere
let wiki_1 = {}
let wiki_1.path = '~/vimwiki/'
let wiki_1.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}
let g:vimwiki_list = [wiki_1]

" use '.vwiki' for temp wikis, in markdown
let g:vimwiki_ext2syntax = { '.vwiki': 'default' }


" From tpope: https://sanctum.geek.nz/arabesque/vim-annoyances/
nnoremap n nzz
nnoremap } }zz

" Ideas from ulfr
" "Languages that use spaces, not tabs
" autocmd FileType js     :setlocal sw=4 ts=4 sts=4 expandtab
" autocmd FileType lua    :setlocal sw=2 ts=2 sts=2 expandtab
" autocmd FileType python :setlocal sw=4 ts=4 sts=4 expandtab
" autocmd FileType yaml   :setlocal sw=4 ts=4 sts=4 expandtab
" autocmd FileType pp     :setlocal sw=4 ts=4 sts=4 expandtab
" "Languages that use tabs, not spaces
" autocmd FileType php    :setlocal sw=3 ts=3 sts=3 noexpandtab
" autocmd FileType c      :setlocal sw=6 ts=6 sts=6 noexpandtab
" autocmd FileType cpp    :setlocal sw=4 ts=4 sts=4 noexpandtab
" autocmd FileType rst    :setlocal sw=4 ts=4 sts=4 noexpandtab wrap textwidth=80
" autocmd FileType go     :setlocal sw=6 ts=6 sts=6 noexpandtab
" autocmd FileType go     call tagbar#autoopen(0)
" autocmd FileType mediawiki  :setlocal sw=4 ts=4 sts=4 noexpandtab wrap linebreak textwidth=120
" autocmd FileType markdown   :setlocal sw=4 ts=4 sts=4 wrap linebreak textwidth=80
" vim: set ft=vim sw=4 sts=4 et:
