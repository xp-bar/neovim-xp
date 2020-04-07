function! s:where(...)
    let l:result = expand("%")

    let l:args = join(a:000)

    if (l:args =~ "--lnum")
        let l:result .= ' +' . line('.')
    endif

    if (l:args =~ "--comment")
        let l:result .= ' // ' . getline('.')
    endif
    
    " copy to pasteboard
    let @* = l:result
    echom @*
endfunction

command! -nargs=* Where call s:where(<f-args>)
