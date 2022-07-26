set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Use block cursor for all modes
set guicursor=n-v-c-i:block
