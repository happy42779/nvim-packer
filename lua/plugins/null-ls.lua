local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
    return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
    -- sources might be used, but some of them
    -- are disabled right now
    -- more options are available here:
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#code-actions
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.asmfmt,
        -- null_ls.builtins.formatting.clang_format,
        -- null_ls.builtins.diagnostics.clang_check,
        -- null_ls.builtins.formatting.codespell,
        -- null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.diagnostics.cspell,
        null_ls.builtins.code_actions.cspell,
        -- null_ls.builtins.formatting.pyright
        -- hello
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    -- vim.lsp.buf.formatting_sync()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
})
