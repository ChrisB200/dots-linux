return {
  {
    "jayp0521/mason-null-ls.nvim",
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {
          "eslint_d",
          "flake8",
          "black",
          "prettier",
          "shellcheck",
          "codespell",
          "clang-format",
          "pgformatter"
        },
        automatic_installation = true,
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {},
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- Formatters
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.eslint_d,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.pgformatter,

          -- Diagnostics
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.diagnostics.flake8,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.diagnostics.cppcheck,
          null_ls.builtins.diagnostics.codespell,
          null_ls.builtins.formatting.pgformatter,
        },
        -- OPTIONAL: debounce to avoid too many triggers
        debounce = 150,
      })

      -- Format on save autocmd
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
        callback = function()
          -- Use the built-in LSP formatting method
          vim.lsp.buf.format({ async = false })
        end,
      })

      -- Map format key outside of null_ls.setup table
      vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, {})
    end,
  },
}
