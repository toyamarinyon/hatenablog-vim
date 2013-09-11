scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

let s:title_extract_regex = '^#TITLE \?= \?\(.*\)#$'
let s:exist_title_in_buffer = 0

let s:api_base_url = 'http://blog.hatena.ne.jp/'
let s:api_endpoint = '/atom/entry'

if !exists('g:hatenablog_config')
	let g:hatenablog_config = {
				\ 'username'  exists('$HATENABLOG_USERNAME') ? $HATENABLOG_USERNAME : '',
				\ 'password'  exists('$HATENABLOG_PASSWORD') ? $HATENABLOG_PASSWORD : '',
				\ 'domain'    exists('$HATENABLOG_DOMAIN') ? $HATENABLOG_DOMAIN : ''
				\}
endif

function! hatenablog#post()
	if !s:validateConfig()
		echoerr 'configuration error. set g:hatenablog_config.'
		return
	endif

	let entry = webapi#atom#newEntry()
	call entry.setTitle(s:getTitle())
	call entry.setContentType('text/html')
	call entry.setContent(s:getContent())
	call webapi#atom#createEntry(
				\ s:api_base_url.g:hatenablog_config.username.'/'.g:hatenablog_config.domain.s:api_endpoint,
				\ g:hatenablog_config.username,
				\ g:hatenablog_config.password,
				\ entry
				\)
	echo 'Done! :)'
endfunction

function! s:getTitle()
	if s:existTitleInBuffer()
		return substitute(getline(1), s:title_extract_regex, '\1', '')
	endif
	return input('タイトルを入力して下さい： ')
endfunction

function! s:getContent()
	let offset = s:existTitleInBuffer() ? 2 : 1
	return join(getline(offset, line('$')), "\n")
endfunction

function! s:existTitleInBuffer()
	return getline(1) =~ s:title_extract_regex
endfunction

function! s:validateConfig()
	return g:hatenablog_config.username != '' &&
			\ g:hatenablog_config.password != '' &&
			\ g:hatenablog_config.domain != ''
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
