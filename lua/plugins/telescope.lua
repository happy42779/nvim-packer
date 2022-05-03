local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

telescope.setup({
	extensions = {

	}
})

-- load dap as extension
telescope.load_extension('dap')
