local M = {}

function M.show(lines, title)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = 'wipe'
  local width = 40
  local height = #lines
  vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    col = (vim.o.columns - width) / 2,
    row = (vim.o.lines - height) / 2,
    style = 'minimal',
    border = 'rounded',
    title = title or ' Help ',
    title_pos = 'center',
  })
  for _, key in ipairs({ 'q', '<Esc>', '<CR>' }) do
    vim.keymap.set('n', key, '<cmd>close<cr>', { buffer = buf, nowait = true })
  end
end

M.lsp = {
  ' LSP Keybindings',
  '',
  ' Navigation',
  '  gd        Go to definition',
  '  gD        Go to declaration',
  '  gr        Find references',
  '  gi        Go to implementation',
  '  <leader>D Type definition',
  '',
  ' Documentation',
  '  K         Hover docs',
  '  <C-k>     Signature help (insert)',
  '',
  ' Actions',
  '  <leader>r Rename symbol',
  '  <leader>a Code action',
  '  <leader>f Format code',
  '',
  ' Diagnostics',
  '  [d / ]d   Prev / next diagnostic',
  '  <leader>e Open diagnostic float',
  '  <leader>q Diagnostics to quickfix',
  '',
  ' Workspace',
  '  <leader>wa  Add folder',
  '  <leader>wr  Remove folder',
  '  <leader>wl  List folders',
}

M.netrw = {
  ' Netrw Keybindings',
  '',
  ' Navigation',
  '  <CR>      Open file/directory',
  '  -         Go up a directory',
  '  u         Go back in history',
  '  U         Go forward in history',
  '',
  ' File Operations',
  '  %         Create new file',
  '  d         Create new directory',
  '  D         Delete file/directory',
  '  R         Rename file',
  '',
  ' Display',
  '  i         Cycle listing style',
  '  s         Cycle sort method',
  '  r         Reverse sort order',
  '  gh        Toggle hidden files',
  '',
  ' Marks & Actions',
  '  mf        Mark file',
  '  mu        Unmark all',
  '  mt        Set mark target',
  '  mc        Copy marked files',
  '  mm        Move marked files',
}

return M
