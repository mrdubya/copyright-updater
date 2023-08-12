"=============================================================================
" Automatic copyright notice year updater plugin for VIM.
"
" Copyright (C) 2023 Mike Williams. All rights reserved.
"
" See LICENSE.
"

" Finish if autoload plugin already loaded
if exists("loaded_copyrightupdater_autoload")
	finish
endif
let loaded_copyrightupdater_autoload = 1

let s:keepcpo = &cpo
set cpo&vim

" Default is do for all file types
if !exists("g:cpyupdtFiletypes")
	let g:cpyupdtFiletypes = '*'
endif

"~~~
" DoUpdate() - Update Copyright notice for an owner
" -
function! <SID>DoUpdate(owner)
	if &modified && (!exists("b:do_update") || b:do_update == 1)
		let save_cursor = getcurpos()
		silent! exe "keepjumps keeppatterns %s#\\(\\cCopyright \\((C) \\)\\?\\(".strftime("%Y")."\\)\\@!\\d\\{4\\}\\)\\(-\\(".strftime("%Y")."\\)\\@!\\d\\{4\\}\\)\\?\\( ".a:owner."\\)#\\1-".strftime("%Y")." ".a:owner
		call setpos('.', save_cursor)
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
" copyright#ToggleUpdate() - Turn updating Copyright year on or off for the
" buffer
" -
function! copyright#ToggleUpdate()
	" Updating starts, on so turn off with the first call
	if !exists("b:do_update")
		let b:do_update = 0
	else
		let b:do_update = 1 - b:do_update
	endif
endfunc

let &cpo = s:keepcpo
unlet s:keepcpo

" eof
