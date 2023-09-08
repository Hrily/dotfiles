"""""""""""""""""""""""""""""""""""""""""""""""
"                                             "
"    ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗  "
"    ██║   ██║██║████╗ ████║██╔══██╗██╔════╝  "
"    ██║   ██║██║██╔████╔██║██████╔╝██║       "
"    ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║       "
"  ██╗╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗  "
"  ╚═╝ ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝  "
"                                             "
"""""""""""""""""""""""""""""""""""""""""""""""

set ai si
set number
set relativenumber
set tabstop=2
set shiftwidth=2

" Scroll offset
set scrolloff=6

" Mouse scrolling
set mouse=a

" Unmap space
nnoremap <SPACE> <Nop>
" Map space as leader
let mapleader=" "

" Copy to clipboard
vnoremap <C-c> "+y

" Smartcase
set ignorecase
set smartcase

" highlight search
set hlsearch
hi Search ctermfg=0 ctermbg=178
nmap ,c :noh<CR>
vnoremap * y/<C-R>"<CR>

" Visual color
hi Visual ctermbg=238

" Use older regex engine
set re=1

" Page Navigation
nmap <C-j> <C-d>
nmap <C-k> <C-u>

" Buffer Navigation
nmap <silent> H <C-o>
nmap <silent> L <C-i>

" Close all buffers but current
fun! CloseOtherBuffers()
	%bd|e#
endfun

" End and begining
nmap E $
nmap B 0

" Yank till EOL
nnoremap Y yg$
" remap next so jumps and adjusts it to center
nnoremap n nzzzv
nnoremap N Nzzzv
" remap J so cursor stays where it was
nnoremap J mzJ`z

" Undo break points
for key in [',', '.', '?', '<space>', '!', '{', '}', '(', ')', '<cr>']
  execute 'inoremap '.key.' '.key.'<C-g>u'
endfor

" Matching Braces color
hi MatchParen ctermbg=0 ctermfg=magenta

" Color Column
" hi ColorColumn cterm=reverse ctermbg=white ctermfg=8
highlight OverLength cterm=none
match OverLength /\%81v./
let s:hilightcc = 0
fun! ToggleCC()
	if s:hilightcc
		" set cc=80
		highlight OverLength cterm=none
		let s:hilightcc = 0
	else
		" set cc=
		highlight OverLength cterm=reverse
		let s:hilightcc = 1
	endif
endfun
fun! EnableCC()
	let s:hilightcc = 0
	call ToggleCC()
endfun
nmap ,l :call ToggleCC()<CR>

" Line Number Colors
hi LineNr ctermfg=8 ctermbg=none
set cursorline
set cursorlineopt=number
hi CursorLineNr cterm=bold ctermfg=yellow ctermbg=none

" Gutter color
hi SignColumn ctermbg=none ctermfg=none

" Autocomplete color
hi Pmenu ctermbg=0 ctermfg=white
hi PmenuSel ctermbg=white ctermfg=black

" Split Bar
set fillchars+=vert:\ "
hi VertSplit ctermfg=0 ctermbg=none cterm=none

" Pane Nav
" nnoremap gj <C-w>j
" nnoremap gk <C-w>k
" nnoremap gl <C-w>l
" nnoremap gh <C-w>h
" " Jump to nth pane
" let i = 1
" while i <= 9
"     execute 'nnoremap t' . i . ' ' . i . '<C-w><C-w>'
"     let i = i + 1
" endwhile
" Escape terminal
" tnoremap <Esc> <C-\><C-n>
" tnoremap <Esc><Esc> <C-\><C-n>
" set timeout timeoutlen=1000  " Default
" set ttimeout ttimeoutlen=100 " Set by defaults.vim

" VSplit Pane
nmap ,s :vsplit<CR> :vertical resize 100<CR>
" VSplit Pane - Small
nmap ,S :vsplit<CR> :vertical resize 81<CR>

" Pane width
nmap ,w :vertical resize 100<CR>
" Pane width - small
nmap ,W :vertical resize 81<CR>

" Tab navigation
nmap <leader><Tab> :tabnext<CR>
nmap <leader><S-Tab> :tabprev<CR>
" Tab jumps
let i = 1
while i <= 9
    execute 'nnoremap <leader>' . i . ' ' . i . 'gt'
    let i = i + 1
endwhile

" Tab colors
hi TabLineFill ctermbg=0 ctermfg=0
hi TabLine     ctermbg=0 ctermfg=gray cterm=none
hi TabLineSel  ctermbg=0 ctermfg=lightblue
" Tab line formatting
set tabline=%!MyTabLine()
function MyTabLine()
	let s = ''
	let t = tabpagenr()
	let i = 1
	while i <= tabpagenr('$')
		let buflist = tabpagebuflist(i)
		let winnr = tabpagewinnr(i)
		let s .= '%' . i . 'T'
		let s .= (i == t ? '%1*' : '%2*')
		let s .= ' '
		" Set tab number
		let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
		let s .= i
		let s .= ' %*'
		" Set file name
		let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
		let file = bufname(buflist[winnr - 1])
		if file == ''
			let file = '[No Name]'
		else
			let file = pathshorten(fnamemodify(file, ":~:."))
		endif
		let s .= file
		" modified since the last save?
		let buflist = tabpagebuflist(i)
		let label = ' '
		for bufnr in buflist
			if getbufvar(bufnr, '&modified')
				let label = '*'
				break
			endif
		endfor
		let s .= label
		let i = i + 1
	endwhile
	let s .= '%T%#TabLineFill#%='
	let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
	return s
endfunction

" Support backspace
set backspace=indent,eol,start

" Remove trailing whitespaces
function! <SID>StripTrailingWhitespacesFn()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
command StripTrailingWhitespaces :call StripTrailingWhitespacesFn()
" Remove trailing whitespaces on save
autocmd BufWritePre * :call <SID>StripTrailingWhitespacesFn()

" Show whitespaces as characters
set listchars=eol:¬,tab:\¦\ ,trail:~,extends:>,precedes:<,space:·

" Hex Edit
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd -g 1
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r -g 1
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END

function! s:list_commits()
	let git = 'git -C ' . getcwd()
	let commits = systemlist(git .' log --oneline | head -n10')
	let git = 'G'. git[1:]
	return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
endfunction

" Command mode navigation, enable Option <- & ->
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>

" Alternat file
nnoremap <leader>a <C-^>

" Copy Sourcegraph and Phab links
nmap <silent> <leader><C-s> :call CopySourceGraphLinkToClipboard()<CR>
nmap <silent> <leader><C-p> :call CopySourceGraphLinkForPhab()<CR>

" Store swap and backup files in tmp directory
set backupdir=/tmp//
set directory=/tmp//

" apparently speeds up vim
set ttyfast
set lazyredraw

" Automatic vim plug installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" " NerdTree
Plug 'scrooloose/nerdtree'
" Open on startup and go to next tab
" autocmd StdinReadPre * let g:isReadingFromStdin = 1
" autocmd VimEnter * if !argc() && !exists('g:isReadingFromStdin') | NERDTree | setlocal cursorlineopt=line | wincmd w | endif
" Auto Close
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Reveal in NERDTree
nmap ,f :NERDTreeFind<CR>
" Toggle NERDTree
nmap ,t :NERDTreeToggle<CR>
" Remove t,T mappings from NERDTree
let g:NERDTreeMapOpenInTab = ''
let g:NERDTreeMapOpenInTabSilent = ''

" Notes
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
" Notes directories
let g:notes_directories = [
	\'~/Documents/Notes',
	\'~/git/IDF-Notes',
	\]
" Notes suffix
let g:notes_suffix = '.txt'
" Disable tab to indent
let g:notes_tab_indents = 0
" Folded text color
hi Folded ctermfg=darkgray ctermbg=233
" Embeded syntblack color
hi notesCodeStart ctermfg=darkgray
hi notesCodeEnd ctermfg=darkgray
" Markdown style URLs
syn region urlTitle matchgroup=mkdDelimiter start="\[" end="\]" oneline concealends nextgroup=urlRef
syn region urlRef matchgroup=mkdDelimiter start="(" end=")" oneline conceal contained
hi link urlTitle notesName
hi link urlRef notesName

" Generate go tests
Plug 'hexdigest/gounit-vim'

" Coc vim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
source ~/.cocvimrc
nnoremap <leader>oi :call CocAction('runCommand', 'editor.action.organizeImport')<CR>:w<CR>

" Status Line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
set fillchars+=stl:\ ,stlnc:\ "
autocmd VimEnter * AirlineTheme hrishi
let g:airline#extensions#searchcount#enabled = 0
let g:airline#extensions#whitespace#enabled = 0

" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" Goyo distraction free
Plug 'junegunn/goyo.vim'

" fzf fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let $FZF_DEFAULT_COMMAND='ag --hidden --ignore={".git","pkg","*.o","*.swp","*.swo","node_modules","vendor"} -g "" -U -f'
let $FZF_DEFAULT_OPTS="--preview-window 'right:57%' --preview 'bat --style=numbers --line-range :300 {}'
  \ --bind ctrl-y:preview-up,ctrl-e:preview-down,
  \ctrl-b:preview-page-up,ctrl-f:preview-page-down,
  \ctrl-k:preview-half-page-up,ctrl-j:preview-half-page-down,
  \shift-up:preview-top,shift-down:preview-bottom,
  \alt-up:half-page-up,alt-down:half-page-down"
nmap <leader>p :Files<CR>
nmap <leader>P :GFiles<CR>
nmap <leader>f :Files %:h<CR>
nmap <leader>b :Buffers<CR>
" let g:fzf_layout = { 'window': { 'width': 0.6, 'height': 0.6 } }
let g:fzf_layout = { 'down': '40%' }
" find go project root for file, i.e. dir with main.go
fun! FindGoProjectRoot()
	if exists('b:goprojectroot')
		return b:goprojectroot
	endif
	let l:cmd = 'findup ' . expand("%:h") . ' go.mod main.go METADATA .git'
	echo l:cmd
	silent let l:roots = systemlist(l:cmd)
	if len(l:roots) == 0
		let b:goprojectroot = expand("%:h")
	else
		let b:goprojectroot = l:roots[0]
	endif
	return b:goprojectroot
endfun
au FileType go nmap <leader>p :execute 'Files ' . FindGoProjectRoot()<CR>

" Comments
Plug 'tpope/vim-commentary'

" Start screen
Plug 'mhinz/vim-startify'
let g:startify_change_to_dir = 0
let g:startify_padding_left = 4
let g:startify_files_number = 10
hi StartifyHeader ctermfg=lightgreen cterm=italic
let g:startify_custom_header = ['',''] + map(split(system('cat ~/.vim/enterpret-logo'), '\n'), '"". v:val') + ['','']
let g:startify_lists = [
        \ { 'header': ['   MRU '. getcwd()], 'type': 'dir' },
        \ { 'header': ['   MRU'],            'type': 'files' },
        \ { 'header': ['   Sessions'],       'type': 'sessions' },
        \ { 'header': ['   Commits'],        'type': function('s:list_commits') },
        \ ]
nmap ,o :Startify<CR>

" Filetype icons
Plug 'ryanoasis/vim-devicons'
" Required for icons to show up
set encoding=UTF-8

" Denite Menu
Plug 'Shougo/denite.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

" Split nav and management
Plug 'dstein64/vim-win'
nnoremap t :call win#Win(1)<CR>
nnoremap T :call win#Win()<CR>

" Floatterm
Plug 'voldikss/vim-floaterm'
" https://github.com/voldikss/vim-floaterm#this-plugin-leaves-an-empty-bufferwindow-on-startify-window
autocmd User Startified setlocal buflisted
let g:floaterm_open_command = 'tabe'
let g:floaterm_wintype = 'normal'
let g:floaterm_position = 'top'
fun! MapEscape()
	tmap <Esc>      <C-\><C-n>
	tmap <Esc><Esc> <C-\><C-n>
endfunction
fun! UnmapEscape()
	silent! tunmap <Esc>
	silent! tunmap <Esc><Esc>
endfunction
" autocmd FileType * if &filetype == "floaterm" | call MapEscape()   | endif
" autocmd FileType * if &filetype != "floaterm" | call UnmapEscape() | endif
" nmap <leader>` :FloatermToggle<CR>
" No numbers in terminal mode
autocmd FileType * if &filetype == "floaterm" | set nonumber norelativenumber | endif
" Make file path before saving. Needed for arc diff
autocmd BufWritePre * if &filetype == "conf" | call mkdir(expand("<afile>:p:h"), "p") | endif

" EasyMotion
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
" <Leader>f{char} to move to {char}
" map  <Leader>f <Plug>(easymotion-bd-f)
" nmap <Leader>f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f)
" Move to line
" map <Leader>L <Plug>(easymotion-bd-jk)
" nmap <Leader>L <Plug>(easymotion-overwin-line)
" Move to word
" map  <Leader>w <Plug>(easymotion-bd-w)
" nmap <Leader>w <Plug>(easymotion-overwin-w)

" maxmize one buffer/pane
Plug 'szw/vim-maximizer'
nmap <leader>Z :MaximizerToggle!<CR>

" .tsx and .jsx syntax highlight
" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'

" nearley syntax highlighting
" https://nearley.js.org/
Plug 'tjvr/vim-nearley'

" .editorconfig plugin
Plug 'editorconfig/editorconfig-vim'
au FileType go let b:EditorConfig_disable = 1

" shows total number of search occurences even >99
Plug 'google/vim-searchindex'

" nvim plugins
if !empty(glob("~/.config/nvim/plugs.vim"))
  source ~/.config/nvim/plugs.vim
end

" Initialize plugin system
call plug#end()

" Comment Colors
hi Comment cterm=italic ctermfg=8

" Indent colors
hi IntentChars ctermfg=white
match IntentChars /^ \+/

" Color column
match OverLength /\%81v./

" Highligh trailing whitespacee
hi ExtraWhitespace ctermbg=red
match ExtraWhitespace /\s\+$/

" Hide ~ in sign column for empty lines
hi NonText ctermfg=0
hi SpecialKey ctermfg=8
