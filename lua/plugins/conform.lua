-- ~/.config/nvim/lua/plugins/conform.lua
return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}

      -- Do not use CSharpier for C#. Roslyn will format through the LSP.
      opts.formatters_by_ft.cs = {}

      -- Used for manual formatting.
      opts.default_format_opts = vim.tbl_deep_extend("force", opts.default_format_opts or {}, {
        timeout_ms = 2000,
        lsp_format = "prefer",
      })

      -- Used for format-on-save.
      opts.format_on_save = function(bufnr)
        if vim.bo[bufnr].filetype == "cs" then
          return {
            timeout_ms = 2000,
            lsp_format = "prefer",
          }
        end

        return {
          timeout_ms = 500,
          lsp_format = "fallback",
        }
      end
    end,
  },
}
