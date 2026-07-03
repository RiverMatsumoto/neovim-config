-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },

      servers = {
        -- Avoid running multiple C# language servers.
        omnisharp = {
          enabled = false,
        },

        csharp_ls = {
          enabled = false,
        },

        roslyn_ls = {},
      },

      setup = {
        roslyn_ls = function(_, opts)
          local previous_on_attach = opts.on_attach

          opts.on_attach = function(client, bufnr)
            if previous_on_attach then
              previous_on_attach(client, bufnr)
            end

            -- Keep your previous preferences.
            client.server_capabilities.semanticTokensProvider = nil
            client.server_capabilities.inlayHintProvider = nil
          end
        end,
      },
    },
  },
}
