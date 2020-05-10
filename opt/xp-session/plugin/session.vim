function! s:session_list(ArgLead, CmdLine, CursorPos)
    if (a:CmdLine =~ " .* ")
        return [
            \ "save",
            \ "restore"
            \ ]
    else
        return systemlist('ls -t ' . g:sessions_dir)
    endif
endfunction

function! s:session(...)
    let session = g:sessions_dir . a:1
    let l:do = a:0 > 1 ? a:2 : "restore"

    if (l:do == "save" || filereadable(session) == 1)
        echo 'Saving Session...'
        exe 'mks!' session
        echo 'Saved!'
    elseif (l:do == "restore" && filereadable(session) == 0)
        echom 'Opening Session...'
        exe 'source' session
    endif
endfunction

command! -nargs=* -complete=customlist,s:session_list Session call s:session(<f-args>)
