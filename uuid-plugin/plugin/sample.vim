let s:p_dir = expand('<sfile>:p:h')
let g:is_running = 0
let g:channel = -1

function! StartIfNotRunning()
    if g:is_running == 0
        echo 'starting plugin...'
        "TODO - This is a dirty hack. We should launch things without changing
        "the working directory.
        exec ':cd ' . s:p_dir
        let g:channel = rpcstart('lein', ['run'])
        let g:is_running = 1
    endif
endfunction

function! GetUUID()
    call StartIfNotRunning()
    let res = rpcrequest(g:channel, 'uuid', [])
    return res
endfunction

echo 'uuid plugin loaded!'
