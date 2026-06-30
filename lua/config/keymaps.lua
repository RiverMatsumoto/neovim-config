local map = vim.keymap.set

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

