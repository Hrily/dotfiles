" hi clear Special
" hi clear Title
" hi clear Conceal

" set conceallevel=2

" syn match glowH1 /^#[^#][ ]*/ nextgroup=glowH1Title conceal
" syn match glowH1Title /[^#]*$/ concealends contained
" hi glowH1Title cterm=bold ctermfg=255 ctermbg=21

" syn match glowCode /`[^`][^`]*`/ cchar=`
" hi glowCode ctermfg=196 ctermbg=238

" syn match glowH2Up /^##.*$/
" hi glowH2Up cterm=bold ctermfg=39

" syn match codeBlockStart /^```.*$/ conceal
" syn match codeBlockEnd /^```$/ conceal

" markdownWikiLink is a new region
syn region markdownWikiLink matchgroup=markdownLinkDelimiter start="\[\[" end="\]\]" contains=markdownUrl keepend oneline concealends
" markdownLinkText is copied from runtime files with 'concealends' appended
syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart concealends
" markdownLink is copied from runtime files with 'conceal' appended
syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained conceal


hi markdownUrl ctermfg=blue cterm=NONE
hi markdownLinkText ctermfg=blue cterm=NONE
hi markdownHeadingDelimiter ctermfg=blue cterm=underline
hi RenderMarkdownLink ctermfg=blue cterm=NONE
hi! link RenderMarkdownLinkText markdownLinkText
hi! link RenderMarkdownLinkUrl markdownUrl
hi! link @markup.link.url.markdown_inline markdownUrl
hi! link @markup.link.label.markdown_inline markdownLinkText
hi @_label.markdown_inline ctermfg=blue cterm=NONE
hi @_label ctermfg=blue cterm=NONE

hi RenderMarkdownH1Bg cterm=bold ctermfg=255 ctermbg=21
hi RenderMarkdownH2Bg cterm=bold ctermfg=39
hi RenderMarkdownH3Bg cterm=bold ctermfg=39
hi RenderMarkdownH4Bg cterm=bold ctermfg=39
hi RenderMarkdownH5Bg cterm=bold ctermfg=39
hi RenderMarkdownH6Bg cterm=bold ctermfg=39

hi RenderMarkdownCode ctermbg=238
hi RenderMarkdownCodeInline ctermfg=196 ctermbg=238
hi RenderMarkdownCodeLanguage ctermfg=gray
