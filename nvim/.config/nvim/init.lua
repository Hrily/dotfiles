---@diagnostic disable: undefined-global
local config_path = vim.fn.stdpath('config')

vim.cmd('source ' .. config_path .. '/vim_init.vim')
vim.cmd('source ' .. config_path .. '/lazygit.vim')

-- https://sourcegraph.com/github.com/ledesmablt/vim-run/-/blob/plugin/run.vim?L44
vim.g.run_nostream_default = 1

require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "all",

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  ignore_install = { "phpdoc", "tree-sitter-phpdoc" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    --	     disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    --	     the name of the parser)
    --	     list of language that will be disabled
    disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = { "markdown" },
  },
}

require'treesitter-context'.setup{
  -- Enable this plugin (Can be enabled/disabled later via commands)
  enable = true,
  -- How many lines the window should span. Values <= 0 mean no limit.
  max_lines = 0,
  -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  min_window_height = 0,
  line_numbers = true,
  -- Maximum number of lines to collapse for a single context line
  multiline_threshold = 20,
  -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  trim_scope = 'outer',
  -- Line used to calculate context. Choices: 'cursor', 'topline'
  mode = 'cursor',
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  -- The Z-index of the context window
  zindex = 20,
  -- (fun(buf: integer): boolean) return false to disable attaching
  on_attach = nil,
}

require('fine-cmdline').setup({
  cmdline = {
    enable_keymaps = true,
    smart_history = true,
    prompt = '❯ '
  },
  popup = {
    position = {
      row = '20%',
      col = '50%',
    },
    size = {
      width = '60%',
    },
    border = {
      style = 'rounded',
    },
    win_options = {
      winhighlight = 'Normal:Normal,FloatBorder:Normal',
    },
  },
  hooks = {
    before_mount = function(input)
      -- code
    end,
    after_mount = function(input)
      -- code
    end,
    set_keymaps = function(imap, feedkeys)
      -- code
    end
  }
})

require('madglow')
