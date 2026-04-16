return {
  "nvim-focus/focus.nvim",
  version = "*",
  config = function (_, opts)
    require("focus").setup({
      enable = true
    })
  end
}
