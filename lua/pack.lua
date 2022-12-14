-- This file mainly manages plugins with packer
-- If further configuration is needed for a plugin,
-- the config will be located under 'plugins' folder
-- with the same name to the specific plugin

-- Bootstrapping snippet from github README
-- to automatically install packer.nvim on a new machine.
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packet_bootstrap = ensure_packer()

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
return require('packer').startup(function(use)
	--- managing itself ---
	use 'wbthomason/packer.nvim'
	-- startup time
	use 'dstein64/vim-startuptime'

	-- CORE PLUGINS
	-- ----------------------------------------
	-- LSP settings
	use { 'neovim/nvim-lspconfig',
		config = function()
			require('plugins.lspserver.lspconfig')
		end
	}
	-- lsp-installer
	use 'williamboman/nvim-lsp-installer'
	use {
		'ray-x/lsp_signature.nvim',
		config = function()
			require('plugins.lspserver.signature')
		end
	}
	--use {
	--	'tami5/lspsaga.nvim',
	--	config = function()
	--		require("plugins.lspsaga")
	--	end
	--}
	-- completions sources
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use {
		'hrsh7th/nvim-cmp',
		config = function()
			require('plugins.cmp')
		end
	}
	use 'saadparwaiz1/cmp_luasnip'
	use 'lukas-reineke/cmp-rg'
	use 'folke/lua-dev.nvim'
	-- snippets provider
	use 'L3MON4D3/LuaSnip'
	-- snippets sources
	use 'rafamadriz/friendly-snippets'
	-- treesitters
	use {
		'nvim-treesitter/nvim-treesitter', 
		run = function()
			local ts_update = require('nvim-treesitter.install').update({with_sync = true})
			ts_update()
		end,
		config = function()
			require('plugins.treesitter')
		end
	}
	use 'nvim-treesitter/nvim-treesitter-textobjects' -- select, jump by blocks(class, functions, etc)
	use 'romgrk/nvim-treesitter-context' -- show where you are at the top of screen while scrolling

	-- UI
	-- --------------------------
	use 'folke/tokyonight.nvim'
	-- tabs
	use { 'akinsho/bufferline.nvim',
		requires = { 'kyazdani42/nvim-web-devicons' },
		config = function()
			require('plugins.bufferline')
		end
	}
	-- status bar
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons' },
		config = function()
			require('plugins.lualine')
		end
	}
	-- notifier
	use {
		'rcarriga/nvim-notify',
		config = function ()
			require('plugins.notify')
		end
	}

	-- FILE EXPLORER
	-- -------------------------------------
	-- telescope, file finder & explorer
	use {
		'nvim-telescope/telescope.nvim',
		requires = {
			'nvim-lua/plenary.nvim',
		},
		config = function()
			require('plugins.telescope')
		end
	}
	-- search dap-commands, breakpoints
	use 'nvim-telescope/telescope-dap.nvim'
	use {
		'nvim-telescope/telescope-fzf-native.nvim',
		run = "make"
	}
	-- code action?
	use 'nvim-telescope/telescope-ui-select.nvim'
	-- advanced grep search
	use 'nvim-telescope/telescope-live-grep-args.nvim'
	-- add bookmarks
	use 'MattesGroeger/vim-bookmarks'
	-- search bookmarks
	use 'tom-anders/telescope-vim-bookmarks.nvim'
	-- project
	use {
		'nvim-telescope/telescope-project.nvim',
		config = function ()
			require('plugins.project')
		end
	}

	-- nerd tree
	use {
		'kyazdani42/nvim-tree.lua',
		requires = { 'kyazdani42/nvim-web-devicons' },
		config = function()
			require('nvim-tree').setup()
		end
	}

	-- FUNCTIONAL PLUGINS
	--------------------------------------
	-- comments
	use {
		'numToStr/Comment.nvim',
		config = function()
			require("Comment").setup()
		end
	}
	-- automatically add pairs
	use { 'windwp/nvim-autopairs',
		config = function()
			require('plugins.autopairs')
		end
	}
	use { 'folke/todo-comments.nvim' } -- todo list
	use { 'folke/trouble.nvim' } -- quick scan of TODO or FIX ...
	use { 'norcalli/nvim-colorizer.lua' } -- show colors under the hexcode of colors
	use { 'tpope/vim-repeat' } -- . command enhancement
	use { 'tpope/vim-surround' } -- fast wrap?
	use { 'Pocco81/HighStr.nvim' } -- highlight text and even export them
	-- hopping
	use {
		'phaazon/hop.nvim',
		branch = "v1",
		config = function()
			require('hop').setup({
				keys = 'etovxqpdygfblzhckisuran',
				jump_on_sole_occurrence = false
			})
		end
	}
	-- markdown preview
	use {
		'iamcco/markdown-preview.nvim',
		ft = 'markdown',
		run = 'cd app && yarn install',
	}
	-- toggleterm
	use {
		"akinsho/toggleterm.nvim",
		config = function()
			require("plugins.toggleterm")
		end
	}
	-- which key
	use {
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup()
		end
	}
	-- greeter
	use {
		'goolord/alpha-nvim',
		config = function()
			require('plugins.alpha')
		end
	}
	-- aerial
	use {
		'stevearc/aerial.nvim',
		config = function()
			require('plugins.aerial')
		end
	}


	-- DEBUGGER
	-- ----------------------------
	use {
		'mfussenegger/nvim-dap',
		config = function()
			require("plugins.dap.dapconfig")
		end
	}
	use {
		"rcarriga/nvim-dap-ui",
		requires = { "mfussenegger/nvim-dap" },
		config = function()
			require("dapui").setup()
		end
	}
	use {
		"theHamsta/nvim-dap-virtual-text",
		requires = { "mfussenegger/nvim-dap" },
		config = function()
			require("plugins.dap.virtual_text")
			--require("nvim-dap-virtual-text").setup()
		end
	}

	-- CODE NEEDED FOR NEW MACHINE TO INSTALL PACKER.NVIM AUTOMATICALLY
	if packer_bootstrap then
		require('packer').sync()
	end
end)
