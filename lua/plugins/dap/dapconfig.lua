local status_ok, dap = pcall(require, 'dap')
if not status_ok then
	vim.notify("dap not loaded!")
	return 
end

--- adapters settings
--
dap.adapters.python = {
	type = 'executable';
	command = '';
	args = { '-m', 'debugpy.adapters' };
}

dap.adapters.lldb = {
	type = 'executable',
	command = '/usr/bin/lldb-vscode-11',
	name = 'lldb'
}

-- set the log level
dap.set_log_level('TRACE')

-- setup dapui configurations
-- dapui will be toggled automatically when
-- the debugger is launched
--
local dapui = require('dapui')
dap.listeners.after.event_initialized["dapui_config"] = function ()
	dapui.open()
	--vim.api.nvim_command("DapVirtualTextEnable")
end
dap.listeners.before.event_terminated["dapui_config"] = function ()
	--vim.api.nvim_command("DapVirtualTextDisable")
	dapui.close()
	dap.repl.close()
end
dap.listeners.before.event_exited["dapui_config"] = function ()
	--vim.api.nvim_command("DapVirtualTextDisable")
	dapui.close()
	dap.repl.close()
end
dap.listeners.before.disconnect["dapui_config"] = function ()
	--vim.api.nvim_command("DapVirtualTextDisable")
	dapui.close()
	dap.repl.close()
end

-- debugger sign configuration
-- 
local dap_signs = {
	breakpoint = {
      text = "🛑",
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
    },
    rejected = {
      text = "",
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = "",
    },
    --stopped = {
    --  text = "⭐️",
    --  texthl = "LspDiagnosticsSignInformation",
    --  linehl = "DiagnosticUnderlineInfo",
    --  numhl = "LspDiagnosticsSignInformation",
    --}
}
vim.fn.sign_define("DapBreakpoint", dap_signs.breakpoint)
vim.fn.sign_define("DapBreakpointRejected", dap_signs.rejected)
--vim.fn.sign_define("DapStopped", dap_signs.stopped)
--
-- adapters configurations
-- configurations has been put into separate files
-- named respectively to the specific language
require('plugins.dap.cpp')
require('plugins.dap.python')
