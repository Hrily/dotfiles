function! GoRunMain()
  :!go run main.go
endfunction

au FileType go nmap <leader>rr :call GoRunMain()<CR>

function! GoTestDir()
  :!cd %:h && go test ./...
endfunction

function! GoWireDir()
  :!cd %:h && wire
endfunction

au FileType go nmap <leader>rt :call GoTestDir()<CR>
au FileType go nmap <leader>rw :call GoWireDir()<CR>
