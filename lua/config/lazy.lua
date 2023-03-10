local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	--  themes
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	-- cmp and luasnip
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "v<CurrentMajor>.*",
		build = "make install_jsregexp",
	},
	{
		"hrsh7th/nvim-cmp",
		-- load cmp on InsertEnter
		event = "InsertEnter",
		-- these dependencies will only be loaded when cmp loads
		dependencies = {
			-- dependencies are always lazy-loaded unless specified otherwise
			{ "hrsh7th/cmp-nvim-lsp", config = true },
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lua",
		},
		config = function()
			require("plugins.cmp").setup()
		end,
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		config = true,
	},
	{
		"nvim-lua/plenary.nvim",
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("plugins.null-ls")
		end,
	},
	-- lsp and related plugins
	{

		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		opts = {
			ensure_installed = {
				"stylua",
				"flake8",
			},
		},
		config = function(plugin, opts)
			---@param opts MasonSettings | {ensure_installed: string[]}
			require("mason").setup(opts)
			local mr = require("mason-registry")
			for _, tool in ipairs(opts.ensure_installed) do
				local p = mr.get_package(tool)
				if not p:is_installed() then
					p:install()
				end
			end
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.lspserver.lspconfig")
		end,
	},
	-- treesitter

	{
		"nvim-treesitter/nvim-treesitter",
		-- build = function()
		-- 	local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
		-- 	ts_update()
		-- end,
		build = ":TSUpdate",
		config = function()
			require("plugins.treesitter")
		end,
	},
	{ -- select, jump by blocks(class, functions, etc)
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	{ -- show where you are at the top of screen while scrolling
		"romgrk/nvim-treesitter-context",
	},
	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins.telescope")
		end,
	},
	-- search dap-commands, breakpoints
	{ "nvim-telescope/telescope-dap.nvim", enabled = false },

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	-- code action?
	{ "nvim-telescope/telescope-ui-select.nvim" },

	-- advanced grep search
	{ "nvim-telescope/telescope-live-grep-args.nvim" },

	-- neo-tree
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
		end,
	},
})
