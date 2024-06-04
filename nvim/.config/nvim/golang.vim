function! GoRunMain()
  :!go run main.go
endfunction

au FileType go nmap <leader>rr :call GoRunMain()<CR>
