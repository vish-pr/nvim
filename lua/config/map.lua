vim.g.mapleader = " "
vim.g.maplocalleader = ' '

vim.keymap.set("n", "-", "<cmd>Explore<CR>")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("n", "<leader>w", ":w<CR>")

local function close_diff()
  local cur = vim.api.nvim_get_current_win()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if win ~= cur and vim.wo[win].diff then
      vim.api.nvim_win_close(win, true)
    end
  end
  vim.cmd("diffoff")
end

local function qf_navigate(cmd)
  local was_diff = vim.wo.diff
  if was_diff then close_diff() end
  vim.cmd(cmd)
  if was_diff then
    vim.defer_fn(function() require("gitsigns").diffthis() end, 100)
  end
end
vim.keymap.set("n", "<leader>k", function() qf_navigate("cprev") end)
vim.keymap.set("n", "<leader>j", function() qf_navigate("cnext") end)
vim.keymap.set("n", "<leader>h", ":colder<CR>")
vim.keymap.set("n", "<leader>l", ":cnewer<CR>")

-- vim.keymap.set("n", "<leader>q", ":bp | bd #<CR>")
-- vim.keymap.set("n", "<leader>b", ":ls<CR>:b<space>")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", '<Down>', '<cmd>resize -1<cr>')
vim.keymap.set("n", '<Left>', '<cmd>vertical resize +1<cr>')
vim.keymap.set("n", '<Right>', '<cmd>vertical resize -1<cr>')
vim.keymap.set("n", '<Up>', '<cmd>resize +1<cr>')
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>")
vim.keymap.set("t", "ii", "<C-\\><C-n>")
vim.keymap.set("i", "ii", "<esc>")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "<leader>d", function()
  if vim.wo.diff then close_diff() else require("gitsigns").diffthis() end
end, { desc = "Toggle diff" })
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>c", function()
  local filepath = vim.fn.expand("%:.")
  vim.fn.setreg("+", filepath)
  print("Copied: " .. filepath)
end, { desc = "Copy relative filepath" })

-- Context-aware cheatsheet: netrw or LSP
vim.keymap.set("n", "<leader>?", function()
  local cs = require('config.cheatsheet')
  if vim.bo.filetype == 'netrw' then
    cs.show(cs.netrw, ' Netrw Help ')
  elseif #vim.lsp.get_clients({ bufnr = 0 }) > 0 then
    cs.show(cs.lsp, ' LSP Help ')
  else
    vim.notify('No cheatsheet for this context', vim.log.levels.INFO)
  end
end)
