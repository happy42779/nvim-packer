local dap = require('dap')

--- adapters settings
--
dap.adapters.python = {
	type = 'executable';
	command = '';
	args = { '-m', 'debugpy.adapters' };
}

dap.adapters.lldb = {
	type = 'executable',
	command = '/usr/bin/lldb-vscode',
	name = 'lldb'
}

-- adapters configurations
-- configurations has been put into separate files
-- named respectively to the specific language
require('plugins.dap.cpp')
require('plugins.dap.python')
