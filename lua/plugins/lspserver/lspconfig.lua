local status_ok, lspconfig, mason_lspconf, util, cmp_lsp = pcall(function()
	return require "lspconfig", require "mason-lspconfig", require "lspconfig.util", require "cmp_nvim_lsp"
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
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
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

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })


-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']e', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)

	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<space>f', function()
		vim.lsp.buf.format { async = true }
	end, bufopts)
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

	-- not needed anymore
	--require("aerial").on_attach(client, bufnr)
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

-- Settings has been moved here, so no need to put
-- configs in a file
-- require('plugins.mason-lspconfig')

-- settings for mason_lspconf
-- this has to be here, because we need to set on_attach function
-- for each language server

mason_lspconf.setup({
	ensured_installed = { 'clangd', 'ccls', 'bashls', 'eslint', 'emmet_ls' },
	automatic_installation = true;
})
mason_lspconf.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup {
			on_attach = on_attach,
			capabilities = cmp_lsp.default_capabilities()
		}
	end,
})

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
