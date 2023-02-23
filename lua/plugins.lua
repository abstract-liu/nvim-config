return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

	use 'github/copilot.vim'

    -- theme
    use 'doums/darcula'
    use 'morhetz/gruvbox'

    -- auto closer
    use 'jiangmiao/auto-pairs'

    -- file explorer
    use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  }
}

end)
