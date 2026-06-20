return {
	"mfussenegger/nvim-lint",
	config = function ()
		local lint = require("lint")

	 	vim.api.nvim_create_autocmd({"BufWritePost", "BufReadPost", "InsertLeave" }, {
                	callback = function()
                    		lint.try_lint()
                	end,
            	})
	end
}	
