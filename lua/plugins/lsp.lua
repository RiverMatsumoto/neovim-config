-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        csharp_ls = function(_, opts)
          opts.on_attach = function(client, bufnr)
            client.server_capabilities.semanticTokensProvider = nil
          end
        end,
        omnisharp = function(_, opts)
          opts.on_attach = function(client, bufnr)
            client.server_capabilities.semanticTokensProvider = nil
          end
        end,
      },
    },
  },
}
