
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
