return {

  -- theme colorscheme
  { "morhetz/gruvbox" },
  { "folke/tokyonight.nvim", enabled = false },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- snacks dashboard
  {
    "snacks.nvim",
    opts = {
      dashboard = { enabled = false },
    },
  },
}
