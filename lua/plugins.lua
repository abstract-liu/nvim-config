return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use("github/copilot.vim")

	-- theme
	use("doums/darcula")
	use("morhetz/gruvbox")

	-- auto closer
	use("jiangmiao/auto-pairs")

	-- indent blanline
	use("lukas-reineke/indent-blankline.nvim")

	-- status line
	use("nvim-lualine/lualine.nvim")

	-- complete
	use("neovim/nvim-lspconfig")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")

	-- highlight
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	-- buffer line
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })

	-- formatter
	use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })

	-- file explorer
	use({

		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
	})
end)
