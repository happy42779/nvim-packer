local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

null_ls.setup({
	-- sources might be used, but some of them
	-- are disabled right now
	-- more options are available here:
	-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#code-actions
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.asmfmt,
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.codespell,
		-- null_ls.builtins.code_actions.eslint_d,
		null_ls.builtins.diagnostics.cspell,
		null_ls.builtins.code_actions.cspell,
	}
})
