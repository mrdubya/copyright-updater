"=============================================================================
" Plugin to provide intelligent automatic copyright updating.
" File:    copyright.vim
" Author:  Mike Williams (mrmrdubya@gmail.com)
" Changed: 9th September 2009
"
" See LICENSE.
"

" Finish if plugin already loaded
if exists("loaded_copyrightupdater")
	finish
endif
let loaded_copyrightupdater = 1

" Default is do for all file types
if !exists("g:cpyupdtFiletypes")
	let g:cpyupdtFiletypes = '*'
endif

"~~~
" UpdateCopyright() - Function that updates any copyright statements
" -
function! <SID>DoUpdate(owner)
	if &modified
		silent! exe "g#\\cCopyright \\((C) \\)\\?\\(".strftime("%Y")."\\)\\@!\\d\\{4\\}\\(-\\(".strftime("%Y")."\\)\\@!\\d\\{4\\}\\)\\? ".a:owner."#s#\\(\\d\\{4\\}\\)\\(-\\d\\{4\\}\\)\\?#\\1-".strftime("%Y")
	endif
endfunc

function! UpdateCopyright(who)
	exe "autocmd BufWritePre ".g:cpyupdtFiletypes." :call <SID>DoUpdate(".a:who.")"
endfunc

" eof
