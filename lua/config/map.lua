vim.g.mapleader = " "
vim.g.maplocalleader = ' '

vim.keymap.set("n", "-", vim.cmd.Ex)
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("n", "<leader>w", ":w<CR>")

vim.keymap.set("n", "<leader>k", ":cprev<CR>")
vim.keymap.set("n", "<leader>j", ":cnext<CR>")
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
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
