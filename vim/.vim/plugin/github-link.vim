function! GetGithubDefaultLink()
  let l:remote = trim(system("git remote get-url origin"))
  let l:remote = substitute(l:remote, "git@", "", "")
  let l:remote = substitute(l:remote, ":", "/", "")
  let l:remote = substitute(l:remote, ".git", "", "")
  let l:default = "main"
  if (trim(system("git branch | grep -o master"))) == "master"
    let l:default = "master"
  endif
  let l:filename = trim(system("git ls-files --full-name " . expand("%")))
  let l:url = "https://" . l:remote . "/blob/" . l:default . "/" . l:filename . "#L" . line(".")
  return l:url
endfunction

function! GetGithubLink()
  let l:remote = trim(system("git remote get-url origin"))
  let l:remote = substitute(l:remote, "git@", "", "")
  let l:remote = substitute(l:remote, ":", "/", "")
  let l:remote = substitute(l:remote, ".git", "", "")
  let l:default = "main"
  if (trim(system("git branch | grep -o master"))) == "master"
    let l:default = "master"
  endif
  let l:commit = trim(system("git merge-base @ origin/" . l:default))
  let l:filename = trim(system("git ls-files --full-name " . expand("%")))
  let l:url = "https://" . l:remote . "/blob/" . l:commit . "/" . l:filename . "#L" . line(".") . ":" . col(".")
  return l:url
endfunction

function! CopyGithubLinkToClipboard()
  let l:url = GetGithubDefaultLink()
  call setreg("+", l:url)
  echo "Copied Github URL to clipboard"
endfunction

nmap <silent> <leader><C-g> :call CopyGithubLinkToClipboard()<cr>
