"set nomacatsui
set gfn=Courier:h18
colorscheme desert
" word count from http://www.cromwell-intl.com/unix/vim-word-count.html
function UpdateWordCount()
	let lnum = 1
	let n = 0
	while lnum <= line('$')
		let n = n + len(split(getline(lnum)))
		let lnum = lnum + 1
	endwhile
	let g:word_count = n
endfunction
