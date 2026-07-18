if vim.fn.has("nvim-0.12") == 0 then
  error("This configuration requires Neovim 0.12 or newer")
end

vim.opt.ttimeoutlen = 0

require("config.options")
require("config.autocmds")

require("config.lazy")
