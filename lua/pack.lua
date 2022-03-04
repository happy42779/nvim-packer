-- This file mainly manages plugins with packer
-- If further configuration is needed for a plugin,
-- the config will be located under 'plugins' folder
-- with the same name to the specific plugin


-- set packer to automatically compile whenever this
-- file is modified
vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost pack.lua source <afile> | PackerCompile
	augroup end
]])

--------------------------------------------------
return require('packer').startup(function()
	--- managing itself ---
	use 'wbthomason/packer.nvim'

	use	{'neovim/nvim-lspconfig', 
		config = function()
			require('plugins.lspconfig')
		end
	}
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip'
	use { 'hrsh7th/nvim-cmp', 
		config = function()
			require('plugins.cmp')
		end
	}

	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

	use	{ 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' }

	use 'preservim/nerdtree'

	use 'folke/tokyonight.nvim'
	
	use  { 'windwp/nvim-autopairs',
		config = function()
			require('plugins.autopairs')
		end
	}
	
	use {
		'nvim-lualine/lualine.nvim', 
		requires = { 'kyazdani42/nvim-web-devicons' },
		config = function()
			require('plugins.lualine')
		end
	}

	use {
	  'nvim-telescope/telescope.nvim',
	  requires = {'nvim-lua/plenary.nvim'}
	}
	
	use { 'akinsho/bufferline.nvim', 
		requires = { 'kyazdani42/nvim-web-devicons' },
		config = function()
			require('plugins.bufferline')
		end
	}

end)
----------------------------------------------------
------------ CUSTOM PLUGIN SETTINGS ----------------
