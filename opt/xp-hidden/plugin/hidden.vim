function! s:hidden(...)
    let l:listchars = ''
    if a:0 == 0
        let l:listchars='tab:>\ ,space:·,nbsp:␣,trail:-,eol:$'
    else
        for i in a:000
            if i == 'tab'
                let l:listchars = l:listchars . 'tab:>\ ,'
            elseif i == 'space'
                let l:listchars = l:listchars . 'space:·,'
            elseif i == 'nbsp'
                let l:listchars = l:listchars . 'nbsp:␣,'
            elseif i == 'trail'
                let l:listchars = l:listchars . 'trail:-,'
            elseif i == 'eol'
                let l:listchars = l:listchars . 'eol:$,'
            endif
        endfor
    endif

    let &listchars = substitute(l:listchars, ',$', '', '')

    if &list == 'nolist'
        set list
    else
        set nolist
    endif
endfunction

command! -nargs=* Hidden call s:hidden(<f-args>)
