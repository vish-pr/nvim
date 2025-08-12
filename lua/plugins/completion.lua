return {
  {
    "zbirenbaum/copilot.lua",
    -- lazy = true,
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
      },
    },
  },
  {
    "saghen/blink.cmp",
    dependencies = { "fang2hou/blink-copilot" },
    version = "*",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
      keymap = { preset = "super-tab" },
      completion = { documentation = { auto_show = true } },
      sources = {
        default = { "copilot", "lsp", "path", "snippets", "buffer", "omni" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  }
}
