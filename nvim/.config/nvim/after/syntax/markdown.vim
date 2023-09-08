hi clear Special
hi clear Title
hi clear Conceal

set conceallevel=2

syn match glowH1 /^#[^#][ ]*/ nextgroup=glowH1Title conceal
syn match glowH1Title /[^#]*$/ concealends contained
hi glowH1Title cterm=bold ctermfg=255 ctermbg=21

syn match glowCode /`[^`][^`]*`/ cchar=`
hi glowCode ctermfg=196 ctermbg=238

syn match glowH2Up /^##.*$/
hi glowH2Up cterm=bold ctermfg=39

syn match codeBlockStart /^```.*$/ conceal
syn match codeBlockEnd /^```$/ conceal
