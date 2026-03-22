-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Save visible editor messages to the current project root.
-- LazyVim routes many messages through noice.nvim, so prefer its history and
-- fall back to built-in :messages when noice is unavailable.
local function get_message_lines()
  local lines = {}

  if package.loaded["noice"] then
    local ok, manager = pcall(require, "noice.message.manager")
    if ok then
      local messages = manager.get(nil, { history = true, sort = true })
      for _, message in ipairs(messages) do
        local content = vim.trim(message:content() or "")
        if content ~= "" then
          vim.list_extend(lines, vim.split(content, "\n", { plain = true, trimempty = false }))
          table.insert(lines, "")
        end
      end
    end
  end

  if #lines == 0 then
    local ok, result = pcall(vim.api.nvim_exec2, "silent messages", { output = true })
    if not ok then
      vim.notify("SaveMessages failed: " .. tostring(result), vim.log.levels.ERROR)
      return nil
    end
    lines = vim.split(result.output or "", "\n", { plain = true, trimempty = false })
  end

  return lines
end

vim.api.nvim_create_user_command("SaveMessages", function()
  local file = vim.fn.getcwd() .. "/.nvim-messages"
  local lines = get_message_lines()
  if not lines then
    return
  end

  vim.fn.writefile(lines, file)
  print("Messages saved to " .. file)
end, {})

vim.cmd([[cnoreabbrev <expr> savemessages getcmdtype() == ':' && getcmdline() ==# 'savemessages' ? 'SaveMessages' : 'savemessages']])
