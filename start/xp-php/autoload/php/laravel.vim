" -- goto blade partials -- {{{
" Thanks @ian-paterson  https://github.com/ian-paterson
function! php#laravel#GoToPartial()
  normal "lyi'
  let partial = @l
  let file = substitute(partial, "\\.", "/", "g")
  execute "edit resources/views/" . file . ".blade.php"
endfunction
" -- }}}
