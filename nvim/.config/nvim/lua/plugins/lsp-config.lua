local ensure_installed = {
  "lua_ls",
  "bashls",
  "pylsp",
  "cmake",
  "cssls",
  "dockerls",
  "emmet_language_server",
  "html",
  "clangd",
  "ts_ls",
  "tailwindcss",
}

return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "ray-x/lsp_signature.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, silent = true, noremap = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end

      local installed = require("mason-lspconfig").get_installed_servers()

      for _, server in ipairs(installed) do
        local opts = {
          on_attach = on_attach,
          capabilities = capabilities,
        }

        -- Custom config for specific servers
        if server == "lua_ls" then
          opts.settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          }
        end

        lspconfig[server].setup(opts)
      end
    end,
  },
}

