--- These are NVIM Editor related settings,
-- all plugins related settings should go under the folder `plugins`
-- but there are some exceptions here as they are farely simple
--
--Basic Settings
local set = vim.opt

set.number = true
set.clipboard = "unnamedplus" -- sync with system clipboard
set.confirm = true
set.cursorline = true
-- set.formatoptions = "jcroqlnt"
set.formatoptions = "jcrqlnt"

set.grepformat = "%f:%l:%c:%m"
set.grepprg = "rg --vimgrep"
set.relativenumber = true
set.showmode = false
set.mouse = "a"
set.autoindent = true
set.smartindent = true
set.tabstop = 4
set.shiftwidth = 4
set.smarttab = true
set.softtabstop = 4
set.encoding = "UTF-8"
set.langmenu = "en_US.UTF-8"
-- set.language message = "zh_CN.UTF-8"
set.fileencodings = "ucs-bom,utf-8,cp936,gb18030,big5"
-- using ftplugin
set.filetype = "plugin"

-- whitespaces / indents
set.list = true
set.listchars:append("eol:↴")
set.listchars:append("space:⋅")

set.termguicolors = true

-- folding
-- set.foldmethod = "expr"
--set.foldcolumn = "1"
--set.foldlevel = 99
set.foldlevelstart = 99
---- set.foldexpr = "nvim_treesitter#foldexpr()"
set.foldenable = true

-- markdown preview format settings
-- vim.g.mkdp_auto_close = 0 -- move this line to setup of plugin
-- disable preview of binary type

--- theme
-- set.background = "dark"
-- tokynoight colorscheme settings
-- vim.g.tokyonight_italic_functions = true
-- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000"}
-- vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
-- vim.cmd[[colorscheme catppuccin-mocchiato]]
-- vim.cmd.colorscheme "tokyonight-moon"
