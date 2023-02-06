return require('packer').startup(function(use)
	use 'github/copilot.vim'
    use 'doums/darcula'

    -- file explorer
    use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  }
}

end)
