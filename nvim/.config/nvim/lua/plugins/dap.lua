return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap, dapui = require('dap'), require('dapui')
		dapui.setup()
		dap.adapters.delve = {
			type = 'server',
			port = '${port}',
			executable = {
				command = 'dlv',
				args = { 'dap', '-l', '127.0.0.1:${port}' },
			}
		}

		dap.configurations.rust = {
			name = 'Launch',
			type = 'lldb',
			request = 'launch',
			program = function()
				return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
			end,
			cwd = '${workspaceFolder}',
			stopOnEntry = false,
			args = {},
			-- ... the previous config goes here ...,
			initCommands = function()
				-- Find out where to look for the pretty printer Python module
				local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))

				local script_import = 'command script import "' ..
				    rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
				local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

				local commands = {}
				local file = io.open(commands_file, 'r')
				if file then
					for line in file:lines() do
						table.insert(commands, line)
					end
					file:close()
				end
				table.insert(commands, 1, script_import)

				return commands
			end,
			-- ...,
		}

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		vim.keymap.set("x", "<leader>db", ":lua require('dap').toggle_breakpoint()<CR>")
		vim.keymap.set("n", "<leader>db", ":lua require('dap').toggle_breakpoint()<CR>")

		vim.keymap.set("n", "<leader>dc", ":lua require('dap').continue()<CR>")
		vim.keymap.set("n", "<leader>do", ":lua require('dap').step_over()<CR>")
		vim.keymap.set("n", "<leader>di", ":lua require('dap').step_into()<CR>")
	end
}
