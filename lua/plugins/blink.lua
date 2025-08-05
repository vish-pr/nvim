return {
	"saghen/blink.cmp",
	dependencies = {
		"Kaiser-Yang/blink-cmp-avante",
		-- ... Other dependencies
	},
	version = "*",
	event = { "LspAttach" },
	opts = {
		keymap = { preset = "enter" },
		sources = {
			-- Add 'avante' to the list
			default = { "avante", "lsp", "path", "snippets", "buffer" },
			providers = {
				avante = {
					module = "blink-cmp-avante",
					name = "Avante",
					opts = {
						-- options for blink-cmp-avante
					},
				},
			},
		},
	},
}
