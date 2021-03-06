function! s:ReturnType()
    if (&ft=='php')
        let is_func = search('function', 'Wcn', line('.'))

        if (is_func == 0)
            echom "Not a function"
            return 1
        endif

        let max_backward = line('.') - 4
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

nmap <silent> <SID>ReturnType :call <SID>ReturnType()<CR>

if mapcheck('<Plug>XpReturnType') == ""
    nmap <unique> <script> <Plug>XpReturnType <SID>ReturnType
endif

if mapcheck('<Leader>r') == ""
    map <unique> <Leader>r <Plug>XpReturnType
endif
