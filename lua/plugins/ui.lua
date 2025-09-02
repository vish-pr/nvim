return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme kanagawa-dragon]])
		end,
	},
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				icons_enabled = false,
				-- theme = "codedark",
				theme = "catppuccin",
				globalstatus = true,
			},
			sections = {
				lualine_y = {
					{
						"datetime",
						-- options: default, us, uk, iso, or your own format string ("%H:%M", etc..)
						style = "default",
					},
				},
				lualine_z = { "progress", "location" },
			},
		},
	},
}