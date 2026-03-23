return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- 为 PaperColor light 单独定义一套偏浅色的 lualine 主题。
      -- 这样即使主主题本身可用，statusline 也能维持更柔和、统一的浅色观感。
      local theme = {
        normal = {
          -- a 区一般用于展示当前模式，所以保留一点层次感，方便快速识别。
          a = { fg = "#4d4d4c", bg = "#d7d7d7", gui = "bold" },
          -- b/c 区逐步变浅，让 statusline 和 light 背景更协调。
          b = { fg = "#4d4d4c", bg = "#e4e4e4" },
          c = { fg = "#5f5f5f", bg = "#eeeeee" },
        },
        insert = {
          -- 插入模式保留轻微蓝色提示，但整体仍然维持浅色风格。
          a = { fg = "#4d4d4c", bg = "#afd7ff", gui = "bold" },
          b = { fg = "#4d4d4c", bg = "#e4e4e4" },
          c = { fg = "#5f5f5f", bg = "#eeeeee" },
        },
        visual = {
          -- 可视模式用较柔和的暖色，和浅色主题更搭。
          a = { fg = "#4d4d4c", bg = "#ffd787", gui = "bold" },
          b = { fg = "#4d4d4c", bg = "#e4e4e4" },
          c = { fg = "#5f5f5f", bg = "#eeeeee" },
        },
        replace = {
          -- 替换模式使用较浅的红色，既能区分状态又不会过于刺眼。
          a = { fg = "#4d4d4c", bg = "#ffb3ba", gui = "bold" },
          b = { fg = "#4d4d4c", bg = "#e4e4e4" },
          c = { fg = "#5f5f5f", bg = "#eeeeee" },
        },
        command = {
          -- 命令模式给一点轻微绿色提示，保持不同模式之间的辨识度。
          a = { fg = "#4d4d4c", bg = "#c3e88d", gui = "bold" },
          b = { fg = "#4d4d4c", bg = "#e4e4e4" },
          c = { fg = "#5f5f5f", bg = "#eeeeee" },
        },
        inactive = {
          -- 非活动窗口进一步淡化，避免和当前窗口抢视觉焦点。
          a = { fg = "#808080", bg = "#f2f2f2" },
          b = { fg = "#808080", bg = "#f2f2f2" },
          c = { fg = "#a0a0a0", bg = "#f7f7f7" },
        },
      }

      opts.options = opts.options or {}
      opts.options.theme = theme

      -- 去掉厚重的块状分隔符，让浅色状态栏看起来更干净。
      opts.options.section_separators = { left = "", right = "" }
      opts.options.component_separators = { left = "|", right = "|" }
    end,
  },
}
