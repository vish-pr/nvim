return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
  },

  config = function()
    require("mason").setup()
    vim.lsp.enable({ 'lua_ls', 'ts_ls', 'tsgo', 'pyright', 'html', 'copilot' })
    vim.lsp.inline_completion.enable()


    -- LSP keybindings
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp_keybindings', { clear = true }),
      callback = function(event)
        local opts = { buffer = event.buf }
        
        -- Navigation
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        
        -- Documentation
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
        
        -- Actions
        vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
        vim.keymap.set({'n', 'v'}, '<leader>a', vim.lsp.buf.code_action, opts)
        
        -- Diagnostics
        vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, opts)
        vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, opts)
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, opts)
        
        -- Workspace
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
      end,
    })

    --   vim.api.nvim_create_autocmd('LspAttach', {
    --   group = vim.api.nvim_create_augroup('my.lsp', {}),
    --   callback = function(args)
    --     local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    --     if client:supports_method('textDocument/implementation') then
    --       -- Create a keymap for vim.lsp.buf.implementation ...
    --     end
    --     -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    --     if client:supports_method('textDocument/completion') then
    --       -- Optional: trigger autocompletion on EVERY keypress. May be slow!
    --       -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
    --       -- client.server_capabilities.completionProvider.triggerCharacters = chars
    --       vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
    --     end
    --     -- Auto-format ("lint") on save.
    --     -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    --     if not client:supports_method('textDocument/willSaveWaitUntil')
    --         and client:supports_method('textDocument/formatting') then
    --       vim.api.nvim_create_autocmd('BufWritePre', {
    --         group = vim.api.nvim_create_augroup('my.lsp', {clear=false}),
    --         buffer = args.buf,
    --         callback = function()
    --           vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
    --         end,
    --       })
    --     end
    --   end,
    -- })




    local virt_lines_ns = vim.api.nvim_create_namespace 'on_diagnostic_jump'

    --- @param diagnostic? vim.Diagnostic
    --- @param bufnr integer
    local function on_jump(diagnostic, bufnr)
      if not diagnostic then return end

      -- Clear previous virtual text in this namespace
      vim.api.nvim_buf_clear_namespace(bufnr, virt_lines_ns, 0, -1)

      -- Show diagnostic with virtual text on current line
      vim.diagnostic.show(
        virt_lines_ns,
        bufnr,
        { diagnostic },
        {
          virtual_text = {
            spacing = 4,
            prefix = '■ ',
            format = function(diag)
              return diag.message
            end
          }
        }
      )
    end


    vim.diagnostic.config({

      jump = { on_jump = on_jump },
      virtual_lines = false,
      virtual_text = true,
      underline = true,
      -- update_in_insert = false,
      severity_sort = true,
      float = {
        border = "rounded",
        source = true,
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅚 ",
          [vim.diagnostic.severity.WARN] = "󰀪 ",
          [vim.diagnostic.severity.INFO] = "󰋽 ",
          [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
          [vim.diagnostic.severity.ERROR] = "ErrorMsg",
          [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
      },
    })
  end
}
