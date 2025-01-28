if has('nvim') && !exists('g:vscode')
  " Treesitter syntax highlighting
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/nvim-treesitter-context'
  hi TreesitterContext cterm=italic
  Plug 'nvim-treesitter/playground'

  " Github Copilot
  Plug 'github/copilot.vim'

  " Comamnd Bar
  Plug 'MunifTanjim/nui.nvim'
  Plug 'VonHeikemen/fine-cmdline.nvim'
  nnoremap <CR> <cmd>FineCmdline<CR>

  " Better Search Replace
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-pack/nvim-spectre'
  nnoremap <leader>S <cmd>lua require('spectre').open()<CR>

  " nvim ipynb
  " Sauce: https://www.maxwellrules.com/misc/nvim_jupyter.html
  Plug 'hkupty/iron.nvim'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-line'
  Plug 'GCBallesteros/vim-textobj-hydrogen'
  Plug 'GCBallesteros/jupytext.vim'

  " copilot chat
  Plug 'zbirenbaum/copilot.lua'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'canary' }

  " ollama gen
  Plug 'David-Kunz/gen.nvim'
  nmap <leader>a <cmd>Gen<CR>
  vmap <leader>a <cmd>Gen<CR>
  nmap <leader>A <cmd>%Gen<CR>
endif
