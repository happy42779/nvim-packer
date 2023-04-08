--[[ local status_ok, luadev = pcall(require, 'lua_dev')
if not status_ok then
	return
end
-- sumneko_lua settings
--
luadev.setup({

})
local lspconfig = require("lspconfig")
lspconfig.sumneko_lua.setup(luadev)

local runtime_path = _ENV["vim s"].split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/plugins/?.lua")
lspconfig.sumneko_lua.setup {
	settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = _ENV["vim s"].api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
]]
