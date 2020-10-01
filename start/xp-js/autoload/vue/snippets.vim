function! vue#snippets#set_mutator(...)
    let l:type = input('Type: ')
    let l:property = input('Parameter: ')
    let l:snake_property = substitute(
        \       l:property,
        \       '\([a-z]\)\([A-Z]\)',
        \       '\1\L_\2',
        \       'g'
        \)
    let l:pascal_property = substitute(
        \   l:snake_property,
        \   '^\([a-z]\)',
        \   '\U\1',
        \   'g'
        \)

    call append(line('.'), [
        \ '    /**',
        \ '     * Mutator for ' . l:property,
        \ '     *',
        \ '     * @param {Object} state',
        \ '     * @param {'. l:type .'} ' . l:property,
        \ '     */',
        \ '    set' . l:pascal_property . '(state, ' . l:property . ') {',
        \ '        state.' . l:property . ' = ' . l:property . ';',
        \ '    },'
        \   ])
endfunction

function! vue#snippets#get_getter(...)
    let l:type = input('Type: ')
    let l:property = input('Parameter: ')
    let l:snake_property = substitute(
        \       l:property,
        \       '\([a-z]\)\([A-Z]\)',
        \       '\1\L_\2',
        \       'g'
        \)
    let l:pascal_property = substitute(
        \   l:snake_property,
        \   '^\([a-z]\)',
        \   '\U\1',
        \   'g'
        \)

    call append(line('.'), [
        \ '    /**',
        \ '     * Getter for ' . l:property,
        \ '     *',
        \ '     * @param {Object} state',
        \ '     * @param {'. l:type .'} state.' . l:property,
        \ '     * @return {'. l:type .'}',
        \ '     */',
        \ '    get' . l:pascal_property . '({' . l:property . '}) {',
        \ '        return ' . l:property . ';',
        \ '    },'
        \   ])
endfunction

function! s:vue_import_handler(file)
    let l:component_path = a:file
    let l:kebab_component_name = fnamemodify(l:component_path, ':t:r')
    let l:regex = "\\([a-z]\\)\-\\([a-z]\\)"
    let l:replacer = '\=submatch(1).toupper(submatch(2))'
    let l:camel_component_name = substitute(l:kebab_component_name, l:regex, l:replacer, 'g')
    let l:component_path_no_ext = fnamemodify(l:component_path, ':r')

    call append(line('.'), [
        \       'const ' . l:camel_component_name . ' = async () => {',
        \       '    const Component = await import(',
        \       '        /* webpackChunkName: "' . l:kebab_component_name . '" */',
        \       "        '" . l:component_path_no_ext . "'",
        \       '    );',
        \       '',
        \       '    return Component.default;',
        \       '};',
        \   ])
endfunction

function! vue#snippets#webpack_async_import()
    call fzf#run({
    \   'source': 'ack -f --vue',
    \   'options': '-i',
    \   'sink': function('s:vue_import_handler'),
    \   'down': '40%'
    \   })

    doautocmd User WebpackImportPost
endfunction

function! vue#snippets#vue_files(...)
    let path = ""

    if (a:0 == 1)
        let path = a:1
    endif

    call fzf#run({
        \ 'source': 'ack --vue -f ' . path,
        \ 'sink': 'e',
        \ 'down': '40%'
        \ })
endfunction
