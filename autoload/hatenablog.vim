scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

function! hatenablog#post()
	let entry = webapi#atom#createEntry()
	call entry.setContentType('text/html')
	call entry.setTitle(s:getTitle())
	call entry.setContent(s:getContent())
	echo 'call hatenablog#post!'
endfunction

function! s:getTitle()
	return input('エントリーのタイトル： ')
endfunction
function! s:getContent()
	return 'contents!'
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
