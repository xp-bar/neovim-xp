function! s:session_list(ArgLead, CmdLine, CursorPos)
    if (a:CmdLine =~ " .* ")
        return [
            \ "save",
            \ "restore"
            \ ]
    else
        return systemlist('ls ' . g:sessions_dir)
    endif
endfunction

function! s:session(...)
    if (a:0 > 1)
        let session = g:sessions_dir . a:1
        let do = a:2

        if (do == "save")
            exe 'mks!' session
        elseif (do == "restore")
            exe 'source' session
        endif
    else
        let session = '~/vim-sessions/' . a:1
        exe 'source' session
    endif
endfunction

command! -nargs=* -complete=customlist,s:session_list Session call s:session(<f-args>)
