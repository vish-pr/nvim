local no_config_plugins = {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",   -- this will only start session saving when an actual file was opened
    opts = {}
  },
}

return no_config_plugins
