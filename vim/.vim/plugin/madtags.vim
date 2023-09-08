autocmd BufEnter *.md call SetMadTagsConfigMaybe()

fun! SetMadTagsConfigMaybe()
  " figure out config file
  let l:config_file = '~/.madtagsrc.yaml'
  if $MADTAGS_CONFIG != ""
    let l:config_file = $MADTAGS_CONFIG
  endif

  " get sources
  let l:sources = system('cat ' . l:config_file . ' | grep source | sed "s/.*source: //g"' )

  " check if file is present in one of the sources
  " and is a symlink
  let l:filedir = expand("%:p")
  for source in split(l:sources, '\n')
    if expand(l:filedir) =~ expand(source)
      call SetMadTagsConfig()
      return
    endif
  endfor
endfun

fun! SetMadTagsConfig()
  " replace with target file if we are on symlink
  if resolve(expand("%")) != expand("%")
    execute "file " . resolve(expand("%")) | edit
  endif

  " highlight madtag
  match MadTag "\[\[[^]]*\]\]"
  hi MadTag ctermfg=blue cterm=underline

  " add file name as head tag before writing
  autocmd BufWritePre *.md call WriteFileNameAsHeadTag()

  " TODO: start watcher and kill it on exit
  if has('nvim')
    let l:watcherjob = jobstart("madtags-watcher 1>/tmp/madtags-watcher.out 2>/tmp/madtags-watcher.err")
    autocmd VimLeave * jobstop(watcherjob, "kill")
  else
    let l:watcherjob = job_start("madtags-watcher 1>/tmp/madtags-watcher.out 2>/tmp/madtags-watcher.err")
    autocmd VimLeave * job_stop(watcherjob, "kill")
  endif

  nmap gr :call GetMadTagsReferences()<CR>
  " for getting all tags
  nmap gt :call GetTags()<CR>

endfun

fun! GetMadTagsReferences()
  let l:line = getline('.')
  if l:line !~ '[[' || l:line !~ ']]'
    echo "no mad tag found under cursor"
    return
  endif

  let l:save_clipboard = &clipboard
  set clipboard= " Avoid clobbering the selection and clipboard registers.
  let l:save_reg = getreg('"')
  let l:save_regmode = getregtype('"')
  normal! yi]
  let l:tag = @@ " Your text object contents are here.
  let l:tag = system('echo "' . l:tag . '" | sed "s/\[//g" | sed "s/\]//g" | tr -d "\n"')
  call setreg('"', l:save_reg, l:save_regmode)
  let &clipboard = l:save_clipboard

  let l:sourcedir = expand("%:h")
  let l:tagdir = l:sourcedir . '/tags/' . l:tag . '/'
  let l:tagdir = fnamemodify(expand(l:tagdir), ":~:.")

  call fzf#vim#grep('ag --nogroup --color --color-match="30;33" -fQ "[[' . l:tag . ']]" ' . l:tagdir, 0, fzf#vim#with_preview({}))
endfun

fun! WriteFileNameAsHeadTag()
    let l = line(".")
    let c = col(".")

    let first_line = getline(1)
    let file_tag_head = '# [[' . expand('%:t:r') . ']]'
    if first_line != file_tag_head
      " write file_tag_head as first line
      execute '1,1s/^/' . file_tag_head .'\r/g'
    endif

    let second_line = getline(2)
    if second_line != ""
      " write empty line as second line
      execute '2,2s/^/\r/g'
    endif

    call cursor(l, c)
endfun

fun! GetTags()
  let l:sourcedir = expand("%:h")
  let l:tagsdir = l:sourcedir . '/tags/'
  let l:tagsdir = fnamemodify(expand(l:tagsdir), ":~:.")

  let l:tagscommand = 'ls ' . l:tagsdir

  call fzf#run({'source': l:tagscommand,
  \             'sink': function('ListTagMadFiles'),
  \             'options': ['--preview', 'ls ' . l:tagsdir . '/{}']})
endfun

fun! ListTagMadFiles(tag)
  let l:sourcedir = expand("%:h")
  let l:tagsdir = l:sourcedir . '/tags/'
  let l:tagsdir = fnamemodify(expand(l:tagsdir), ":~:.")
  let l:tagdir = l:tagsdir . '/' .  a:tag

  call fzf#vim#grep('ag --nogroup --color --color-match="30;33" -fQ "[[' . a:tag . ']]" ' . l:tagdir, 0, fzf#vim#with_preview({}))
endfun
