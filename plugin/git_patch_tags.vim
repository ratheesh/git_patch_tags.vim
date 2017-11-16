"---------------------------------------------------------------------------
" Global plugin for adding patch tags from linux SubmittingPatches document
" Maintainer:  Antonio Ospite <ospite@studenti.unina.it>
" Version:     0.2
" Last Change: 2013-10-11
" License:     This script is free software; you can redistribute it and/or
"              modify it under the terms of the GNU General Public License.
"
" Description:
"
" Global plugin for adding patch tags as defined in the linux kernel
" Documentation/SubmittingPatches document, examples of patch tags are:
"  - Acked-by
"  - Signed-off-by
"  - Tested-by
"  - Reviewed-by
"
" the plugin allows to add also a Copyright line.
"
" The author name and email address are retrieved from the git configuration.
"
" Install Details:
" Drop this file into your $HOME/.vim/plugin directory.
"
" Keybindings:
" <Leader>ca
" 	Add a Acked-by: tag getting developer info from git config
"
" <Leader>cc
" 	Add a Cc: tag asking info from user
"
" <Leader>cr
" 	Add a Reviewed-by tag getting developer info from git config
"
" <Leader>cR
" 	Add a Reported-by tag asking info from user
"
" <Leader>cs
" 	Add a Signed-off-by tag getting developer info from git config
"
" <Leader>ct
" 	Add a Tested-by tag getting developer info from git config
"
" References:
" http://elinux.org/Developer_Certificate_Of_Origin
" http://lxr.linux.no/source/Documentation/SubmittingPatches
"

if exists("g:loaded_gitPatchTagsPlugin") | finish | endif
let g:loaded_gitPatchTagsPlugin = 1

" user local mapping to avoid conflict plugin's keymapping
autocmd FileType gitcommit map <Leader>ca :call GitAck()<CR>
" map <Leader>cpy :call GitCopyright()<CR>
autocmd FileType gitcommit map <Leader>cc :call GitCC()<CR>
autocmd FileType gitcommit map <Leader>cR :call GitReporter()<CR>
autocmd FileType gitcommit map <Leader>cr :call GitReviewed()<CR>
autocmd FileType gitcommit map <Leader>cs :call GitSignOff()<CR>
autocmd FileType gitcommit map <Leader>ct :call GitTested()<CR>

" Get developer info from git config
funct! GitGetAuthor()
	" Strip terminating NULLs to prevent stray ^A chars (see :help system)
	return system('git config --null --get user.name | tr -d "\0"') .
	      \ ' <' . system('git config --null --get user.email | tr -d "\0"') . '>'
endfunc

" Add a Acked-by tag getting developer info from git config
funct! GitAck()
	exe 'put =\"Acked-by: ' . GitGetAuthor() . '\"'
endfunc

" Add a CC line asking for info from User
funct! GitCC()
	let cc_info = input("CC To: ")
	exe 'put =\"Cc: '   . cc_info . '\"'
endfunc

" Add a Reported-by line asking for info from User
funct! GitReporter()
	let user_info = input("Reported by: ")
	exe 'put =\"Reported-by: '   . user_info . '\"'
endfunc

" Add a copyright line getting developer info from git config and using
" the current date
funct! GitCopyright()
	let date = strftime("%Y")
	exe 'put =\"Copyright (C) ' . date . '  ' . GitGetAuthor() . '\"'
endfunc

" Add a Reviewed-by tag getting developer info from git config
funct! GitReviewed()
	exe 'put =\"Reviewed-by: ' . GitGetAuthor() . '\"'
endfunc

" Add a Signed-off-by tag getting developer info from git config
funct! GitSignOff()
	exe 'put =\"Signed-off-by: ' . GitGetAuthor() . '\"'
endfunc

" Add a Tested-by tag getting developer info from git config
funct! GitTested()
	exe 'put =\"Tested-by: ' . GitGetAuthor() . '\"'
endfunc

