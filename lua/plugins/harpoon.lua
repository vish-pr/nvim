return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    settings = {
      save_on_toggle = true,
    },
  },
  keys = {
    {"mm", function() require('harpoon'):list():add() end},
    {"mu", function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end},
    {"ma", function() require('harpoon'):list():select(1) end},
    {"ms", function() require('harpoon'):list():select(2) end},
    {"md", function() require('harpoon'):list():select(3) end},
    {"mf", function() require('harpoon'):list():select(4) end},
  },
}
