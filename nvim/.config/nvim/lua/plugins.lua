return {
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>f",
				function()
					require("conform").format({ async = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		-- This will provide type hinting with LuaLS
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			-- Set default options
			default_format_opts = {
				lsp_format = "fallback",
			},
			-- Set up format-on-save
			format_on_save = { timeout_ms = 500 },
			-- Customize formatters
			formatters = {
				shfmt = {
					prepend_args = { "-i", "2" },
				},
			},
		},
		init = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},

	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end
	},

	{
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
	},

	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = {
			"rafamadriz/friendly-snippets",
		},


		-- use a release tag to download pre-built binaries
		version = "*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = "cargo build --release",
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = "nix run .#build-plugin",

		---@module "blink.cmp"
		---@type blink.cmp.Config
		opts = {
			-- "default" for mappings similar to built-in completion
			-- "super-tab" for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- "enter" for mappings similar to "super-tab" but with "enter" to accept
			-- See the full "keymap" documentation for information on defining your own keymap.
			keymap = { preset = "super-tab" },

			appearance = {
				-- Sets the fallback highlight groups to nvim-cmp"s highlight groups
				-- Useful for when your theme doesn"t support blink.cmp
				-- Will be removed in a future release
				use_nvim_cmp_as_default = true,
				-- Set to "mono" for "Nerd Font Mono" or "normal" for "Nerd Font"
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono"
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				providers = {}
			},
		},
		opts_extend = { "sources.default" }
	},

	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
				"nvim-dap-ui",
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings

	{
		'mrcjkb/rustaceanvim',
		version = '^5', -- Recommended
		lazy = false, -- This plugin is already lazy
	},

	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"lewis6991/async.nvim",
		},
		config = function()
			require("refactoring").setup({})

			vim.keymap.set("x", "<leader>re", ":Refactor extract")
			vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file")

			vim.keymap.set("x", "<leader>rv", ":Refactor, extract_var")
			vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")

			vim.keymap.set("n", "<leader>rI", ":Refactor inline_func")

			vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
			vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")
		end,
	},

	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",

		},
		config = function()
			local builtin = require('telescope.builtin')
			-- Show dotfiles but exclude .git. fd and rg spell this differently.
			local function find_command()
				if vim.fn.executable('fd') == 1 then
					return { 'fd', '--type', 'f', '--hidden', '--exclude', '.git' }
				else
					return { 'rg', '--files', '--hidden', '--glob', '!.git' }
				end
			end
			vim.keymap.set('n', '<leader>ff', function()
				builtin.find_files({ find_command = find_command() })
			end, { desc = 'Telescope find files' })
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
			vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

			require('telescope').load_extension('fzf')
		end
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
	},
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make'
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		-- install the latest stable version
		version = "*",
		config = function()
			require("telescope").load_extension "frecency"
		end,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false,     -- neo-tree will lazily load itself
		opts = {
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = true,
				}
			}
		}
	},

	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
				}
			})
		end
	},

	{
		'nvim-tree/nvim-web-devicons',
	},

	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},

	{
		"tpope/vim-fugitive",
		cmd = {
			"G",
			"Git",
			"Gdiffsplit",
			"Gvdiffsplit",
			"Gedit",
			"Gsplit",
			"Gread",
			"Gwrite",
			"Ggrep",
			"GMove",
			"GDelete",
			"GBrowse",
		},
		keys = {
			{ "<leader>gs", "<cmd>Git<cr>",        desc = "Git status" },
			{ "<leader>gb", "<cmd>Git blame<cr>",  desc = "Git blame" },
			{ "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
			{ "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff" },
			{ "<leader>gl", "<cmd>Git log<cr>",    desc = "Git log" },
			{ "<leader>gp", "<cmd>Git push<cr>",   desc = "Git push" },
			{ "<leader>gP", "<cmd>Git pull<cr>",   desc = "Git pull" },
		},
		dependencies = {
			"tpope/vim-rhubarb", -- GitHub integration
		},
	},

	{
		"m4xshen/hardtime.nvim",
		lazy = false,
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {},
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require('harpoon')
			harpoon:setup({})


			vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)

			vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
			vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
			vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
			vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
			vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

			-- basic telescope configuration
			local conf = require("telescope.config").values
			local function toggle_telescope(harpoon_files)
				local file_paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(file_paths, item.value)
				end

				require("telescope.pickers").new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				}):find()
			end
			vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
				{ desc = "Open harpoon window" })
		end
	},

	{
		"romus204/tree-sitter-manager.nvim",
		dependencies = {}, -- tree-sitter CLI must be installed system-wide
		config = function()
			require("tree-sitter-manager").setup()
		end,
	},

	{
		'joerdav/templ.vim'
	},

	{
		"someone-stole-my-name/yaml-companion.nvim",
		requires = {
			{ "neovim/nvim-lspconfig" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
		},
		config = function()
			require("telescope").load_extension("yaml_schema")
		end,
	},
}
