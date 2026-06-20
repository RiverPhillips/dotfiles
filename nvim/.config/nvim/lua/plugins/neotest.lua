return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		{
			"fredrikaverpil/neotest-golang",
			version = "*",
			dependencies = {
				"leoluz/nvim-dap-go",
				"andythigpen/nvim-coverage",
			}
		},
		"mrcjkb/rustaceanvim"
	},
	config = function()
		local neotest = require("neotest")

		local neotest_golang_opts = {
			runner = "go",
			go_test_args = {
				"-v",
				"-race",
				"-count=1",
				"-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
			},
		}

		neotest.setup({
			adapters = {
				require("neotest-golang")(neotest_golang_opts),
				require('rustaceanvim.neotest'),
			},
		})
	end,
	keys = {
		{
			"<leader>td",
			function()
				require("neotest").run.run({ strategy = "dap", suite = false })
			end,
			desc = "Debug nearest test"
		},
		{
			"<leader>tr",
			function()
				local neotest = require("neotest")
				neotest.run.run(vim.fn.expand("%"))
				neotest.summary.open()
			end,
			desc = "Run all tests"
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Show test summary"

		},
		{
			"<leader>tst",
			function()
				require("neotest").run.stop()
			end,
			desc = "Stop test run"
		},
	}
}
