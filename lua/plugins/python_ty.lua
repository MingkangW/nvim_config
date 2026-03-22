return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
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

      -- opts.servers.ruff = vim.tbl_deep_extend("force", opts.servers.ruff or {}, {
      --   init_options = {
      --     settings = {
      --       logLevel = "error",
      --     },
      --   },
      -- })
      --
      -- if opts.servers.pyright then
      --   opts.servers.pyright.enabled = false
      -- end
      --
      -- if opts.servers.basedpyright then
      --   opts.servers.basedpyright.enabled = false
      -- end
    end,
  },
}
