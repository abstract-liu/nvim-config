vim.g.mapleader = " "
local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }
-- Visual模式 复制到系统剪贴板
map("v", "<C-y>", '"+y', opt)

-- Normal模式
-- 打开nvim-tree
map("n", "<leader>1", ":NvimTreeToggle<CR>", opt)
-- 窗口跳转
map("n", "<leader><Tab>", "<C-W>w", opt)
