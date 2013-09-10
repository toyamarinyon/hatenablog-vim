scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

let s:title_extract_regex = '^#TITLE \?= \?\(.*\)#$'
let s:exist_title_in_buffer = 0 

function! hatenablog#post()
	let entry = webapi#atom#newEntry()
	call entry.setContentType('text/html')
	call entry.setTitle(s:getTitle())
	call entry.setContent(s:getContent())
endfunction

function! s:getTitle()
	if s:existTitleInBuffer()
		return substitute(getline('1'), s:title_extract_regex, '\1', '')
	endif
	return input('タイトルを入力して下さい： ')
endfunction

function! s:getContent()
	let offset = s:existTitleInBuffer() ? 2 : 1
	return join(getline(offset, line('$')), '\n')
endfunction

function! s:existTitleInBuffer()
	return getline('1') =~ s:title_extract_regex
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
