let g:airline#themes#hrishi#palette = {}

hi StatusLineInactive ctermbg=black ctermfg=gray

hi StatusModeNormal      ctermbg=black ctermfg=lightblue
hi StatusModeInsert      ctermbg=black ctermfg=lightcyan
hi StatusModeVisual      ctermbg=black ctermfg=lightgreen
hi StatusModeReplace     ctermbg=black ctermfg=yellow
hi StatusModeCommandline ctermbg=black ctermfg=lightmagenta

let s:active   = airline#themes#get_highlight('StatusLineActive')
let s:inactive = airline#themes#get_highlight('StatusLineInactive')

let s:normal = airline#themes#get_highlight('StatusModeNormal')
let g:airline#themes#hrishi#palette.normal = airline#themes#generate_color_map(s:normal, s:normal, s:normal)
let g:airline#themes#hrishi#palette.normal.airline_error   = s:inactive
let g:airline#themes#hrishi#palette.normal.airline_warning = s:inactive
let g:airline#themes#hrishi#palette.normal.airline_term    = s:normal
let g:airline#themes#hrishi#palette.normal_modified = copy(g:airline#themes#hrishi#palette.normal)

let s:insert = airline#themes#get_highlight('StatusModeInsert')
let g:airline#themes#hrishi#palette.insert = airline#themes#generate_color_map(s:insert, s:insert, s:insert)
let g:airline#themes#hrishi#palette.insert.airline_error   = s:inactive
let g:airline#themes#hrishi#palette.insert.airline_warning = s:inactive
let g:airline#themes#hrishi#palette.insert.airline_term    = s:insert
let g:airline#themes#hrishi#palette.insert_modified = copy(g:airline#themes#hrishi#palette.insert)
let g:airline#themes#hrishi#palette.insert_paste    = copy(g:airline#themes#hrishi#palette.insert)

let s:replace = airline#themes#get_highlight('StatusModeReplace')
let g:airline#themes#hrishi#palette.replace = airline#themes#generate_color_map(s:replace, s:replace, s:replace)
let g:airline#themes#hrishi#palette.replace.airline_error   = s:inactive
let g:airline#themes#hrishi#palette.replace.airline_warning = s:inactive
let g:airline#themes#hrishi#palette.replace.airline_term    = s:replace
let g:airline#themes#hrishi#palette.replace_modified = copy(g:airline#themes#hrishi#palette.replace)

let s:visual = airline#themes#get_highlight('StatusModeVisual')
let g:airline#themes#hrishi#palette.visual = airline#themes#generate_color_map(s:visual, s:visual, s:visual)
let g:airline#themes#hrishi#palette.visual.airline_error   = s:inactive
let g:airline#themes#hrishi#palette.visual.airline_warning = s:inactive
let g:airline#themes#hrishi#palette.visual.airline_term    = s:visual
let g:airline#themes#hrishi#palette.visual_modified = copy(g:airline#themes#hrishi#palette.visual)

let s:commandline = airline#themes#get_highlight('StatusModeCommandline')
let g:airline#themes#hrishi#palette.commandline = airline#themes#generate_color_map(s:commandline, s:commandline, s:commandline)
let g:airline#themes#hrishi#palette.commandline.airline_error   = s:inactive
let g:airline#themes#hrishi#palette.commandline.airline_warning = s:inactive
let g:airline#themes#hrishi#palette.commandline.airline_term    = s:commandline
let g:airline#themes#hrishi#palette.commandline_modified = copy(g:airline#themes#hrishi#palette.commandline)

let g:airline#themes#hrishi#palette.inactive = airline#themes#generate_color_map(s:inactive, s:inactive, s:inactive)
let g:airline#themes#hrishi#palette.inactive.airline_error   = s:inactive
let g:airline#themes#hrishi#palette.inactive.airline_warning = s:inactive
let g:airline#themes#hrishi#palette.inactive.airline_term    = s:inactive
let g:airline#themes#hrishi#palette.inactive_modified = copy(g:airline#themes#hrishi#palette.inactive)
