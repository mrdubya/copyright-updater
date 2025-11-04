"=============================================================================
" Automatic copyright notice year updater plugin for VIM.
"
" Copyright (C) 2023-2025 Mike Williams. All rights reserved.
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

" Types of Copyright year update supported
let s:year_range = "range"
let s:single_year = "single"

"~~~
" DoUpdate() - Update Copyright notice for an owner
" owner: string to match Copyright owner
" year_format: type of Copyright year to update
" -
function! <SID>DoUpdate(owner, year_format)
	if &modified && (!exists("b:do_update") || b:do_update == 1)
		let save_cursor = getcurpos()
		if a:year_format == s:year_range
			silent! exe "keepjumps keeppatterns %s#\\(\\cCopyright \\((C) \\)\\?\\(".strftime("%Y")."\\)\\@!\\d\\{4\\}\\)\\(-\\(".strftime("%Y")."\\)\\@!\\d\\{4\\}\\)\\?\\( ".a:owner."\\)#\\1-".strftime("%Y")." ".a:owner
		elseif a:year_format == s:single_year
			silent! exe "keepjumps keeppatterns %s#\\(\\cCopyright \\((C) \\)\\?\\)\\(\\(".strftime("%Y")."\\)\\@!\\d\\{4\\}\\)\\(-\\(".strftime("%Y")."\\)\\@!\\d\\{4\\}\\)\\?\\( ".a:owner."\\)#\\1".strftime("%Y")." ".a:owner
		endif
		call setpos('.', save_cursor)
	endif
endfunc

"~~~
" copyright#UpdateEndYearFor() - Set up who to update Copyright end date for
" -
function! copyright#UpdateEndYearFor(...)
	augroup CopyrightUpdater
		for whom in a:000
			exe "autocmd BufWritePre ".g:cpyupdtFiletypes." :call <SID>DoUpdate('".whom."', '".s:year_range."')"
		endfor
	augroup END
endfunc

"~~~
" copyright#UpdateFor() - Set up who to update Copyright end date for
" Deprecated, replaced by copyright#UpdateRangeFor()
" -
function! copyright#UpdateFor(...)
	augroup CopyrightUpdater
		for whom in a:000
			exe "autocmd BufWritePre ".g:cpyupdtFiletypes." :call <SID>DoUpdate('".whom."', '".s:year_range."')"
		endfor
	augroup END
endfunc

"~~~
" copyright#UpdateYearFor() - Set up who to update Copyright date for
" -
function! copyright#UpdateYearFor(...)
	augroup CopyrightUpdater
		for whom in a:000
			exe "autocmd BufWritePre ".g:cpyupdtFiletypes." :call <SID>DoUpdate('".whom."', '".s:single_year."')"
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
