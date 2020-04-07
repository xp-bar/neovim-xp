function! s:get_selected_text()
    " Get the line and column of the visual selection marks
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]

    " Get all the lines represented by this range
    let lines = getline(lnum1, lnum2)         

    " The last line might need to be cut if the visual selection didn't end on the last column
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    " The first line might need to be trimmed if the visual selection didn't start on the first column
    let lines[0] = lines[0][col1 - 1:]

    return join(lines, "\n")
endfunction

function! s:snake_case()
    call s:camel_case()
    let l:text = s:get_selected_text()
    let l:snaked = substitute(l:text, '\([a-z]\)\([A-Z]\)', '\1\L_\2', 'g')

    call setline('.', substitute(getline('.'), l:text, l:snaked, ''))
endfunction

function! s:kebab_case()
    call s:camel_case()
    let l:text = s:get_selected_text()
    let l:snaked = substitute(l:text, '\([a-z]\)\([A-Z]\)', '\1\L-\2', 'g')

    call setline('.', substitute(getline('.'), l:text, l:snaked, ''))
endfunction

function! s:pascal_case()
    call s:camel_case()
    let l:text = s:get_selected_text()
    let l:snaked = substitute(l:text, '^\([a-z]\)', '\U\1', 'g')

    call setline('.', substitute(getline('.'), l:text, l:snaked, ''))
endfunction

function! s:camel_case()
    let l:text = s:get_selected_text()
    let l:snaked = substitute(l:text, '\([a-z]\)[_-]\([a-z]\)', '\1\U\2', 'g')

    call setline('.', substitute(getline('.'), l:text, l:snaked, ''))
endfunction

command! -range Snake <line1>,<line2>call s:snake_case()
command! -range Kebab <line1>,<line2>call s:kebab_case()
command! -range Camel <line1>,<line2>call s:camel_case()
command! -range Pascal <line1>,<line2>call s:pascal_case()
