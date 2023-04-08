local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local Job = require("plenary.job")

-- disable previews binaries
local previewers = require("telescope.previewers")
local _bad = { ".*%.csv", ".*%.lua" }
local bad_files = function(filepath)
	for _, v in ipairs(_bad) do
		if filepath:match(v) then
			return false
		end
	end
	return true
end

local new_maker = function(filepath, bufnr, opts)
	-- disable highlighting for certain files
	opts = opts or {}
	if opts.use_ft_detect == nil then
		opts.use_ft_detect = true
	end
	opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
	previewers.buffer_previewer_maker(filepath, bufnr, opts)
	-- disable previewers of binary
	filepath = vim.fn.expand(filepath)
	Job:new({
		command = "file",
		args = { "--mime-type", "-b", filepath },
		on_exit = function(j)
			local mime_type = vim.split(j:result()[1], "/")[1]
			if mime_type == "text" then
				previewers.buffer_previewer_maker(filepath, bufnr, opts)
			else
				vim.schedule(function()
					vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
				end)
			end
		end,
	}):sync()
end

telescope.setup({
	defaults = {
		buffer_previewr_maker = new_maker,
		-- prompt_prefix = " ",
		-- selection_caret = " ",
		-- path_display = {
		--     shorten = {
		--         len = 3,
		--         exclude = { 1, -1 },
		--     },
		-- },
		mappings = {
			i = {
				["<M-q>"] = actions.close,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-u>"] = false,
				-- ["<C-d>"] = actions.delete_buffer + actions.move_to_top,
				["<M-p>"] = action_layout.toggle_preview,
			},
			n = {
				["<M-p>"] = action_layout.toggle_preview,
			},
		},
	},
	pickers = {
		find_files = {
			mappings = {
				n = {
					["cd"] = function(prompt_bufnr)
						local selection = require("telescope.actions.state").get_selected_entry()
						local dir = vim.fn.fnamemodify(selection.path, ":p:h")
						actions.close(prompt_bufnr)
						vim.cmd(string.format("silent cd %s", dir))
					end,
				},
			},
			theme = "dropdown",
		},
	},
	extensions = {
		-- fzf syntax
		-- Token	Match type	Description
		-- sbtrkt	fuzzy-match	Items that match sbtrkt
		-- 'wild'	exact-match (quoted)	Items that include wild
		-- ^music	prefix-exact-match	Items that start with music
		-- .mp3$	suffix-exact-match	Items that end with .mp3
		-- !fire	inverse-exact-match	Items that do not include fire
		-- !^music	inverse-prefix-exact-match	Items that do not start with music
		-- !.mp3$	inverse-suffix-exact-match	Items that do not end with .mp3
		fzf = {
			fuzzy = true,                   -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true,    -- override the file sorter
			case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
		aerial = {
			show_nesting = {
				["_"] = false,
				json = true,
				yaml = true,
			},
		},
	},
})

-- load dap as extension
-- telescope.load_extension('dap')
telescope.load_extension("fzf")
telescope.load_extension("ui-select")
-- telescope.load_extension('vim_bookmarks')
telescope.load_extension("live_grep_args")
-- telescope.load_extension('project')
telescope.load_extension("aerial")
