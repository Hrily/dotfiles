---@diagnostic disable: undefined-global
local config_path = vim.fn.stdpath('config')

vim.cmd('source ' .. config_path .. '/vim_init.vim')
vim.cmd('source ' .. config_path .. '/lazygit.vim')

-- https://sourcegraph.com/github.com/ledesmablt/vim-run/-/blob/plugin/run.vim?L44
vim.g.run_nostream_default = 1
