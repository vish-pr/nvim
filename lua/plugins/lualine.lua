return {
  'nvim-lualine/lualine.nvim',
  opts = {
    options = {
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      icons_enabled = false,
      theme = 'codedark',
      globalstatus = true,
    },
    sections = {
      lualine_y = {
        {
          'datetime',
          -- options: default, us, uk, iso, or your own format string ("%H:%M", etc..)
          style = 'default'
        },
      },
      lualine_z = { 'progress', 'location'},
    },
  },
}
