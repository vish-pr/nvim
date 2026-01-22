# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a Neovim configuration built on the lazy.nvim plugin manager. The configuration follows a modular structure:

- `init.lua` - Entry point that loads core modules in order: maps, syntax, lazy, and commands
- `lua/config/` - Core configuration modules:
  - `lazy.lua` - Bootstrap and setup lazy.nvim plugin manager with leader keys set to space
  - `map.lua` - Global key mappings and leader key bindings
  - `syntax.lua` - Editor options, indentation, search, clipboard, and visual settings
  - `cmds.lua` - Custom commands and autocommands
- `lua/plugins/` - Plugin configurations as separate modules loaded by lazy.nvim

## Key Plugin Architecture

### LSP Configuration (lua/plugins/lsp.lua)
- Uses mason.nvim for LSP server management
- Enables lua_ls, tsgo, pyright, html, and copilot language servers via `vim.lsp.enable()`
- Custom diagnostic configuration with virtual text on jump and custom signs

### Completion System (lua/plugins/completion.lua)
- Uses blink.cmp as the completion engine with sidekick.nvim integration
- Sources: LSP, path, snippets, buffer, omni completion
- Uses "enter" keymap preset with Tab for snippet/sidekick navigation

### Formatting (lua/plugins/formatter.lua)
- conform.nvim handles code formatting with Mason integration
- Configured formatters: Python (isort + black), TypeScript/JS (prettier), Lua (stylua)

## Important Configuration Details

- Uses 2-space indentation universally
- No swap files, uses undodir at `~/.vim/undodir`
- Global clipboard integration enabled
- Scrolloff set to 50 (keeps cursor centered)
- Diagnostic signs use nerd font icons (󰅚 󰀪 󰋽 󰌶)
- Single global statusline (laststatus=3)

## Keyboard Shortcuts Reference

### File Navigation

| Key | Mode | Action |
|-----|------|--------|
| `-` | n | Open netrw file explorer |

### Window Management

| Key | Mode | Action |
|-----|------|--------|
| `<Down>` | n | Shrink window height |
| `<Up>` | n | Grow window height |
| `<Left>` | n | Grow window width |
| `<Right>` | n | Shrink window width |

### Clipboard & Registers

| Key | Mode | Action |
|-----|------|--------|
| `<leader>y` | n, v | Yank to system clipboard |
| `<leader>Y` | n | Yank line to system clipboard |
| `<leader>d` | n, v | Delete to void register |
| `<leader>p` | x | Paste without overwriting register |
| `<leader>c` | n | Copy relative filepath to clipboard |

### File Operations

| Key | Mode | Action |
|-----|------|--------|
| `<leader>w` | n | Save file |
| `<leader>s` | n | Search (prompt) |
| `<leader>s` | x | Search selection |
| `<leader>f` | n, v | Format code |

### Quickfix Navigation

| Key | Mode | Action |
|-----|------|--------|
| `<leader>j` | n | Next quickfix item |
| `<leader>k` | n | Previous quickfix item |
| `<leader>l` | n | Newer quickfix list |
| `<leader>h` | n | Older quickfix list |

### Terminal Integration

| Key | Mode | Action |
|-----|------|--------|
| `ii` | t, i | Exit terminal/insert mode |
| `<C-w>` | t | Window commands in terminal |
| `tr` | n | Rerun last terminal command |
| `tc` | n | Send Ctrl+C to terminal |
| `t1` / `t2` / `t3` | n | Send 1/2/3 to terminal |
| `tn` / `tp` | n | Next/prev terminal in CWD |
| `bn` / `bp` | n | Next/prev buffer in CWD |

### Harpoon (Quick Marks)

| Key | Mode | Action |
|-----|------|--------|
| `mm` | n | Add file to harpoon |
| `mu` | n | Toggle harpoon menu |
| `ma` | n | Jump to mark 1 |
| `ms` | n | Jump to mark 2 |
| `md` | n | Jump to mark 3 |
| `mf` | n | Jump to mark 4 |

### LSP

| Key | Mode | Action |
|-----|------|--------|
| `gd` | n | Go to definition |
| `gD` | n | Go to declaration |
| `gr` | n | Find references |
| `gi` | n | Go to implementation |
| `K` | n | Hover documentation |
| `<C-k>` | i | Signature help |
| `<leader>D` | n | Type definition |
| `<leader>r` | n | Rename symbol |
| `<leader>a` | n, v | Code action |
| `<leader>e` | n | Open diagnostic float |
| `<leader>q` | n | Diagnostics to quickfix |
| `[d` / `]d` | n | Prev/next diagnostic |
| `<leader>wa` | n | Add workspace folder |
| `<leader>wr` | n | Remove workspace folder |
| `<leader>wl` | n | List workspace folders |

### Git (gitsigns)

| Key | Mode | Action |
|-----|------|--------|
| `]c` / `[c` | n | Next/prev hunk |
| `<leader>hp` | n | Preview hunk |
| `<leader>hi` | n | Preview hunk inline |
| `<leader>hb` | n | Blame line (full) |
| `<leader>hd` | n | Diff this buffer |
| `<leader>hD` | n | Diff against parent |
| `<leader>hq` | n | Hunk to quickfix |
| `<leader>hQ` | n | All hunks to quickfix |
| `<leader>tb` | n | Toggle line blame |
| `<leader>tw` | n | Toggle word diff |
| `ih` | o, x | Select hunk (text object) |

### AI/Sidekick (Claude)

| Key | Mode | Action |
|-----|------|--------|
| `<Tab>` | n | Jump to/apply next edit suggestion |
| `<C-.>` | n, x, i, t | Toggle sidekick focus |
| `<leader>aa` | n, v | Toggle Claude CLI |
| `<leader>ac` | n | Toggle Claude (alt) |
| `<leader>as` | n | Select CLI tool |
| `<leader>at` | n, x | Send current context to Claude |
| `<leader>af` | n | Send file to Claude |
| `<leader>av` | x | Send visual selection to Claude |
| `<leader>ap` | n, x | Open prompt selector |

### Treewalker (AST Navigation)

| Key | Mode | Action |
|-----|------|--------|
| `<C-j>` | n | Navigate down in syntax tree |
| `<C-k>` | n | Navigate up in syntax tree |
| `<C-h>` | n | Navigate left in syntax tree |
| `<C-l>` | n | Navigate right in syntax tree |

## Development Commands

No specific build, test, or lint commands are configured for this Neovim setup. This is a personal editor configuration, not a software project requiring compilation or testing.

Plugin management uses lazy.nvim:
- Plugins auto-install on first run
- Use `:Lazy` to manage plugins (install, update, clean)
- Lock file at `lazy-lock.json` pins plugin versions