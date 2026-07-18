-- ~/.config/nvim/lua/plugins/lsp.lua
local code_action_latency = {
  pending = {},
  samples = {},
}

local latency_group = vim.api.nvim_create_augroup("lsp_code_action_latency", { clear = true })

vim.api.nvim_create_autocmd("LspRequest", {
  group = latency_group,
  callback = function(ev)
    local data = ev.data or {}
    local request = data.request
    if not request or request.method ~= "textDocument/codeAction" then
      return
    end

    local key = ("%d:%d"):format(data.client_id, data.request_id)
    if request.type == "pending" then
      code_action_latency.pending[key] = vim.uv.hrtime()
    elseif request.type == "complete" then
      local started_at = code_action_latency.pending[key]
      code_action_latency.pending[key] = nil
      if started_at then
        table.insert(code_action_latency.samples, (vim.uv.hrtime() - started_at) / 1e6)
      end
    elseif request.type == "cancel" then
      code_action_latency.pending[key] = nil
    end
  end,
})

vim.api.nvim_create_user_command("LspCodeActionStats", function()
  local count = #code_action_latency.samples
  if count == 0 then
    vim.notify("No code-action samples recorded", vim.log.levels.INFO)
    return
  end

  local sorted = vim.deepcopy(code_action_latency.samples)
  table.sort(sorted)
  local percentile = function(value)
    return sorted[math.ceil(count * value)]
  end

  vim.notify(
    ("Code actions: count=%d p50=%.1fms p95=%.1fms max=%.1fms"):format(
      count,
      percentile(0.50),
      percentile(0.95),
      sorted[count]
    ),
    vim.log.levels.INFO
  )
end, { desc = "Show LSP code-action latency statistics", force = true })

vim.api.nvim_create_user_command("LspCodeActionReset", function()
  code_action_latency.pending = {}
  code_action_latency.samples = {}
  vim.notify("Code-action latency samples cleared", vim.log.levels.INFO)
end, { desc = "Reset LSP code-action latency statistics", force = true })

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },

      servers = {
        csharp_ls = {
          enabled = false,
        },

        roslyn_ls = {
          enabled = false,
        },

        omnisharp = {
          cmd = {
            vim.fn.stdpath("data") .. "/mason/bin/OmniSharp",
            "-z",
            "--hostPID",
            tostring(vim.fn.getpid()),
            "DotNet:enablePackageRestore=false",
            "--encoding",
            "utf-8",
            "--languageserver",
          },
          settings = {
            FormattingOptions = {
              EnableEditorConfigSupport = true,
              OrganizeImports = true,
            },
            MsBuild = {
              LoadProjectsOnDemand = true,
            },
            RoslynExtensionsOptions = {
              EnableAnalyzersSupport = true,
              EnableImportCompletion = false,
              AnalyzeOpenDocumentsOnly = true,
              EnableDecompilationSupport = false,
            },
            Sdk = {
              IncludePrereleases = false,
            },
          },
          on_attach = function(client)
            client.server_capabilities.semanticTokensProvider = nil
            client.server_capabilities.inlayHintProvider = nil
          end,
        },
      },
    },
  },

  {
    "iabdelkareem/csharp.nvim",
    commit = "e44e275dabbcfc188ce1a5f504aad778e917c814",
    dependencies = {
      "mason-org/mason.nvim",
      "mfussenegger/nvim-dap",
      "Tastyep/structlog.nvim",
    },
    config = function()
      require("csharp").setup({
        lsp = {
          -- Use nvim-lspconfig until csharp.nvim's managed-LSP config bug is fixed.
          enable = false,
          default_timeout = 3000,
          omnisharp = {
            enable = false,
            default_timeout = 3000,
          },
          roslyn = {
            enable = false,
          },
        },
        logging = {
          level = "WARN",
        },
        dap = {
          adapter_name = "coreclr",
        },
      })
    end,
  },
}
