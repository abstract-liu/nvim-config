return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        replace_netrw = true,
      },
    },
    keys = {
      -- Deprecated Old
      { "<leader><space>", map = false, desc = "(Deprecated) Find Files (Root Dir)" },
      { "<leader>e", map = false, desc = "(Deprecated) Explorer Snacks (root dir)" },
      { "<leader>E", map = false, desc = "(Deprecated) Explorer Snacks (cwd)" },

      -- Find Files
      { "<leader>e", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },

      -- Explorer
      { "<leader>1", "<leader>fe", desc = "Explorer Snacks (Root Dir)", remap = true },
    },
  },
}
