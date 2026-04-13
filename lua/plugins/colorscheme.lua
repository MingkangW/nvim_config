return {
  {
    "NLKNguyen/papercolor-theme",
    lazy = false,
    priority = 1000,
    config = function (_, opts)
      vim.cmd.colorscheme("PaperColor")
      vim.o.background = "light"
    end
  }
}
