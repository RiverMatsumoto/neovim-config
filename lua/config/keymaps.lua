local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local function terminal()
  Snacks.terminal.toggle(nil, {
    cwd = LazyVim.root(),
    win = { position = "bottom", height = 0.35 },
  })
end

-- Familiar editor navigation.
map("n", "<C-p>", function()
  Snacks.picker.files()
end, { desc = "Quick Open" })

map("n", "<C-S-p>", function()
  Snacks.picker.commands()
end, { desc = "Command Palette" })

map("n", "<C-S-f>", function()
  Snacks.picker.grep()
end, { desc = "Search Workspace" })

map("n", "<C-b>", function()
  Snacks.explorer()
end, { desc = "Toggle Explorer" })

map({ "n", "t" }, "<C-`>", terminal, { desc = "Toggle Terminal" })
map({ "n", "t" }, "<C-/>", terminal, { desc = "Toggle Terminal" })

map("n", "<A-Left>", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
map("n", "<A-Right>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

map("n", "<C-s>", "<cmd>write<cr>", { desc = "Save File" })
map("i", "<C-s>", "<C-o><cmd>write<cr>", { desc = "Save File" })

-- VS Code-like task and debugger controls.
map("n", "<C-S-b>", "<cmd>OverseerRun<cr>", { desc = "Run Build Task" })

map("n", "<F5>", function()
  require("dap").continue()
end, { desc = "Debug: Start/Continue" })

map("n", "<S-F5>", function()
  require("dap").terminate()
end, { desc = "Debug: Stop" })

map("n", "<F9>", function()
  require("dap").toggle_breakpoint()
end, { desc = "Debug: Toggle Breakpoint" })

map("n", "<F10>", function()
  require("dap").step_over()
end, { desc = "Debug: Step Over" })

map("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "Debug: Step Into" })

map("n", "<S-F11>", function()
  require("dap").step_out()
end, { desc = "Debug: Step Out" })

-- VS Code-style LSP navigation.
map("n", "<F12>", vim.lsp.buf.definition, { desc = "LSP: Go to Definition" })
map("n", "<S-F12>", vim.lsp.buf.references, { desc = "LSP: Find References" })
-- map("n", "<C-F12>", vim.lsp.buf.implementation, { desc = "LSP: Go to Implementation" })
map("n", "<Esc>[24;5~", vim.lsp.buf.implementation, {
  desc = "LSP: Go to Implementation",
})

-- Common extras.
map("n", "<A-F12>", vim.lsp.buf.declaration, { desc = "LSP: Go to Declaration" })
map("n", "<C-S-F12>", vim.lsp.buf.type_definition, { desc = "LSP: Go to Type Definition" })

-- Rename / code actions.
map("n", "<F2>", vim.lsp.buf.rename, { desc = "LSP: Rename" })
map({ "n", "v" }, "<C-.>", vim.lsp.buf.code_action, { desc = "LSP: Code Action" })

-- Copy to clipboard and yank line
map("n", "Y", '"+yy', { desc = "Yank Line to Clipboard" })

-- Save more responsive
map("n", "<C-s>", "<cmd>silent! update<cr>", { desc = "Save File" })
map("i", "<C-s>", "<Esc><cmd>silent! update<cr>gi", { desc = "Save File" })

-- Code outline sidebar
map("n", "<leader>o", "<cmd>Outline<cr>", { desc = "Toggle Outline Sidebar" })

-- Ctrl backspace delete word
map("i", "<C-BS>", "<C-w>", { desc = "Delete Previous Word" })
map("i", "<C-h>", "<C-w>", { desc = "Delete Previous Word" })
map("c", "<C-BS>", "<C-w>", { desc = "Delete Previous Word" })
map("c", "<C-h>", "<C-w>", { desc = "Delete Previous Word" })

-- Go to defintions
map("n", "<leader>gd", vim.lsp.buf.definition, { desc = "LSP: Go to Definition" })
map("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "LSP: Go to Implementation" })
