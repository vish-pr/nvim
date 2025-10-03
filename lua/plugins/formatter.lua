return {
	"stevearc/conform.nvim",
	dependencies = { "mason.nvim", "lewis6991/gitsigns.nvim" },
	lazy = true,
	opts = {
		formatters_by_ft = {
			python = { "isort", "black" },
			typescript = { "prettier", stop_after_first = true },
			javascript = { "prettier", stop_after_first = true },
			lua = { "stylua" },
		},
	},
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>f",
			function()
				local mode = vim.api.nvim_get_mode().mode
				if vim.startswith(string.lower(mode), "v") then
					require("conform").format({ async = true }, function(err)
						if not err then
							-- Leave visual mode after range format
							vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
						end
					end)
				else
					require("conform").format({ async = true })
				end
			end,
			mode = "",
			desc = "Format code",
		},
	},
}
