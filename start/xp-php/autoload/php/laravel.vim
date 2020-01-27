" -- goto blade partials -- {{{
" Thanks @ian-paterson  https://github.com/ian-paterson
function! php#laravel#GoToPartial()
  normal "lyi'
  let partial = @l
  let file = substitute(partial, "\\.", "/", "g")
  execute "edit resources/views/" . file . ".blade.php"
endfunction
" -- }}}

" -- ACK with blade -- {{{
function! php#laravel#blade_files(...)
    let path = ""

    if (a:0 == 1)
        let path = a:1
    endif

    call fzf#run({
        \ 'source': 'ack --blade -f ' . path,
        \ 'sink': 'e',
        \ 'down': '40%'
        \ })
endfunction
"  }}}
