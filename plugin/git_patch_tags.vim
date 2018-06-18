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
"  - Cc
"  - Reported-by
"
" the plugin allows to add also a Copyright line.
"
" The author name and email address are retrieved from the git configuration.
"
" Install Details:
" Drop this file into your $HOME/.vim/plugin directory.
"
" Keybindings:
" <Plug>(GitAck)
"       Add a Acked-by: tag getting developer info from git config
"
" <Plug>(GitCC)
"       Add a Cc: tag asking info from user
"
" <Plug>(GitReviewed)
"       Add a Reviewed-by tag getting developer info from git config
"
" <Plug>(GitReporter)
"       Add a Reported-by tag asking info from user
"
" <Plug>(GitReviewed)
"       Add a Reviewed-by tag asking info from user
"
" <Plug>(GitSignOff)
"       Add a Signed-off-by tag getting developer info from git config
"
" <Plug>(GitTested)
"       Add a Tested-by tag getting developer info from git config
"
" References:
" http://elinux.org/Developer_Certificate_Of_Origin
" http://lxr.linux.no/source/Documentation/SubmittingPatches
"
if exists("g:loaded_gitPatchTagsPlugin") | finish | endif
let g:loaded_gitPatchTagsPlugin = 1

" Get developer info from git config
funct! GitGetAuthor()
    " Strip terminating NULLs to prevent stray ^A chars (see :help system)
    return system('git config --null --get user.name | tr -d "\0"') .
                \ ' <' . system('git config --null --get user.email | tr -d "\0"') . '>'
endfunc

" Add a Acked-by tag getting developer info from git config
funct! git_patch_tags#GitAck()
    exe 'put =\"Acked-by: ' . GitGetAuthor() . '\"'
endfunc

" Add a CC line asking for info from User
funct! git_patch_tags#GitCC()
    let cc_info = input("CC To(user <user@e-mail.com>)? ")
    exe 'put =\"Cc: '   . cc_info . '\"'
endfunc

" Add a Reported-by line asking for info from User
funct! git_patch_tags#GitReporter()
    let user_info = input("Reported by(user <user@e-mail.com>)? ")
    exe 'put =\"Reported-by: '   . user_info . '\"'
endfunc

" Add a copyright line getting developer info from git config and using
" the current date
funct! git_patch_tags#GitCopyright()
    let date = strftime("%Y")
    exe 'put =\"Copyright (C) ' . date . '  ' . GitGetAuthor() . '\"'
endfunc

" Add a Reviewed-by tag getting developer info from git config
funct! git_patch_tags#GitReviewed()
    exe 'put =\"Reviewed-by: ' . GitGetAuthor() . '\"'
endfunc

" Add a Signed-off-by tag getting developer info from git config
funct! git_patch_tags#GitSignOff()
    exe 'put =\"Signed-off-by: ' . GitGetAuthor() . '\"'
endfunc

" Add a Tested-by tag getting developer info from git config
funct! git_patch_tags#GitTested()
    exe 'put =\"Tested-by: ' . GitGetAuthor() . '\"'
endfunc

" Create Pluggable keybindings
nnoremap <silent><Plug>GitAck      :call git_patch_tags#GitAck()<CR>
nnoremap <silent><Plug>GitCC       :call git_patch_tags#GitCC()<CR>
nnoremap <silent><Plug>GitReporter :call git_patch_tags#GitReporter()<CR>
nnoremap <silent><Plug>GitReviewed :call git_patch_tags#GitReviewed()<CR>
nnoremap <silent><Plug>GitSignOff  :call git_patch_tags#GitReviewed()<CR>
nnoremap <silent><Plug>GitTested   :call git_patch_tags#GitTested()<CR>

