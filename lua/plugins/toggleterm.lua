local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

-- default configurations
toggleterm.setup({
	-- size can be a number or function which is passed the current terminal
	--size = function(term)
	--  if term.direction == "horizontal" then
	--    return 15
	--  elseif term.direction == "vertical" then
	--    return vim.o.columns * 0.4
	--  end
	--end,
	size = 20,
	open_mapping = [[<c-\>]],
	-- on_open = fun(t: Terminal), -- function to run when the terminal opens
	-- on_close = fun(t: Terminal), -- function to run when the terminal closes
	-- on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
	-- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
	-- on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
	hide_numbers = true, -- hide the number column in toggleterm buffers
	shade_filetypes = {},
	--shade_terminals = true,
	shading_factor = "1",     -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
	start_in_insert = true,
	insert_mappings = true,   -- whether or not the open mapping applies in insert mode
	terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
	persist_size = true,
	direction = "float",      --'float',		-- 'vertical',
	close_on_exit = true,     -- close the terminal window when the process exits
	shell = vim.o.shell,      -- change the default shell
	-- This field is only relevant if direction is set to 'float'
	float_opts = {
		-- The border key is *almost* the same as 'nvim_open_win'
		-- see :h nvim_open_win for details on borders however
		-- the 'curved' border is a custom border type
		-- not natively supported but implemented in this plugin.
		border = "curved",
		width = 100,
		height = 30,
		winblend = 3,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

-- functions to set keybindings right after the term is toggled
--
-- This is not working as well as the default keybindings?
-- function _G.set_terminal_keymaps()
-- 	local opts = { noremap = true }
-- 	vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
-- 	vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-w>h]], opts)
-- 	vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-w>j]], opts)
-- 	vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-w>k]], opts)
-- end

-- vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
