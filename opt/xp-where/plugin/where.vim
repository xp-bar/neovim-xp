function! s:where(...)
    " Get the line and column of the visual selection marks
    let [lnum1, col1] = getpos("'<")[1:2]
    " let [lnum2, col2] = getpos("'>")[1:2]

    let l:args = join(a:000)
    let l:result = expand(l:args =~ '--short' ? '%:t' : '%')

    if (lnum1 > 0)
        let l:result .= ' +' . lnum1
    endif

    if (l:args =~ "--comment")
        let l:result .= ' // ' . trim(getline('.'))
    endif
    
    " copy to pasteboard
    let @* = l:result
    echom @*
endfunction

command! -range -nargs=* Where <line1>,<line2>call s:where(<f-args>)
