return {
  {
    "garymjr/nvim-snippets",
    opts = function(_, opts)
      opts.search_paths = opts.search_paths or { vim.fn.stdpath("config") .. "/snippets" }
      table.insert(opts.search_paths, vim.fs.joinpath(LazyVim.root(), ".vscode"))
    end,
  },
}
