return {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
  },

  config = function ()
    require("mason").setup()
    -- vim.lsp.enable('pyright')
    vim.lsp.enable({ 'lua_ls', 'ts_ls', 'pyright', 'html' })




    local virt_lines_ns = vim.api.nvim_create_namespace 'on_diagnostic_jump'

    --- @param diagnostic? vim.Diagnostic
    --- @param bufnr integer
    local function on_jump(diagnostic, bufnr)
        if not diagnostic then return end

        vim.diagnostic.show(
            virt_lines_ns,
            bufnr,
            { diagnostic },
            { virtual_lines = { current_line = true }, virtual_text = false }
        )
    end


    vim.diagnostic.config({

     jump = { on_jump = on_jump },
    -- virtual_lines = true,
    -- virtual_text = true,
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
