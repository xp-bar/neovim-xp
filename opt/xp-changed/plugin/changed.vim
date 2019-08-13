function! s:changed_files_complete(ArgLead, CmdLine, CursorPos)
    if (a:CmdLine =~ " .* ")
        return []
    endif

    let l:files = systemlist('git --no-pager diff --name-only')
    if v:shell_error != 0
        return []
    endif

    let l:filtered = filter(copy(l:files), 'buflisted(v:val) == 0')

    return l:filtered
endfunction

function! s:changed(file)
    exec 'edit ' . a:file
endfunction

command! -nargs=* -complete=customlist,s:changed_files_complete Changed call s:changed(<f-args>)
