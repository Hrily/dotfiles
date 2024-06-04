set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Use block cursor for all modes
set guicursor=n-v-c-i:block

fun MadGlow()
  silent let result=system("glow -", getline(1, "$"))
  " cleanup buffer
  :%delete _
  call setline(1, split(result, '\n'))
endfun

" Jupytext
let g:jupytext_fmt = 'py'
let g:jupytext_style = 'hydrogen'
let g:jupytext_command = 'python -m jupytext'

" Send cell to IronRepl and move to next cell.
" Depends on the text object defined in vim-textobj-hydrogen
" You first need to be connected to IronRepl
nmap <leader>x ctrih %%<CR><CR>
