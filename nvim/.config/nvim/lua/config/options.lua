vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.wo.relativenumber = true
vim.wo.number = true

-- Auto-wrap text at 100 columns, with a guide bar just past the limit.
vim.opt.textwidth = 100
vim.opt.colorcolumn = "101"

vim.api.nvim_set_hl(0, "SolarizedLightCurrentGroup", {
	fg = "#586E75", -- Solarized Base01 (dark cyan)
	bg = "#FDF6E3", -- Solarized Base3 (light background)
	bold = true
})
