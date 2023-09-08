" autocmd BufEnter *.md call CharmLikeGlow()

fun CharmLikeGlow()
  syn match glowH1 /^#/ nextgroup=glowHeader
  syn match glowHeader /[^#]*$/ contained
  hi glowHeader cterm=bold ctermfg=white ctermbg=darkblue
  hi glowH1 ctermfg=red ctermbg=red
endfun

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
