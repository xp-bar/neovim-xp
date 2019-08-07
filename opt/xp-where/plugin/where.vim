function! s:where()
    let @* = expand("%")
    echom @*
endfunction

command! Where call s:where()
