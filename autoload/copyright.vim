"=============================================================================
" Automatic copyright notice year updater plugin for VIM.
"
" Copyright (C) 2023 Mike Williams. All rights reserved.
"
" See LICENSE.
"

" Finish if plugin already loaded
if exists("loaded_copyrightupdater")
	finish
endif
let loaded_copyrightupdater = 1

" Commands to control updating Copyright notice
command! CopyrToggleUpdate :call CopyrToggleUpdate()

" Default is do for all file types
if !exists("g:cpyupdtFiletypes")
	let g:cpyupdtFiletypes = '*'
endif

"~~~
" DoUpdate() - Update Copyright notice for an owner
" -
function! <SID>DoUpdate(owner)
	if &modified && (!exists("b:do_update") || b:do_update == 1)
		silent! exe "g#\\cCopyright \\((C) \\)\\?\\(".strftime("%Y")."\\)\\@!\\d\\{4\\}\\(-\\(".strftime("%Y")."\\)\\@!\\d\\{4\\}\\)\\? ".a:owner."#s#\\(\\d\\{4\\}\\)\\(-\\d\\{4\\}\\)\\?#\\1-".strftime("%Y")
	endif
endfunc

"~~~
" copyright#UpdateFor() - Set up who to update Copyright for
" -
function! copyright#UpdateFor(...)
	augroup CopyrightUpdater
		for whom in a:000
			exe "autocmd BufWritePre ".g:cpyupdtFiletypes." :call <SID>DoUpdate('".whom."')"
		endfor
	augroup END
endfunc

"~~~
" CopyrToggleUpdate() - turn updating Copyright year on or off for the buffer
" -
function! CopyrToggleUpdate()
	" Updating starts, on so turn off with the first call
	if !exists("b:do_update")
		let b:do_update = 0
	else
		let b:do_update = 1 - b:do_update
	endif
endfunc

" eof
