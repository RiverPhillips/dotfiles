return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		'saghen/blink.cmp'
	},
	config = function()
		require("mason").setup()
		local masonlsp = require("mason-lspconfig")


		masonlsp.setup({
			ensure_installed = {
				"lua_ls",
				"gopls",
				"tflint",
				"yamlls",
				"golangci_lint_ls",
				"bashls",
				"terraformls"
			},
		})
	end
}
