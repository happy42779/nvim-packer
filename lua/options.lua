--Basic Settings 
local set = vim.opt
set.number = true
set.relativenumber = true
set.mouse= "a"
set.autoindent = true
set.tabstop=4
set.shiftwidth=4
set.smarttab = true
set.softtabstop = 4
set.encoding = "UTF-8"
set.langmenu = "zh_CN.UTF-8"
--- set.language message = "zh_CN.UTF-8"
set.fileencodings = "ucs-bom,utf-8,cp936,gb18030,big5"
set.fileencodings = "utf-8"



set.termguicolors = true

--- theme
-- set.background = "dark"

--- markdown preview format settings
vim.g.nvim_markdown_preview_format = "markdown"

vim.g.nvim_markdown_preview_theme = "solarized-light"

--- nvim colorscheme settings
vim.g.tokyonight_style = "storm"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000"}
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
vim.cmd[[colorscheme tokyonight]]
