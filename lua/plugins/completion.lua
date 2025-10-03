return {
	{
		"folke/sidekick.nvim",
		opts = {
      mux = {
        backend = "tmux",
        enabled = true,
      },
    },
		keys = {
       {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
			{
				"<c-.>",
				function()
					require("sidekick.cli").focus()
				end,
				mode = { "n", "x", "i", "t" },
				desc = "Sidekick Switch Focus",
			},
			{
				"<leader>c",
				function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
				desc = "Sidekick Toggle claude cli",
				mode = { "n", "v" },
			},
		},
	},
	{
		"saghen/blink.cmp",
		dependencies = { "folke/sidekick.nvim" },
		version = "*",
		event = { "InsertEnter", "CmdlineEnter" },
		opts = {
			fuzzy = { implementation = "lua" },
			keymap = {
				preset = "enter",
				["<Tab>"] = {
					"snippet_forward",
					function() -- sidekick next edit suggestion
						return require("sidekick").nes_jump_or_apply()
					end,
					function() -- if you are using Neovim's native inline completions
						return vim.lsp.inline_completion.get()
					end,
					"fallback",
				},
			},
			completion = { documentation = { auto_show = true } },
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "omni" },
			},
		},
	},
}
