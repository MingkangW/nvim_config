return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.theme = "onelight"
      -- opts.options.theme = "auto"

      -- 去掉厚重的块状分隔符，让浅色状态栏看起来更干净。
      opts.options.section_separators = { left = "", right = "" }
      opts.options.component_separators = { left = "|", right = "|" }

      opts.sections = opts.sections or {}
      opts.sections.lualine_c = opts.sections.lualine_c or {}

      local new_components = {}
      local function_index = 0
      local inserted_filename = false

      for _, component in ipairs(opts.sections.lualine_c) do
        -- local is_filename = component == "filename"
        --   or (type(component) == "table" and component[1] == "filename")
        local is_function_component = type(component) == "table" and type(component[1]) == "function"

        if is_function_component then
          function_index = function_index + 1
        end

        -- if is_filename then
          -- skip old filename; we'll insert the replacement in the target slot
        if is_function_component and function_index == 2 then
          table.insert(new_components, {
            "filename",
            path = 1,
          })
          inserted_filename = true
        else
          table.insert(new_components, component)
        end
      end

      -- if not inserted_filename then
      --   table.insert(new_components, {
      --     "filename",
      --     path = 2,
      --   })
      -- end

      opts.sections.lualine_c = new_components
    end,
  },
}
