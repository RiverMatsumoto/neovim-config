return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        opts = {},
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dap.adapters.coreclr = {
        type = "executable",
        command = (function()
          local mason_netcoredbg = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg"
          if vim.fn.executable(mason_netcoredbg) == 1 then
            return mason_netcoredbg
          end

          local path_netcoredbg = vim.fn.exepath("netcoredbg")
          if path_netcoredbg ~= "" then
            return path_netcoredbg
          end

          return vim.fn.expand("~/.local/bin/netcoredbg")
        end)(),
        args = { "--interpreter=vscode" },
      }

      local codelldb = vim.fn.stdpath("data") .. "/mason/bin/codelldb"
      if vim.fn.executable(codelldb) == 1 then
        dap.adapters.codelldb = {
          type = "server",
          port = "${port}",
          executable = {
            command = codelldb,
            args = { "--port", "${port}" },
          },
        }
      end

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "Attach to Godot",
          request = "attach",
          processId = require("dap.utils").pick_process,
          justMyCode = true,
          requireExactSource = true,
        },
      }

      vim.fn.sign_define("DapBreakpoint", {
        text = "●",
        texthl = "DiagnosticSignError",
      })

      vim.fn.sign_define("DapStopped", {
        text = "▶",
        texthl = "DiagnosticSignWarn",
        linehl = "Visual",
      })

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end

      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      local map = vim.keymap.set

      map("n", "<F5>", function()
        dap.continue()
      end, { desc = "Debug: Start/Continue" })

      map("n", "<S-F5>", function()
        dap.terminate()
      end, { desc = "Debug: Stop" })

      map("n", "<F17>", function()
        dap.terminate()
      end, { desc = "Debug: Stop" })

      map("n", "<Esc>[15;2~", function()
        dap.terminate()
      end, { desc = "Debug: Stop" })

      map("n", "<F9>", function()
        dap.toggle_breakpoint()
      end, { desc = "Debug: Toggle Breakpoint" })

      map("n", "<F10>", function()
        dap.step_over()
      end, { desc = "Debug: Step Over" })

      map("n", "<F11>", function()
        dap.step_into()
      end, { desc = "Debug: Step Into" })

      map("n", "<S-F11>", function()
        dap.step_out()
      end, { desc = "Debug: Step Out" })

      map("n", "<F23>", function()
        dap.step_out()
      end, { desc = "Debug: Step Out" })

      map("n", "<Esc>[23;2~", function()
        dap.step_out()
      end, { desc = "Debug: Step Out" })

      map("n", "<leader>du", function()
        dapui.toggle()
      end, { desc = "Debug: Toggle UI" })

      map("n", "<leader>dr", function()
        dap.repl.open()
      end, { desc = "Debug: REPL" })
    end,
  },
}
