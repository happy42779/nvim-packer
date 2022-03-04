-- local stauts_ok, npairs = pcall(require, "nvim-autopairs")
-- if not  stauts_ok then 
-- 	return
local Rule = require("nvim-autopairs.rule")
local npairs = require("nvim-autopairs")
local ts_conds = require('nvim-autopairs.ts-conds')

-- usign treesitter to check for a pair
npairs.setup ({
	check_ts = true, -- treesitter
	ts_config = {
		lua = { "string", "source" },
		javascript = { "string", "template_string" },
		java = false, -- dont check treesitter on java
	},
	enable_check_bracket_line = false
})


-- press % => %% only while inside a comment string
npairs.add_rules({
	Rule("%", "%", "lua")
		:with_pair(ts_conds.is_ts_node({'string', 'comment'})),
	Rule("$", "$", "lua")
		:with_pair(ts_conds.is_not_ts_node({'functin'}))
})
