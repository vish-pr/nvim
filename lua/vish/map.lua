vim.g.mapleader = " "


vim.keymap.set("n", "-", vim.cmd.Ex)

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])


vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])



vim.keymap.set("n", "<leader>w", ":w<CR>")

vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>")

vim.keymap.set("n", "<leader>ls", function() require("persistence").load({ last = true }) end)

