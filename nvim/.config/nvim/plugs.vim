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
endif
