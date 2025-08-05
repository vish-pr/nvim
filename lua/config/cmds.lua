local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("VimEnter", {
    group = augroup("autoupdate"),
    callback = function()
        if require("lazy.status").has_updates then
            require("lazy").update({ show = false, })
        end
    end,
})

vim.api.nvim_create_autocmd({"TermOpen"}, {
  group = augroup("term"),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,

})


-- Function to rerun last command in terminal buffer
function _G.rerun_last_terminal_command()
  -- Find the terminal buffer
  local terminal_bufs = vim.tbl_filter(function(buf)
        return vim.bo[buf].buftype == 'terminal'
    end, vim.api.nvim_list_bufs())
    
  if #terminal_bufs == 0 then
      vim.notify("No terminal buffers found", vim.log.levels.WARN)
      return
  end
  local recent_term = terminal_bufs[#terminal_bufs]
  vim.api.nvim_chan_send(vim.b[recent_term].terminal_job_id, "!!\r\n")
end
vim.api.nvim_create_user_command('RerunLastCommand', rerun_last_terminal_command, {})
vim.keymap.set('n', '<leader>tr', rerun_last_terminal_command, { desc = 'Rerun last terminal command' })
-- Function to send Ctrl+C to most recent terminal
vim.api.nvim_create_user_command('TerminalCtrlC', function()
    local terminal_bufs = vim.tbl_filter(function(buf)
        return vim.bo[buf].buftype == 'terminal'
    end, vim.api.nvim_list_bufs())
    
    if #terminal_bufs == 0 then
        vim.notify("No terminal buffers found", vim.log.levels.WARN)
        return
    end
    
    local recent_term = terminal_bufs[#terminal_bufs]
    vim.api.nvim_chan_send(vim.b[recent_term].terminal_job_id, "\x03")
end, {})

-- Optional: Add a keybinding
vim.keymap.set('n', '<leader>tc', ':TerminalCtrlC<CR>', { desc = 'Send Ctrl+C to terminal' })
