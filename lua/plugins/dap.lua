return {
  {
    "rcarriga/nvim-dap-ui",
    opts = {
      layouts = {
        {
          elements = {
            {
              id = "scopes",
              size = 0.25,
            },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 30,
          position = "left",
        },
        {
          elements = {
            {id = "console", size = 1},
            -- {id = "repl", size = 0.5},
          },
          size = 10,
          position = "bottom",
        },
        {
          elements = {
            -- {id = "console", size = 1},
            {id = "repl", size = 1},
          },
          size = 100,
          position = "right",
        },
      },
      controls = {
        enabled = false,
      },
    },
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup(opts)

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end

      dap.listeners.before.event_terminated["dapui_config"] = nil
      dap.listeners.before.event_exited["dapui_config"] = nil
    end,
  },
}
