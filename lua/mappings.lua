-- defining a lua function to remap keys
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
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
map("n", "<LEADER>|", ":vsplit ", opts)
-- 快速上下分平，并进入到命令模式，等待输入文件名
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

map("n", "<leader> ", ":nohlsearch<CR>", opts)

-- Clang key mappings
--
-- map('n', "<A-o>", "<cmd>ClangdSwitchSourceHeader<cr>", opts)


-- Fast indent
--
--map('n', "<C-,>", "<S-,><cr>", opts)
--map('n', "<C-.>", "<S-.><cr>", opts)

-- NvimTree Key Mappings
--
map("n", "<LEADER>n", ":NvimTreeFindFile<CR>", opts)
map("n", "<LEADER>t", ":NvimTreeToggle<CR>", opts)
-- map("n", "<LEADER>f", ":NvimTreeFind<CR>", opts)

-- MarkdownPreview Key Mappings
--
map("n", "<LEADER>mp", ":MarkdownPreview<CR>", opts)
map("n", "<LEADER>ms", ":MarkdownPreviewStop<CR>", opts)

-- Bufferline Key Mappings
-- normal mode
map("n", "<A-,>", ":BufferLineCyclePrev<CR>", opts)
map("n", "<A-.>", ":BufferLineCycleNext<CR>", opts)
map("n", "<A-w>", ":bdelete!<CR>", opts)
map("n", "<A-1>", ":BufferLineGoToBuffer 1<CR>", opts)
map("n", "<A-2>", ":BufferLineGoToBuffer 2<CR>", opts)
map("n", "<A-3>", ":BufferLineGoToBuffer 3<CR>", opts)
map("n", "<A-4>", ":BufferLineGoToBuffer 4<CR>", opts)
map("n", "<A-5>", ":BufferLineGoToBuffer 5<CR>", opts)
map("n", "<A-6>", ":BufferLineGoToBuffer 6<CR>", opts)
map("n", "<A-7>", ":BufferLineGoToBuffer 7<CR>", opts)
map("n", "<A-8>", ":BufferLineGoToBuffer 8<CR>", opts)
map("n", "<A-9>", ":BufferLineGoToBuffer 9<CR>", opts)

-- Telescope Key Mappings
--
map("n", "<leader>ff", ":Telescope fd<CR>", opts)
map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
map("n", "<leader>fb", ":Telescope buffers<CR>", opts)
map("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
map("n", "<leader>fp", ":Telescope project<CR>", opts)
map("n", "<leader>fr", ":Telescope oldfiles<CR>", opts)

-- DAP key mappings
--
map("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
map("n", "<leader>dB", ":lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<CR>", opts)
map("n", "<leader>dr", "lua require'dap'.repl.open()<cr>", opts)
map("n", "<leader>dl", "lua require'dap'.run_last()<CR>", opts)
-- map('n', '<leader>0', ':lua require'dap'.reload_continue()<CR>', opts)
map("n", "<leader>4", ":lua require'dap'.terminate()<CR>", opts)
map("n", "<leader>5", ":lua require'dap'.continue()<CR>", opts)
map("n", "<leader>6", ":lua require'dap'.step_over()<CR>", opts)
map("n", "<leader>7", ":lua require'dap'.step_into()<CR>", opts)
map("n", "<leader>8", ":lua require'dap'.step_out()<CR>", opts)
map("n", "K", ":lua require'dapui'.eval()<CR>", opts)
map("n", "<leader>dt", ":lua require'dapui'.toggle()<CR>", opts)
map("n", "<leader>dx", ":lua require'dap'.terminate()<CR>", opts)


-- Toggle terminal
-- ctrl + \ is working even better
-- map("n", "<leader>ft", ":ToggleTerm<CR>", opts)
-- map("t", "<leader>ft", ":ToggleTerm<CR>", opts)

-- highlight str
-- there's error, not knowing why at this time
--map("v", "<leader>ha", ":<c-u>HSHighlight 1<CR>", {silent = true})
--map("v", "<leader>hr", ":<c-u>HSRmHighlight 1<CR>", {silent = true})

-- Toggle transparent background
map("n", "<leader><leader>tr", ":TransparentToggle<CR>", opts)


-- HOPPING
--
map('n', 'f',
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
	, {})
map('n', 'F',
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
	, {})
map('o', 'f',
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>"
	, {})
map('o', 'F',
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>"
	, {})

-- specifying no mode will cause completion conflicting with this keybinding, when typing a word starting with 't'
-- map('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
-- map('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
map('n', 't',
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
	, {})
map('n', 'T',
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
	, {})

map('n', "<leader><leader>w", "<cmd>HopWord<CR>", {})
map('n', "<leader><leader>j", "<cmd>HopLine<CR>", {})
map('n', "<leader><leader>k", "<cmd>HopLine<CR>", {})
map('n', "<leader><leader>s", "<cmd>HopChar1<CR>", {})

-- map('n', '<leader>e', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>", {})
-- map('v', '<leader>e', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>", {})
-- map('o', '<leader>e', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END, inclusive_jump = true })<cr>", {})
