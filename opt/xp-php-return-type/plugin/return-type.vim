function! s:ReturnType()
    if (&ft=='php')
        let max_backward = line('.') - 2
        let type_line = search('@return[ ]\zs.*\ze', 'bWn', max_backward)

        if (type_line == 0)
            let type = "void"
        else
            let dirty_type = getline(type_line)
            let type_declaration = substitute(dirty_type, '^.*@return[ ]', '', '')
            let types = split(type_declaration, '|')
            let null_index = match(types, 'null')
            let types_without_null = types
            let null_type = ""

            if (null_index != -1)
                let null_type = remove(types_without_null, null_index)
            endif

            let type = get(types_without_null, 0, v:null)

            if (len(types_without_null) >= 2)
                echom "Sorry, too many types being returned."
                return 1
            endif

            if (null_index != -1)
                if (type != v:null)
                    let type = "?" . type
                else
                    let type = null_type
                endif
            endif
        endif
        
        call setline('.', getline('.') . ': ' . type)
    endif
endfunction

noremap <unique> <script> <Plug>XpReturnType <SID>ReturnType
noremap <silent> <SID>ReturnType :call <SID>ReturnType()<CR>

if !hasmapto('<Plug>XpReturnType')
    map <unique> <Leader>r <Plug>XpReturnType
endif
