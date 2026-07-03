vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.wo.relativenumber = true
vim.wo.number = true

vim.api.nvim_set_hl(0, "SolarizedLightCurrentGroup", {
	fg = "#586E75", -- Solarized Base01 (dark cyan)
	bg = "#FDF6E3", -- Solarized Base3 (light background)
	bold = true
})
