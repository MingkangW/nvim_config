return {
  {
    "NLKNguyen/papercolor-theme",
    lazy = false,
    priority = 1000,
    config = function (_, opts)
      -- vim.cmd.colorscheme("PaperColor")
      local theme = os.getenv("NVIM_THEME")
      if theme == "light" then
        vim.o.background = "light"
        -- require("lualine").setup({
        --   theme = "onelight"
        -- })
      else
        vim.o.background = "dark"
      end
    end
  },
-- lua/plugins/rose-pine.lua
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      local theme = os.getenv("NVIM_THEME")
      if theme == "light" then
        vim.cmd("colorscheme rose-pine-dawn")
      else
        vim.cmd("colorscheme rose-pine")
      end
    end
  }
}
