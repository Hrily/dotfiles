if has('nvim') && !exists('g:vscode')
  " Treesitter syntax highlighting
  Plug 'nvim-treesitter/nvim-treesitter'
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

  " ollama gen
  Plug 'David-Kunz/gen.nvim'
  nmap <leader>l <cmd>Gen<CR>
  vmap <leader>l <cmd>Gen<CR>
  nmap <leader>L <cmd>%Gen<CR>

  " avante.nvim
  Plug 'stevearc/dressing.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'MunifTanjim/nui.nvim'
  Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make' }

  " zk
  Plug 'zk-org/zk-nvim'
  autocmd FileType markdown nnoremap <leader>b :ZkBacklinks<CR>
  autocmd FileType markdown nnoremap <leader>t :ZkTags<CR>

  " Dependencies
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-lua/plenary.nvim'

  " Actual Plugin
  Plug 'Al0den/notion.nvim'

  " OpenCode
  Plug 'folke/snacks.nvim'
  Plug 'NickvanDyke/opencode.nvim'

endif
