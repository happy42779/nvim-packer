local dap = require('dap')

--- adapters settings
--
dap.adapters.python = {
	type = 'executable';
	command = '';
	args = { '-m', 'debugpy.adapters' };
}
--- adapters configurations
--
dap.configurations.python = {
	{
		type = 'python';
		request = 'launch';
		name = 'Launch file';

		program = "${file}";
		pythonPath = function ()
			local cwd = vim.fn.getcwd()
			if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
				return cwd .. '/venv/bin/python'
			elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
				return cwd .. '/.venv/bin/python'
			else
				return '/usr/bin/python'
			end
		end;
	}
}
