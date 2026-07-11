return {
  {
    "folke/persistence.nvim",
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        once = true,
        callback = function()
          local argument = vim.fn.argv(0)
          if vim.fn.argc() == 0 or (vim.fn.argc() == 1 and vim.fn.isdirectory(argument) == 1) then
            vim.schedule(function()
              require("persistence").load()
            end)
          end
        end,
      })
    end,
  },
}
