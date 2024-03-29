-- This file mainly manages plugins with packer
-- If further configuration is needed for a plugin,
-- the config will be located under 'plugins' folder
-- with the same name to the specific plugin

-- Bootstrapping snippet from github README
-- to automatically install packer.nvim on a new machine.
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- set packer to automatically compile whenever this file is modified
vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost pack.lua source <afile> | PackerCompile
	augroup end
]])

-- elegant way to avoid error, when nothing is installed
-- local status_ok, packer = pcall(require, 'packer')
-- if not status_ok then
-- 	return
-- end

--------------------------------------------------
return require("packer").startup(function(use)
	--- managing itself ---
	use("wbthomason/packer.nvim")
	-- startup time
	-- use 'dstein64/vim-startuptime'

	-- CORE PLUGINS
	-- ----------------------------------------
	-- lsp-installer
	-- changed to mason.nvim
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	})
	-- LSP settings
	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.lspserver.lspconfig")
		end,
	})
	-- null-ls
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("plugins.null-ls")
		end,
	})

	-- try this later
	-- use { 'neoclide/coc.nvim', branch = 'release' }
	--
	-- use {
	-- 	'ray-x/lsp_signature.nvim',
	-- 	config = function()
	-- 		require('plugins.lspserver.signature')
	-- 	end
	-- }
	--use {
	--	'tami5/lspsaga.nvim',
	--	config = function()
	--		require("plugins.lspsaga")
	--	end
	--}
	--
	-- ############################# Desolated Completion configuration ################
	-- completions sources
	--
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-nvim-lua")
	use({
		"hrsh7th/nvim-cmp",
		config = function()
			require("plugins.cmp")
		end,
	})
	-- snippets provider
	use({
		"L3MON4D3/LuaSnip",
		-- snippets sources
		requires = { "rafamadriz/friendly-snippets" },
		-- config = function()
		-- 	-- require('plugins.luasnip')
		-- 	require('luasnip').setup()
		-- end,
		tag = "v<CurrentMajor>.*",
		run = "make install_jsregexp",
	})
	use("saadparwaiz1/cmp_luasnip")
	use("lukas-reineke/cmp-rg")
	use("folke/lua-dev.nvim")
	--
	-- ############################# Desolated Completion configuration ################
	--
	-- ###################### New completion plugin ## #########################
	-- use { 'ms-jpq/coq.nvim', branch = 'coq' }
	-- use { 'ms-jpq/coq.artifacts', branch = 'artifacts'}
	-- file manager. Configure first, try later
	-- use {'ms-jpq/chadtree', branch = 'chad', run = 'python3 -m chadtree deps'}
	--
	-- treesitters
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
		config = function()
			require("plugins.treesitter")
		end,
	})
	use("nvim-treesitter/nvim-treesitter-textobjects") -- select, jump by blocks(class, functions, etc)
	use("romgrk/nvim-treesitter-context")              -- show where you are at the top of screen while scrolling

	-- UI
	-- --------------------------
	-- use {
	-- 	'folke/tokyonight.nvim',
	-- 	config = function ()
	-- 		vim.cmd[[colorscheme tokyonight-storm]]
	-- 	end
	-- }
	use({
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
			})
			vim.cmd([[colorscheme catppuccin-frappe]])
			vim.api.nvim_set_hl(0, "Comment", { fg = "#0c8599", bold = true, italic = true })
		end,
	})

	-- indent-blankline
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				show_end_of_line = true,
				space_char_blankline = " ",
			})
		end,
	})
	-- fold
	use({
		"kevinhwang91/nvim-ufo",
		requires = "kevinhwang91/promise-async",
		config = function()
			local ftMap = {
				vim = "indent,",
				python = { "indent" },
				git = "",
			}
			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return ftMap[filetype], { "treesitter", "indent" }
				end,
			})
		end,
	})

	-- tabs
	use({
		"akinsho/bufferline.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("plugins.bufferline")
		end,
	})
	-- status bar
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("plugins.lualine")
		end,
	})

	-- FILE EXPLORER
	-- -------------------------------------
	-- telescope, file finder & explorer
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins.telescope")
		end,
	})
	-- search dap-commands, breakpoints
	-- use("nvim-telescope/telescope-dap.nvim")
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
	})
	-- code action?
	-- use("nvim-telescope/telescope-ui-select.nvim")
	-- advanced grep search
	use("nvim-telescope/telescope-live-grep-args.nvim")
	-- add bookmarks
	-- use 'MattesGroeger/vim-bookmarks'
	-- search bookmarks
	-- use 'tom-anders/telescope-vim-bookmarks.nvim'
	-- project
	-- use {
	-- 	'nvim-telescope/telescope-project.nvim',
	-- 	config = function()
	-- 		require('plugins.project')
	-- 	end
	-- }

	-- nerd tree
	-- use {
	-- 	'kyazdani42/nvim-tree.lua',
	-- 	requires = { 'kyazdani42/nvim-web-devicons' },
	-- 	config = function()
	-- 		require('nvim-tree').setup()
	-- 	end
	-- }
	-- using neo-tree
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			-- "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				window = {
					width = 30,
				},
			})
		end,
	})

	-- FUNCTIONAL PLUGINS
	--------------------------------------
	-- comments
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	-- automatically add pairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("plugins.autopairs")
			-- require("nvim-autopairs").setup()
		end,
	})
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup()
		end,
	}) -- todo list
	use({
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup()
		end,
	})                            -- quick scan of TODO or FIX ...
	-- use { 'norcalli/nvim-colorizer.lua' } -- show colors under the hexcode of colors
	use({ "tpope/vim-repeat" })   -- . command enhancement
	use({ "tpope/vim-surround" }) -- fast wrap?
	-- use { 'Pocco81/HighStr.nvim' } -- highlight text and even export them
	-- hopping
	use({
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			require("hop").setup({
				keys = "etovxqpdygfblzhckisuran",
				jump_on_sole_occurrence = false,
			})
		end,
	})
	use({
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
		end,
	})
	-- LaTex
	use({
		"lervag/vimtex",
		setup = function()
			vim.g.vimtex_view_method = "mupdf"
			-- vim.g.vimtex_view_general_viewer = "okular"
			-- vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
		end,
		ft = { "tex" },
	})

	-- markdown preview
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_auto_close = 0
		end,
		ft = { "markdown" },
	})
	-- toggleterm
	use({
		"akinsho/toggleterm.nvim",
		config = function()
			require("plugins.toggleterm")
		end,
	})
	-- which key
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup()
		end,
	})
	-- greeter
	use({
		"goolord/alpha-nvim",
		config = function()
			require("plugins.alpha")
		end,
	})
	-- aerial
	use({
		"stevearc/aerial.nvim",
		config = function()
			require("plugins.aerial")
		end,
	})

	-- nui.nvim
	use({
		"MunifTanjim/nui.nvim",
	})

	-- notifier
	use({
		"rcarriga/nvim-notify",
		config = function()
			-- require("plugins.notify")
			require("notify").setup({
				background_colour = "#000000",
			})
		end,
	})
	--
	-- novice
	use({
		"folke/noice.nvim",
		config = function()
			require("noice").setup({
				-- any options here, if needed
			})
		end,
		requires = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	})

	-- DEBUGGER
	-- ----------------------------
	-- use {
	-- 	'mfussenegger/nvim-dap',
	-- 	config = function()
	-- 		require("plugins.dap.dapconfig")
	-- 	end
	-- }
	-- use {
	-- 	"rcarriga/nvim-dap-ui",
	-- 	requires = { "mfussenegger/nvim-dap" },
	-- 	config = function()
	-- 		require("dapui").setup()
	-- 	end
	-- }
	-- use {
	-- 	"theHamsta/nvim-dap-virtual-text",
	-- 	requires = { "mfussenegger/nvim-dap" },
	-- 	config = function()
	-- 		require("plugins.dap.virtual_text")
	-- 		--require("nvim-dap-virtual-text").setup()
	-- 	end
	-- }

	-- CODE NEEDED FOR NEW MACHINE TO INSTALL PACKER.NVIM AUTOMATICALLY
	if packer_bootstrap then
		require("packer").sync()
	end
end)
