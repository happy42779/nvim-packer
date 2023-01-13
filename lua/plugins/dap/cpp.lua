-- dap configuration for c/cpp/rust
local dap = require('dap')

dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function ()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		args = {},
		runInTerminal = false,
		-- postRunCommands = {'process handle -p true -s false -n false SIGWINCH'}
	},
	{
		env = function()
			local variables = {}
			for k, v in paris(vim.fn.environ()) do
				table.insert(variables, string.format("%s=%s", k, v))
			end
			return variables
		end
	}
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
