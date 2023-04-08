vim.api.nvim_set_keymap("n", "<A-o>", "<cmd>ClangdSwitchSourceHeader<cr>", {})
-- this is to stop neovim from automatically adding // for a new line
-- after a comment line for c, cpp
-- vim.opt.formatoptions = "jcrqlnt"
