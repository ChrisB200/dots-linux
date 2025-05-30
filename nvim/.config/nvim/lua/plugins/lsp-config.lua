local ensure_installed = {
  "lua_ls",
  "bashls",
  "pylsp",
  "cmake",
  "cssls",
  "dockerls",
  "emmet_language_server",
  "html",
  "ts_ls",
  "clangd",
  "tailwindcss",
}

return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed
      })
    end
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

      local on_attach = function(client, buffer)
        local opts = { noremap = true, silent = true }
        vim.api.nvim_buf_set_keymap(buffer, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
        vim.api.nvim_buf_set_keymap(buffer, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
        vim.api.nvim_buf_set_keymap(buffer, "n", "<leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
        vim.api.nvim_buf_set_keymap(buffer, "n", "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
      end
      
      local function setup_servers()
        local installed = require("mason-lspconfig").get_installed_servers()
        for _, server in ipairs(installed) do
          lspconfig[server].setup({
            on_attach = on_attach,
            capabilities = capabilities
          })
        end
      end

      setup_servers()
    end
  }
}