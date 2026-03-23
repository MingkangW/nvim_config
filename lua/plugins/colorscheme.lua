return {
  {
    "mcchrish/zenbones.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    lazy = false,
    priority = 1000,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "PaperColor",
    },
    init = function()
      vim.o.background = "light"
    end,
  },
}
