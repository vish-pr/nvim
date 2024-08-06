return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup {
      options = {
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        icons_enabled = false,
        theme = 'gruvbox',
        globalstatus = true,
      },
    }
  end
}
