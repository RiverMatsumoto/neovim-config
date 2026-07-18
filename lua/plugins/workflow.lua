return {
  {
    "folke/flash.nvim",
    keys = {
      { "<C-Space>", false, mode = { "n", "o", "x" } },
    },
  },

  {
    "nvim-mini/mini.surround",
    opts = {
      mappings = {
        add = "",
      },
    },
    keys = {
      {
        "S",
        ":<C-u>lua MiniSurround.add('visual')<CR>",
        mode = "x",
        desc = "Add Surrounding",
      },
    },
  },

  {
    "hedyhli/outline.nvim",
    opts = {
      outline_window = {
        auto_jump = true,
      },
    },
  },

  {
    "stevearc/overseer.nvim",
    opts = {
      dap = true,
      task_list = {
        direction = "bottom",
        min_height = 12,
        max_height = 20,
      },
    },
    keys = {
      { "<leader>rr", "<cmd>OverseerRun<cr>", desc = "Run Task" },
      { "<leader>rl", "<cmd>OverseerToggle!<cr>", desc = "Task List" },
      { "<leader>ra", "<cmd>OverseerTaskAction<cr>", desc = "Task Action" },
    },
  },

  {
    "folke/snacks.nvim",
    opts = {
      terminal = {
        win = { position = "bottom", height = 0.35 },
      },
    },
  },

  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      if vim.env.NVIM_SKIP_TOOL_INSTALL == "1" then
        opts.ensure_installed = {}
      end
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if vim.env.NVIM_SKIP_TOOL_INSTALL == "1" then
        opts.ensure_installed = {}
      end
    end,
  },
}
