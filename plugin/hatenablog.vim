if exists('g:loaded_hatenablog')
	finish
endif
let g:loaded_blog = 1

let s:save_cpo = &cpo
set cpo&vim

let &cpo = s:save_cpo
unlet s:save_cpo

