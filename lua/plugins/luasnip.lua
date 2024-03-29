local status_ok, ls = pcall(function()
	return require('luasnip')
end)

if not status_ok then
	return
end

-- require('luasnip.loaders.from_vscode').lazy_load();
ls.setup({
	opts = {
		history = true,
		delete_check_events = 'TextChanged'
	},
	keys = {
		{
			"<Tab>",
			function()
				return require('luasnip').jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
			end,
			expr = true, silent = true, mode = "i"
		},
		{
			"<Tab>",
			function()
				require('luasnip').jump(1)
			end,
			mode = "s"
		},
		{
			"<S-Tab>",
			function()
				require('luasnip').jump(-1)
			end,
			mode = { "i", "s" }
		}
	},
})
