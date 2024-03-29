local status_ok, noice = pcall(require, "noice")
if not status_ok then
	vim.notify("Module not found: noice.")
	return
end

noice.setup({
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
			["vim.lsp.signature.enabled"] = false
		},
	},
	presets = {
		bottom_search = true,
		command_pallete = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_broder = false
	},
})
