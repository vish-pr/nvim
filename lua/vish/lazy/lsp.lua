return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "zbirenbaum/copilot-cmp",
  },
  config = function()
    require("copilot_cmp").setup()
    local cmp = require('cmp')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

  local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set('n', 'gi', function()  vim.lsp.buf.implementation() end, opts)
        vim.keymap.set('n', 'gr', function()  vim.lsp.buf.references() end, opts)
        vim.keymap.set('i', '<C-h>', function()  vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set('n', '<leader>D', function()  vim.lsp.buf.type_definition() end, opts)
        vim.keymap.set('n', '<leader>rn', function()  vim.lsp.buf.rename() end, opts)
        vim.keymap.set('n', '<leader>a', function()  vim.lsp.buf.code_action() end, opts)
        vim.keymap.set('n', '<leader>e', function()  vim.lsp.diagnostic.show_line_diagnostics() end, opts)
        vim.keymap.set('n', '[e', function()  vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set('n', ']e', function()  vim.diagnostic.goto_next() end, opts)
        vim.keymap.set('n', '<leader>e', function()  vim.diagnostic.set_loclist() end, opts)
  end

--    lspconfig.pyright.setup{}
 --   lspconfig.lua_ls.setup {}
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { 'pyright' , 'lua_ls' },
      handlers = {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
          }
        end,

        zls = function()
          local lspconfig = require("lspconfig")
          lspconfig.zls.setup({
            root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
            settings = {
              zls = {
                enable_inlay_hints = true,
                enable_snippets = true,
                warn_style = true,
              },
            },
          })
          vim.g.zig_fmt_parse_errors = 0
          vim.g.zig_fmt_autosave = 0
        end,
        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup {
            capabilities = capabilities,
           on_attach = on_attach,
            settings = {
              Lua = {
                runtime = { version = "Lua 5.1" },
                diagnostics = {
                  globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                }
              }
            }
          }
        end,
      }
    })

    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ["<C-Space>"] = cmp.mapping.complete(),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.snippet.jumpable(1) then
            vim.snippet.jump(1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.jumpable(-1) then
            vim.snippet.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ['<CR>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if vim.snippet.active() then
              vim.snippet.expand()
            else
              cmp.confirm({
                select = true,
              })
            end
          else
            fallback()
          end
        end),
        -- And something similar for vim.snippet.jump(-1)
      }),
      sources = cmp.config.sources({
        { name = 'copilot' },
        { name = 'nvim_lsp' },
      }, {
        { name = 'buffer' },
      })
    })
    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      }),
      matching = { disallow_symbol_nonprefix_matching = false }
    })

    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })
  end
}
