local api, fn = vim.api, vim.fn
local augroup = function(name) return api.nvim_create_augroup("lazyvim_" .. name, { clear = true }) end
local get_buffers = function(filter) return vim.tbl_filter(filter, api.nvim_list_bufs()) end
local cycle = function(list, cur, rev)
  if #list == 0 then return end
  local idx = vim.tbl_contains(list, cur) and vim.fn.index(list, cur) + 1 or 1
  return list[((idx + (rev and -2 or 0)) % #list) + 1]
end

-- Auto-update lazy plugins
api.nvim_create_autocmd("VimEnter", {
  group = augroup("autoupdate"),
  callback = function() if require("lazy.status").has_updates then require("lazy").update({ show = false }) end end,
})

-- Terminal state and setup
local terminal_state = { last_by_tab = {} }
local term_group = augroup("term")

api.nvim_create_autocmd("TermOpen", { group = term_group, callback = function()
  vim.opt_local.number, vim.opt_local.relativenumber = false, false
end })

api.nvim_create_autocmd({ "TermEnter", "BufEnter" }, { group = term_group, pattern = "term://*", callback = function()
  local tab, buf = api.nvim_get_current_tabpage(), api.nvim_get_current_buf()
  terminal_state.last_by_tab[tab] = buf
  vim.defer_fn(function() api.nvim_win_set_cursor(0, {api.nvim_buf_line_count(buf), 0}) end, 1)
end })

-- Terminal functions
local get_active_terminal = function()
  local tab = api.nvim_get_current_tabpage()
  local last = terminal_state.last_by_tab[tab]
  if last and api.nvim_buf_is_valid(last) and vim.bo[last].buftype == 'terminal' then return last end
  for _, win in ipairs(api.nvim_tabpage_list_wins(tab)) do
    local buf = api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == 'terminal' then terminal_state.last_by_tab[tab] = buf; return buf end
  end
end

local send_to_terminal = function(cmd)
  local buf = get_active_terminal()
  if not buf then vim.notify("No terminal in tab", vim.log.levels.WARN); return end
  local job = vim.b[buf].terminal_job_id
  if job then api.nvim_chan_send(job, cmd) else vim.notify("No terminal job", vim.log.levels.ERROR) end
end

local get_cwd_terminals = function()
  local cwd, tilde = fn.getcwd(), fn.getcwd():gsub("^" .. fn.expand("~"), "~")
  return get_buffers(function(b) 
    return api.nvim_buf_is_loaded(b) and vim.bo[b].buftype == "terminal" and 
           (api.nvim_buf_get_name(b):find(cwd, 1, true) or api.nvim_buf_get_name(b):find(tilde, 1, true))
  end)
end

local cycle_terminals = function(rev)
  local terms = get_cwd_terminals()
  if #terms == 0 then vim.notify("No terminals for CWD", vim.log.levels.WARN); return end
  local next_term = cycle(terms, api.nvim_get_current_buf(), rev)
  if next_term then api.nvim_set_current_buf(next_term) end
end

local cycle_buffers = function(rev)
  local cwd, tilde = fn.getcwd(), fn.getcwd():gsub("^" .. fn.expand("~"), "~")
  local bufs = get_buffers(function(b) 
    return api.nvim_buf_is_loaded(b) and vim.bo[b].buflisted and vim.bo[b].buftype == "" and
           (api.nvim_buf_get_name(b):find(cwd, 1, true) or api.nvim_buf_get_name(b):find(tilde, 1, true))
  end)
  if #bufs == 0 then vim.notify("No regular buffers", vim.log.levels.WARN); return end
  local next_buf = cycle(bufs, api.nvim_get_current_buf(), rev)
  if next_buf then api.nvim_set_current_buf(next_buf) end
end

-- Commands and keymaps
api.nvim_create_user_command('RerunLastCommand', function() send_to_terminal("!!\r\n") end, {})
api.nvim_create_user_command('TerminalCtrlC', function() send_to_terminal("\x03") end, {})

-- Search functions
local function grep_and_open(pattern)
  if not pattern or pattern == "" then return end
  vim.cmd("silent grep! " .. fn.shellescape(pattern))
  vim.cmd("copen")
end

local function get_visual_selection()
  local _, ls, cs = unpack(fn.getpos("'<"))
  local _, le, ce = unpack(fn.getpos("'>"))
  local lines = api.nvim_buf_get_text(0, ls - 1, cs - 1, le - 1, ce, {})
  return table.concat(lines, "\n")
end

local map = vim.keymap.set
map('n', 'tr', function() send_to_terminal("!!\r\n") end, { desc = 'Rerun terminal cmd' })
map('n', 'tc', function() send_to_terminal("\x03") end, { desc = 'Send Ctrl+C' })
map('n', 't1', function() send_to_terminal("1") end, { desc = 'Send 1 to terminal' })
map('n', 't2', function() send_to_terminal("2") end, { desc = 'Send 2 to terminal' })
map('n', 't3', function() send_to_terminal("3") end, { desc = 'Send 3 to terminal' })
map('n', 'tn', function() cycle_terminals(false) end, { desc = 'Next terminal' })
map('n', 'tp', function() cycle_terminals(true) end, { desc = 'Prev terminal' })
map('n', 'bn', function() cycle_buffers(false) end, { desc = 'Next buffer' })
map('n', 'bp', function() cycle_buffers(true) end, { desc = 'Prev buffer' })
map('x', '<leader>s', function() grep_and_open(get_visual_selection()) end, { desc = 'Search selection' })
map('n', '<leader>s', function() vim.ui.input({ prompt = "Search: " }, grep_and_open) end, { desc = 'Search prompt' })

-- Git changed files in quickfix
map('n', '<leader>g', function()
  local lines = vim.fn.systemlist('git status --porcelain')
  if vim.v.shell_error ~= 0 or #lines == 0 then
    vim.notify("No uncommitted changes", vim.log.levels.INFO)
    return
  end
  local items = {}
  for _, line in ipairs(lines) do
    local status = line:sub(1, 2):gsub(" ", "")
    local file = line:sub(4)
    -- Handle renames: "R  old -> new"
    file = file:match("-> (.+)") or file
    table.insert(items, { filename = file, lnum = 1, text = "[" .. status .. "]" })
  end
  vim.fn.setqflist(items)
  vim.cmd("copen")
end, { desc = 'Git changed files' })
