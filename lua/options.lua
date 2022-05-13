--- These are NVIM Editor related settings, 
-- all plugins related settings should go under the folder `plugins`
-- but there are some exceptions here as they are farely simple
--
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
set.langmenu = "en_US.UTF-8"
-- set.language message = "zh_CN.UTF-8"
set.fileencodings = "ucs-bom,utf-8,cp936,gb18030,big5"
set.fileencodings = "utf-8"
-- using ftplugin
set.filetype = "plugin"

set.termguicolors = true
set.hidden = true

-- folding
set.foldmethod = "expr"
set.foldexpr = "nvim_treesitter#foldexpr()"
set.foldenable = false
set.foldlevel = 99

-- markdown preview format settings
vim.g.mkdp_auto_close = 0

--- theme
-- set.background = "dark"
-- tokynight colorscheme settings
vim.g.tokyonight_style = "storm"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000"}
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
vim.cmd[[colorscheme tokyonight]]

