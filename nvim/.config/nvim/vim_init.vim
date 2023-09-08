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
