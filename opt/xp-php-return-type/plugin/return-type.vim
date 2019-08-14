function! s:ReturnType()
    if (&ft=='php')
        let type_line = search('@return[ ]\zs.*\ze', 'bWn')
        let dirty_type = getline(type_line)
        let type_declaration = substitute(dirty_type, '^.*@return[ ]', '', '')
        let types = split(type_declaration, '|')
        let null_index = match(types, 'null')
        let types_without_null = types
        let null_type = ""

        if (null_index != -1)
            let null_type = remove(types_without_null, null_index)
        endif

        let type = types_without_null[0]

        if (len(types_without_null) >= 2)
            echom "Sorry, too many types being returned."
            return 1
        endif

        if (null_index != -1)
            let type = "?" . type
        endif

        call setline('.', getline('.') . ': ' . type)
    endif
endfunction

command! ReturnType call s:ReturnType()
