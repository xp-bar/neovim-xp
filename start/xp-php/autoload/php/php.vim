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

function! php#php#class(...)
    if (&ft=='php')
        call inputsave()

        let l:name = 'class ' . substitute(@%, '[0-9A-z\/]*\/\|\..*$', '', 'g')
        let l:lines = [getline('.'), l:name, '{']
        let l:contents = [
                    \ '   /**',
                    \ '    * Constructor',
                    \ '    *',
                    \ '    * @return void',
                    \ '    */',
                    \ '    public function __construct()',
                    \ '    {',
                    \ '        //',
                    \ '    }'
                    \ ]

        " if a:1 =~  nc"
        "     l:contents = ['    //'];
        " endif

        call setline('.',  extend(extend(l:lines, l:contents), ['}']))
    endif
endfunction
