local status_ok, lspconfig, util, cmp_lsp = pcall(function()
	return require "lspconfig", require "lspconfig.util", require "cmp_nvim_lsp"
end)

if not status_ok then
	return
end

-- vim.diagnostic settings
--
local signs = {
	{ name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
}
for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, {texthl = sign.name, text = sign.text, numhl = ""})
end

local config = {
	virtual_text = false,
	--signs = {
	--	active = signs,
	--},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	}
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"})


-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	--vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
	--
	-- highlight string under cursor
	-- if client.server_capabilities.document_highlight then
	-- 	vim.api.nvim_exec(
	-- 		[[
	-- 		augroup lsp_document_hightlight
	-- 			autocmd! * <buffer>
	-- 			autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
	-- 			autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
	-- 		augroup END
	-- 		]], false
	-- 	)
	-- end
	-- add outline support for every language

	require("aerial").on_attach(client, bufnr)
	require("lsp_signature").on_attach()
end

local capabilities
do
	local default_capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = {
		textDocument = {
			completion = {
				completionItem = {
					snippetSupport = true,
				},
			},
			codeAction = {
				resolveSupport = {
					properties = vim.list_extend(default_capabilities.textDocument.codeAction.resolveSupport.properties, {
						"documentation",
						"detail",
						"additionalTextEdits",
					}),
				},
			},
		},
	}
end

util.default_config = vim.tbl_deep_extend("force", util.default_config, {
	capabilities = vim.tbl_deep_extend(
		"force",
		vim.lsp.protocol.make_client_capabilities(),
		cmp_lsp.default_capabilities(capabilities)
	),
})


require('plugins.mason')
require('plugins.mason-lspconfig')

-- require('mason-lspconfig').setup_handlers{
-- 	function (server_name)
-- 		require("lspconfig")[server_name].setup{}
-- 	end,
-- 	-- ["cssls"] = function ()
-- 	-- 	require("plugins.lspserver.ccls")
-- 	-- end,
-- 	-- ["emmet-ls"] = function ()
-- 	-- 	require("plugins.lspserver.emmet_ls")
-- 	-- end,
-- 
-- }

-- setting up language servers through	mason-lspconfig, thus
-- the section below is not needed

--local servers = { 'clangd', 'pyright', 'tsserver', 'sumneko_lua', "bashls", "emmet_ls"}
--for _, lsp in ipairs(servers) do
--	local server_is_found, server = lsp_installer.get_server(lsp)
--	if server_is_found and not server:is_installed() then
--		print("Installing " .. lsp)
--		server:install()
--	end
--
--	lspconfig[lsp].setup {
--		on_attach = on_attach,
--		capabilities = capabilities,
--		flags = {
--			debounce_text_changes = 150,
--		}
--	}
--end

-- Complicated Settings for specific LSP servers
-- all the specific lsp settings have been put in a file
-- respectively named to the language
