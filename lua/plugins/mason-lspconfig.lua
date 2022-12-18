local status_ok, mason_lspconf = pcall(require, 'mason-lspconfig')
if not status_ok then
	return
end

mason_lspconf.setup({
	ensured_installed = {'clangd', 'ccls', 'bashls', 'eslint', 'emmet_ls', 'sumneko_lua'},
	automatic_installation = true;
})
mason_lspconf.setup_handlers({
	function (server_name)
		require("lspconfig")[server_name].setup{}
	end,
	-- ["cssls"] = function ()
	-- 	require("plugins.lspserver.ccls")
	-- end,
	-- ["emmet-ls"] = function ()
	-- 	require("plugins.lspserver.emmet_ls")
	-- end,

})
