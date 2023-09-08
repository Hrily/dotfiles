" vim source for @ date
function! coc#source#atcal#init() abort
  return {
        \ 'priority': 9,
        \ 'shortcut': 'AtCal',
        \ 'triggerCharacters': ['@']
        \}
endfunction

function! coc#source#atcal#complete(opt, cb) abort
  let l:input = a:opt.input
  " TODO: get items
  let items = []
  call a:cb(items)
endfunction
