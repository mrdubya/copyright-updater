"=============================================================================
" Plugin to provide intelligent automatic copyright updating.
" File:    copyright.vim
" Author:  Mike Williams (mrmrdubya@gmail.com)
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
" DoUpdate() - Update copyright statements for specific owner
" -
function! <SID>DoUpdate(owner)
	if &modified
		silent! exe "g#\\cCopyright \\((C) \\)\\?\\(".strftime("%Y")."\\)\\@!\\d\\{4\\}\\(-\\(".strftime("%Y")."\\)\\@!\\d\\{4\\}\\)\\? ".a:owner."#s#\\(\\d\\{4\\}\\)\\(-\\d\\{4\\}\\)\\?#\\1-".strftime("%Y")
	endif
endfunc

"~~~
" copyright#UpdateFor() - Set up who to update copyright for
" -
function! copyright#UpdateFor(...)
	augroup CopyrightUpdater
		for whom in a:000
			exe "autocmd BufWritePre ".g:cpyupdtFiletypes." :call <SID>DoUpdate('".whom."')"
		endfor
	augroup END
endfunc

" eof
