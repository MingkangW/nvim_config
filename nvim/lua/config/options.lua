-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local settings = require("config.settings")

vim.g.autoformat = settings.format_on_save
vim.g.lazyvim_python_lsp = settings.python_lsp
vim.g.lazyvim_python_ruff = settings.python_ruff
