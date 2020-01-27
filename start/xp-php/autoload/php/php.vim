function! php#php#namespace()
    if (&ft=='php')
        call inputsave()

        let l:root = $ROOT_NAMESPACE != "" ? $ROOT_NAMESPACE : input('Enter Root: ')
        let l:file = @%
        let l:path = matchstr(l:file, '^\zs.*\ze\/.*\..*$')
        let l:parsed = substitute(l:path, '^\zsapp\ze', l:root, '')
        let l:namespace = 'namespace ' . substitute(l:parsed, '\/', '\', 'g') .';'

        call append(1, ['', l:namespace, ''])
        call inputrestore()
    endif
endfunction
