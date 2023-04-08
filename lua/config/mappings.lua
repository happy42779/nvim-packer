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

-- mapping Esc to something that's close to my thumb
map("i", "jj", "<Esc>", {})

--- neovim Key Mappings
-- 快速左右分屏，并进入到命令模式，等待输入文件名
-- split screen horizontally
map("n", "<LEADER>|", ":vsplit ", { desc = "Vertical split" })
map("n", "<LEADER>_", ":split ", { desc = "Horizontal split" })

-- 快速退出, 用于一切插件打开的窗口退出
-- exit without writing buffer
map("n", "<A-q>", ":q<CR>", { desc = "Fast quit buffer" })
-- map("i", "<A-q>", "<ESC>:q!<CR>", opts)
-- 快速保存
-- write buffer
map("n", "<C-s>", "<cmd>:w<CR>", { desc = "Fast save buffer" })
map("i", "<C-s>", "<ESC><cmd>:w<CR>", { desc = "Fast save buffer" })
-- 快速移动
-- fast moving
map("n", "H", "0", { desc = "Fast move to start of line" })
map("n", "L", "$", { desc = "Fast move to start of line" })

-- Move to the end of line in the INSERT MODE,
-- really helpful when editting in a '', (), [] etc...
map("i", "<A-a>", "<End>", { desc = "Fast move to end of line in insert mode" })
-- Fast moving between windows
map("n", "<C-h>", "<C-w>h", { desc = "Move to the left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to the right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to the below window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to the above window" })
-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Samples learnt from ThePrimeagen
-- map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move blocks down" })
-- move lines
-- map("v", "K", ":m '>-2<CR>gv=gv", { desc = "Move blocks up" })
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", "<cmd>m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", "<cmd>m '<-2<cr>gv=gv", { desc = "Move up" })
-- merge lines without moving the cursor
map("n", "J", "mzJ`z", { desc = "Merge lines" })
-- scroll but with cursor not moved
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
map("n", "<C-u>", "<C-U>zz", { desc = "Merge up" })

-- paste over selected items and keep the copied content
map("x", "<leader>p", [["_dP]], { desc = "paste" })
map("n", "<leader>ax", "<cmd>!chmod +x %<CR>", { desc = "Add x mask" })

-- fast replace
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Fast split window and start a terminal
-- with a set height
map("n", "<leader>t_", "<cmd>split | resize 20 | term<CR>", { desc = "Open a terminal below" })
map("n", "<leader>t|", "<cmd>vsplit | resize 20 | term<CR>", { desc = "Open a terminal right" })

map("n", "  ", "<cmd>nohlsearch<CR>", { desc = "Clear highlight" })

-- Neo-tree
--
map("n", "<LEADER>fe", "<cmd>Neotree toggle focus reveal_force_cwd<CR>", { desc = "Open file explorer" })

-- MarkdownPreview Key Mappings
--
map("n", "<LEADER>mp", "<cmd>MarkdownPreview<CR>", { desc = "Start markdown preview" })
map("n", "<LEADER>ms", "<cmd>MarkdownPreviewStop<CR>", { desc = "Stop markdown preview" })

-- Bufferline Key Mappings
-- normal mode
map("n", "<A-,>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Go to previous buffer" })
map("n", "<A-.>", "<cmd>BufferLineCycleNext<CR>", { desc = "Go to next buffer" })
map("n", "<A-w>", "<cmd>bdelete!<CR>", { desc = "Close current buffer" })
map("n", "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>", { desc = "Go to buffer 1" })
map("n", "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>", { desc = "Go to buffer 2" })
map("n", "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>", { desc = "Go to buffer 3" })
map("n", "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>", { desc = "Go to buffer 4" })
map("n", "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>", { desc = "Go to buffer 5" })
map("n", "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>", { desc = "Go to buffer 6" })
map("n", "<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>", { desc = "Go to buffer 7" })
map("n", "<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>", { desc = "Go to buffer 8" })
map("n", "<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>", { desc = "Go to buffer 9" })

-- Telescope Key Mappings
--
map("n", "<leader>ff", "<cmd>Telescope fd<CR>", { desc = "Telescope find file" })
map("n", "<leader>fl", "<cmd>Telescope live_grep<CR>", { desc = "Telescope live grep" })
map("n", "<leader>fg", "<cmd>Telescope git_status<CR>", { desc = "Telescope git status" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Telescope find buffer" })
map("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Telescope help tags" })
-- map("n", "<leader>fp", ":Telescope project<CR>", {desc = "Telescope project"})
map("n", "<leader>fn", "<cmd>Telescope aerial<CR>", {})
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Telescope find symbol" })
-- map("n", "<leader>fr", ":Telescope lsp_references<CR>", opts)

-- DAP key mappings
--
-- map("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", {desc = "Toggle breakpoint"})
-- map("n", "<leader>dB", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<CR>", {desc = "Toggle breakpoint with condition"})
-- map("n", "<leader>dr", "<cmd>lua require'dap'.repl.open()<cr>", {desc = "Open repl"})
-- map("n", "<leader>dl", "lua require'dap'.run_last()<CR>", {desc = "Run last"})
-- map('n', '<leader>0', "lua require'dap'.reload_continue()<CR>", {desc = "Reload debug"})
-- map("n", "<leader>4", ":lua require'dap'.terminate()<CR>", {desc = "Terminate dap"})
-- map("n", "<leader>5", ":lua require'dap'.continue()<CR>", {desc = "Continue  or start debugging"})
-- map("n", "<leader>6", ":lua require'dap'.step_over()<CR>", {desc = "Step over"})
-- map("n", "<leader>7", ":lua require'dap'.step_into()<CR>", {desc = "Step into"})
-- map("n", "<leader>8", ":lua require'dap'.step_out()<CR>", {desc = "Step out"})
-- map("n", "K", ":lua require'dapui'.eval()<CR>", {desc = "Show eval"})
-- map("n", "<leader>dt", ":lua require'dapui'.toggle()<CR>", {desc = "Toggle dapui"})
-- map("n", "<leader>dx", ":lua require'dap'.terminate()<CR>", {desc = "Terminate dap"})

-- Toggle terminal
-- ctrl + \ is working even better

-- Notify
map("n", "<learder>un", "<cmd>lua require'notify'.dismiss()<CR>", { desc = "Dismiss all notifications" })

-- HOPPING
map("n", "<leader>ll", "<cmd>HopLine<CR>", { desc = "Leap to lines" })
--

-- Fast Function Jumper
-- map('n', "<leader>fn", "<cmd>AerialToggle<CR>", {})

-- Fold remappings with ufo
map("n", "zR", "<cmd>lua require'ufo'.openAllFolds()<cr>", { desc = "Open all folds" })
map("n", "zM", "<cmd>lua require'ufo'.closeAllFolds()<cr>", { desc = "Close all folds" })
