if exists('g:loaded_hatenablog')
	finish
endif
let g:loaded_hatenablog = 1

command! PostHatenaBlog :call hatenablog#post()
