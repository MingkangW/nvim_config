return {
  {
    -- LazyVim 会把这里的 diagnostics 配置转交给 vim.diagnostic。
    -- 我们只覆盖和“显示诊断信息”相关的部分，其他默认行为继续沿用 LazyVim。
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.diagnostics = opts.diagnostics or {}
      -- 关闭行尾虚拟文本，避免在每一行后面铺满错误/警告说明。
      -- 这是实现“默认不显示详细诊断文本”的核心配置。
      opts.diagnostics.virtual_text = {
        current_line = true,
      }

      -- 保留下划线，这样即使不显示详细文本，也能直观看出问题落在哪段代码上。
      opts.diagnostics.underline = true

      -- 插入模式下不实时刷新诊断，减少输入时的视觉干扰。
      opts.diagnostics.update_in_insert = false

      -- 同一位置有多个诊断时，优先展示严重级别更高的项目。
      opts.diagnostics.severity_sort = true

      -- 保留左侧 sign column 标记，方便快速定位有问题的行。
      -- 如果你之后想要更“极简”的效果，也可以改成 false。
      -- opts.diagnostics.signs = true,
      opts.servers = opts.servers or {}

      opts.servers.ty = {
        cmd = { "ty", "server" },
        filetypes = { "python" },
        root_markers = {
          "pyproject.toml",
          "setup.py",
          "setup.cfg",
          "requirements.txt",
          ".git"
        },
        workspace_required = false,
      }
    end,
  }
}
