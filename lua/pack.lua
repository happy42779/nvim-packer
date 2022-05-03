-- This file mainly manages plugins with packer
-- If further configuration is needed for a plugin,
-- the config will be located under 'plugins' folder
-- with the same name to the specific plugin

-- Bootstrapping snippet from github README 
-- to automatically install packer.nvim on a new machine.
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- set packer to automatically compile whenever this
-- file is modified
vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost pack.lua source <afile> | PackerCompile
	augroup end
]])

-- elegant way to avoid error, when nothing is installed
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
	return
end

--------------------------------------------------
return require('packer').startup(function()
	--- managing itself ---
	use 'wbthomason/packer.nvim'

	-- LSP settings
	use	{'neovim/nvim-lspconfig',
		config = function()
			require('plugins.lspserver.lspconfig')
		end
	}
	-- use 'nvim-lsp-installer' -- isolated
	-- use this on instead
	use 'williamboman/nvim-lsp-installer'
	use {
		'ray-x/lsp_signature.nvim',
		config = function ()
			require('plugins.lspserver.signature')
		end
	}
	use {
		'tami5/lspsaga.nvim',
		config = function()
			require("plugins.lspsaga")
		end
	}

	-- completions
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
	use 'lukas-reineke/cmp-rg'

	-- treesitters
	use {
		'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
		config = function ()
			require('plugins.treesitter')
		end
	}
	use 'nvim-treesitter/nvim-treesitter-textobjects'
	use 'romgrk/nvim-treesitter-context'

	use	{ 'iamcco/markdown-preview.nvim', ft = 'markdown', run = 'cd app && yarn install' }

	-- nerd tree
	use {
		'kyazdani42/nvim-tree.lua',
		requires = { 'kyazdani42/nvim-web-devicons' },
		config = function ()
			require('nvim-tree').setup()
		end
	}

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

	-- telescope, file finder & explorer
	use {
	  'nvim-telescope/telescope.nvim',
	  requires = {
		  'nvim-lua/plenary.nvim',
		  'nvim-telescope/telescope-dap.nvim'
	  },
	  config = function ()
		  require('plugins.telescope')
	  end
	}

	use { 'akinsho/bufferline.nvim',
		requires = { 'kyazdani42/nvim-web-devicons' },
		config = function()
			require('plugins.bufferline')
		end
	}

	use {
		'numToStr/Comment.nvim',
		config = function()
			require("Comment").setup()
		end
	}

	-- greeter
	use {
		'goolord/alpha-nvim',
		config = function()
			require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
		end
	}


	-- debugger
	use {
		'mfussenegger/nvim-dap',
		config = function()
			require("plugins.dap.dapconfig")
		end
	}
	use {
		"rcarriga/nvim-dap-ui",
		requires = { "mfussenegger/nvim-dap" },
		config = function ()
			require("dapui").setup()
		end
	}
	use {
		"theHamsta/nvim-dap-virtual-text",
		requires = { "mfussenegger/nvim-dap" },
		config = function ()
			require("plugins.dap.virtual_text")
			--require("nvim-dap-virtual-text").setup()
		end
	}

	-- toggleterm
	--
	use {
		"akinsho/toggleterm.nvim",
		config = function ()
			require("plugins.toggleterm")
		end
	}

	-- lua-dev
	use 'folke/lua-dev.nvim'

	-- which key
	--
	use {
		"folke/which-key.nvim",
		config = function ()
			require("which-key").setup()
		end
	}

	-- code needed for new machine to install packer.nvim automatically
	if PACKER_BOOTSTRAP then
		require('packer').sync()
	end
end)
