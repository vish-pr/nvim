vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 100
vim.opt.sessionoptions = "buffers,curdir,localoptions,folds,tabpages,winpos,winsize,terminal"
vim.opt.signcolumn = "yes"


vim.g.python_recommended_style = 0  -- so ftplugin/python does not set tabs and spaces
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true


vim.opt.laststatus = 3
vim.opt.showmode = false  -- do not show mode again in comand line, it is in lualine

vim.opt.virtualedit = "block"  -- ctr+v mode for right side movement with uneven endings of different lines


-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.schedule(function()
vim.opt.clipboard = 'unnamedplus'
--end)

-- Minimal number of screen lines to keep above and below the cursor.


vim.g.have_nerd_font = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true


-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.inccommand = "split"

vim.opt.termguicolors = true

-- Terminal scrollback history
vim.opt.scrollback = 100000

