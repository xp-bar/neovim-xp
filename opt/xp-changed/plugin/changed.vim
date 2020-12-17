function s:all_changed_files()
    let l:files = systemlist('git --no-pager diff --name-only')
    if v:shell_error != 0
        return []
    endif

    return l:files
endfunction

function! s:filtered_files_to_only_not_open()
    return filter(copy(s:all_changed_files()), 'buflisted(v:val) == 0')
endfunction

function! s:changed_files_complete(ArgLead, CmdLine, CursorPos)
    if (a:CmdLine =~ " .* ")
        return []
    endif

    return s:filtered_files_to_only_not_open()
endfunction

function! s:open_qf_files(all)
    if a:all == v:false
        let l:files = s:filtered_files_to_only_not_open()
    else
        let l:files = s:all_changed_files()
    endif

    let l:mapped = map(l:files, '{"filename": v:val, "lnum": 1}')

    if len(l:mapped) == 0
        call setqflist([], 'r')
        cclose
        return
    endif

    call setqflist(l:mapped, 'r')
    botright copen
endfunction

function! s:changed(bang, ...)
    if a:0 == 0
        if (a:bang)
            call s:open_qf_files(v:true)
        else
            call s:open_qf_files(v:false)
        endif
        return
    endif

    exec 'edit ' . a:1
endfunction

command! -bang -nargs=* -complete=customlist,s:changed_files_complete Changed call s:changed(<bang>0, <f-args>)
