local M = {}

local portable_root = vim.env.PORTABLE_CONFIG_ROOT
  or vim.fn.fnamemodify(vim.fn.resolve(vim.fn.expand("<sfile>:p")), ":h:h:h")

M.portable_root = portable_root
M.python_lsp = vim.env.PORTABLE_CONFIG_PYTHON_LSP or "ty"
M.python_ruff = vim.env.PORTABLE_CONFIG_PYTHON_RUFF or "ruff"
M.format_on_save = false

return M
