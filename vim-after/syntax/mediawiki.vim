" mediawiki.vim (formerly named Wikipedia.vim)
" 
" Vim syntax file
" Language: MediaWiki, http://www.mediawiki.org/
" Hal's local settings

setlocal textwidth=0 " no line wrapping
setlocal spell " let's use that spell checker!
setlocal linebreak  " don't split words in the window

" below taken from http://en.wikipedia.org/wiki/Wikipedia:Text_editor_support#Additional_Gimmicks

" utf-8 should be set if not already done globally
setlocal fileencoding=utf-8
setlocal matchpairs+=<:>
 
" Treat lists, indented text and tables as comment lines and continue with the
" same formatting in the next line (i.e. insert the comment leader) when hitting
" <CR> or using "o".
setlocal comments=n:#,n:*,n:\:,s:{\|,m:\|,ex:\|} 
setlocal formatoptions+=roq
 
" match HTML tags (taken directly from $VIM/ftplugin/html.vim)
if exists("loaded_matchit")
    let b:match_ignorecase=0
    let b:match_skip = 's:Comment'
    let b:match_words = '<:>,' .
    \ '<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,' .
    \ '<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,' .
    \ '<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'
endif
 
" Other useful mappings
" Insert a matching = automatically while starting a new header.
inoremap <buffer> <silent> = <C-R>=(getline('.')==''\|\|getline('.')=~'^=\+$')?"==\<Lt>Left>":"="<CR>
 
" Enable folding based on ==sections==
" N.B. hwine set _all_ levels to be foldable (the '-0')
setlocal foldexpr=getline(v:lnum)=~'^\\(=\\+\\)[^=]\\+\\1\\(\\s*<!--.*-->\\)\\=\\s*$'?\">\".(len(matchstr(getline(v:lnum),'^=\\+'))-0):\"=\"
setlocal fdm=expr

" vim: set et sts=2 sw=2:
