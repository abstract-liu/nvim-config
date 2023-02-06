local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }
-- Visual模式 复制到系统剪贴板
map("v", "<C-y>", '"+y', opt)
