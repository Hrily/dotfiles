let g:floaterm_borderchars = "─│─│╭╮╯╰"
let s:width = "0.9"
let s:height = "0.9"
let s:autoclose = "1"
let s:name = 'lazygit'
let s:title = 'lazygit'
let s:command = 'lazygit'
let s:position = "center"

autocmd VimEnter * execute "FloatermNew --silent --name=" . s:name . " --title=" . s:title . " --height=" . s:height . " --width=" . s:width . " --position=" . s:position . " " . s:command

function! s:open_lazygit_popup()
  autocmd BufEnter * if &filetype == "floaterm" | tmap q <C-\><C-n>:call <SID>close_lazygit_popup()<CR> | endif
  autocmd BufLeave * if &filetype == "floaterm" | silent! tunmap q | endif
  execute "FloatermShow " . s:name
endfunction

function! s:close_lazygit_popup()
  execute "FloatermHide " . s:name
endfunction

nnoremap <silent> <leader>lz :call <SID>open_lazygit_popup()<CR>

