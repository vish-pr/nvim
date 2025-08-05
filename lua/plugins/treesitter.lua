return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      -- A list of parser names, or "all"
      ensure_installed = { "vimdoc", "javascript", "typescript", "c", "lua", "jsdoc", "bash", "python", },
      auto_install = true,
      indent = {
        enable = true
      },
      highlight = {
        enable = true,
      },
    })
  end
}
