return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

	use 'github/copilot.vim'

    -- theme
    use 'doums/darcula'
    use 'morhetz/gruvbox'

    -- auto closer
    use 'jiangmiao/auto-pairs'

    -- complete
    use 'neovim/nvim-lspconfig' 
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    -- highlight
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })


    -- file explorer
    use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  }
}

end)
