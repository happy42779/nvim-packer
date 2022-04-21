-- defining a lua function to remap keys
local function map(mode, lhs, rhs, opts)
	local options = {noremap = true}
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
	-- setting the leader key to ';'
	vim.g.mapleader = ";"

--- neovim Key Mappings
-- 快速左右分屏，并进入到命令模式，等待输入文件名
-- split screen horizontally
-- map("n", "<LEADER>h", ":vsplit ", opts)
-- 快速上下分平，并进入到命令模式，等待输入文件名
-- split screen vertically
-- map("n", "<LEADER>j", ":split ", opts)
-- 快速退出，有改变就保存，没改变就直接退出
-- Write and exit if there's buffer, or exit if there's not 
map("n", "<C-q>", ":x<CR>", opts)
map("i", "<C-q>", "<ESC>:x<CR>", opts)
-- 快速退出, 用于一切插件打开的窗口退出
-- exit without writing buffer
map("n", "<A-q>", ":q<CR>", opts)
-- map("i", "<A-q>", "<ESC>:q!<CR>", opts)
-- 快速保存
-- write buffer
map("n", "<C-s>", ":w<CR>", opts)
map("i", "<C-s>", "<ESC>:w<CR>", opts)
-- 快速移动
-- fast moving
-- map("n", "<C-k>", "5k", opts)
-- map("n", "<C-j>", "5j", opts)
-- Move to the start/end of the line
map("n", "H", "0", opts)
map("n", "L", "$", opts)

-- Move to the end of line in the INSERT MODE,
-- really helpful when editting in a '', (), [] etc...
map("i", "<A-d>", "<End>", opts)
map("i", "<A-a>", "<Home>", opts)

-- Fast moving between windows
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)

-- Fast split window and start a terminal
-- with a set height
map("n", "<C-t>", ":split | resize 20 | term<CR>", opts)

--map("n", "<CR><LEADER>", ":nohlsearch<CR>", opts)


-- NvimTree Key Mappings
map("n", "<LEADER>n", ":NvimTreeFocus<CR>", opts)
map("n", "<LEADER>t", ":NvimTreeToggle<CR>", opts)
-- map("n", "<LEADER>f", ":NvimTreeFind<CR>", opts)

-- MarkdownPreview Key Mappings
map("n", "<LEADER>p", ":MarkdownPreview<CR>", opts)
map("n", "<LEADER>s", ":MarkdownPreviewStop<CR>", opts)

-- Bufferline Key Mappings
-- normal mode
map("n", "<A-,>", ":BufferLineCyclePrev<CR>", {silent = true})
map("n", "<A-.>", ":BufferLineCycleNext<CR>", {silent = true})
map("n", "<A-w>", ":bdelete!<CR>", {silent = true})
map("n", "<A-1>", ":BufferLineGoToBuffer 1<CR>", {silent = true})
map("n", "<A-2>", ":BufferLineGoToBuffer 2<CR>", {silent = true})
map("n", "<A-3>", ":BufferLineGoToBuffer 3<CR>", {silent = true})
map("n", "<A-4>", ":BufferLineGoToBuffer 4<CR>", {silent = true})
map("n", "<A-5>", ":BufferLineGoToBuffer 5<CR>", {silent = true})
map("n", "<A-6>", ":BufferLineGoToBuffer 6<CR>", {silent = true})
map("n", "<A-7>", ":BufferLineGoToBuffer 7<CR>", {silent = true})
map("n", "<A-8>", ":BufferLineGoToBuffer 8<CR>", {silent = true})
map("n", "<A-9>", ":BufferLineGoToBuffer 9<CR>", {silent = true})

-- Telescope Key Mappings
map("", "<leader>ff", ":Telescope find_files<CR>", {silent = true})
map("", "<leader>fg", ":Telescope live_grep<CR>", {silent = true})
map("", "<leader>fb", ":Telescope buffers<CR>", {silent = true})
map("", "<leader>fh", ":Telescope help_tags<CR>", {silent = true})

-- DAP key mappings
map("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
map("n", "<leader>dB", ":lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<CR>", opts)
map("n", "<leader>dr", "lua require'dap'.repl.open()<cr>", opts)
map("n", "<leader>dl", "lua require'dap'.run_last()<CR>", opts)
map('n', '<F10>', ':lua require"user.dap.dap-util".reload_continue()<CR>', opts)
map("n", "<leader>4", ":lua require'dap'.terminate()<CR>", opts)
map("n", "<leader>5", ":lua require'dap'.continue()<CR>", opts)
map("n", "<leader>6", ":lua require'dap'.step_over()<CR>", opts)
map("n", "<leader>7", ":lua require'dap'.step_into()<CR>", opts)
map("n", "<leader>8", ":lua require'dap'.step_out()<CR>", opts)
map("n", "K", ":lua require'dapui'.eval()<CR>", opts)
map("n", "<leader>dt", ":lua require'dapui'.toggle()<CR>", opts)
map("n", "<leader>dx", ":lua require'dap'.terminate()<CR>", opts)
