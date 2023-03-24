local stauts_ok, npairs = pcall(require, "nvim-autopairs")
if not stauts_ok then
    return
end

local Rule = require("nvim-autopairs.rule")
local ts_conds = require("nvim-autopairs.ts-conds")
local conds = require("nvim-autopairs.conds")

-- usign treesitter to check for a pair
npairs.setup({
    check_ts = true, -- treesitter
    ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false, -- dont check treesitter on java
    },
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
    enable_check_bracket_line = false,
    -- fast wrap, very useful if you want to add any wrappings to existing content
    -- using alt+e
    fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = -1, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "Search",
        highlight_grey = "Comment",
    },
})

-- press % => %% only while inside a comment string
npairs.add_rules({
    -- Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
    -- Rule("$", "$", "lua")
    -- 	:with_pair(ts_conds.is_not_ts_node({'functin'}))
    --
    -- 	Rules for adding space after and before brackets
    Rule(" ", " "):with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({ "()", "[]", "{}" }, pair)
    end),
    Rule("( ", " )")
        :with_pair(function()
            return false
        end)
        :with_move(function(opts)
            return opts.prev_char:match(".%)") ~= nil
        end)
        :use_key(")"),
    Rule("{ ", " }")
        :with_pair(function()
            return false
        end)
        :with_move(function(opts)
            return opts.prev_char:match(".%}") ~= nil
        end)
        :use_key("}"),
    Rule("[ ", " ]")
        :with_pair(function()
            return false
        end)
        :with_move(function(opts)
            return opts.prev_char:match(".%]") ~= nil
        end)
        :use_key("]"),
    -- Rules for => functions in js
    Rule("%(.*%)%s*%=>$", " {  }", { "typescript", "typescriptreact", "javascript" })
        :use_regex(true)
        :set_end_pair_length(2),

    -- Rules for space before and after a =
    -- ignoring .sh files, as space is not allowed before or after =
    Rule("=", "", { "-sh", "-zshrc" })
        :with_pair(conds.not_inside_quote())
        :with_pair(function(opts)
            local last_char = opts.line:sub(opts.col - 1, opts.col - 1)
            if last_char:match("[%w%=%s]") then
                return true
            end
            return false
        end)
        :replace_endpair(function(opts)
            local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
            local next_char = opts.line:sub(opts.col, opts.col)
            next_char = next_char == " " and "" or " "
            if prev_2char:match("%w$") then
                return "<bs> =" .. next_char
            end
            if prev_2char:match("%=$") then
                return next_char
            end
            if prev_2char:match("=") then
                return "<bs><bs>=" .. next_char
            end
            return ""
        end)
        :set_end_pair_length(0)
        :with_move(conds.none())
        :with_del(conds.none()),
})
