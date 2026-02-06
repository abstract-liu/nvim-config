-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--local map = vim.api.nvim_set_keymap
local map = vim.keymap.set
local opt = { noremap = true, silent = true }

map("v", "<C-y>", '"+y', opt)

-- floating terminal
map("n", "<C-`>", function()
  Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "Terminal (Root Dir)" })

-- Terminal Mappings
map("t", "<C-`>", "<cmd>close<cr>", { desc = "Debug Hide Terminal" })

-- format
map("n", "<leader>l", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format document" })
