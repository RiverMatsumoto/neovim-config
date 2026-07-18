return {
  {
    "LazyVim/LazyVim",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "zig",
        callback = function(event)
          -- zig fmt collapses short expressions by design; don't invoke it for Zig buffers.
          vim.b[event.buf].autoformat = false
        end,
      })
    end,
  },
}
