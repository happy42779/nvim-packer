-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
--vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
--vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
--vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
--vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
--
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
  	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  	-- Mappings.
  	-- See `:help vim.lsp.*` for documentation on any of the below functions
  	--vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  	--vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  	--vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  	--vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  	--vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  	--vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  	--vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  	--vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  	--vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  	--vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  	--vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  	--vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
	-- lspsaga Mappings
	local map = vim.api.nvim_buf_set_keymap
	map(0, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", {silent = true, noremap = true})
	map(0, "n", "gR", "<cmd>Lspsaga rename<CR>", {silent = true, noremap = true})
	map(0, "n", "gh", "<cmd>Lspsaga lsp_finder<CR>", {silent = true, noremap = true})
	map(0, "n", "gx", "<cmd>Lspsaga code_action<CR>", {silent = true, noremap = true})
	map(0, "x", "gx", ":<C-u>Lspsaga range_code_action<CR>", {silent = true, noremap = true})
	map(0, "n", "K",  "<cmd>Lspsaga hover_doc<CR>", {silent = true, noremap = true})
	map(0, "n", "ge", "<cmd>Lspsaga show_line_diagnostics<CR>", {silent = true, noremap = true})
	map(0, "n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", {silent = true, noremap = true})
	map(0, "n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", {silent = true, noremap = true})
	map(0, "n", "gs", "<cmd>Lspsaga signature_help<CR>", {silent = true, noremap = true})
	map(0, "n", "<C-b>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", {})
	map(0, "n", "<C-f>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", {})
	map(0, "n", "<leader> ", "<cmd>Lspsaga open_floaterm<CR>", {silent = true, noremap = true})
	--map(0, "t", "<C-\\><C-n>", "<cmd>Lspsaga close_floaterm<CR>", {silent = true, noremap = true})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

local servers = {'clangd', 'pyright', 'tsserver', 'sumneko_lua', 'bashls'}
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		}
	}
end

-- Complicated Settings for specific LSP servers
-- all the specific lsp settings have been put in a file
-- respectively named to the language
