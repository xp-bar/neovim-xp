" https://vim.fandom.com/wiki/Add_a_newline_after_given_patterns
function! s:LineBreakAt(bang, ...) range
    let save_search = @/

    if empty(a:bang)
        let before = ''
        let after = '\ze.'
        let repl = '&\r'
    else
        let before = '.\zs'
        let after = ''
        let repl = '\r&'
    endif
    " let l:pat_list = map(deepcopy(a:000), "escape(v:val, '/\\.*$^~[')")
    let l:pat_list = map(deepcopy(a:000), "escape(v:val, '/\\.*$^~')")
    let l:find = empty(l:pat_list) ? @/ : join(l:pat_list, '\|')
    let l:find = before . '\%(' . l:find . '\)' . after
    " Example: 10,20s/\%(arg1\|arg2\|arg3\)\ze./&\r/ge
    execute a:firstline . ',' . a:lastline . 's/'. l:find . '/' . repl . '/ge'

    " reindent the lines
    mark q
    normal gvg`q=jk
    delmarks q

    let @/ = save_search
endfunction

command! -bang -nargs=* -range Unjoin <line1>,<line2>call <sid>LineBreakAt('<bang>', <f-args>)
