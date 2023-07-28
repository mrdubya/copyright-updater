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
command! CopyrToggleUpdate :call copyright#ToggleUpdate()
command! -nargs=1 CopyrUpdateFor :call copyright#UpdateFor(<args>)

" eof
