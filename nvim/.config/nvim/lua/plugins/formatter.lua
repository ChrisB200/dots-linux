local ensure_installed = {
  "stylua",
  "black",
  "prettier",
  "eslint_d",
  "flake8",
  "shellcheck",
  "codespell",
  "gitsigns",
}

return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "jayp0521/mason-null-ls.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      local mason_null_ls = require("mason-null-ls")

      mason_null_ls.setup({
        ensure_installed = ensure_installed,
      })

      local sources = {}

      -- Define the null-ls builtin categories we want
      local builtin_categories = {
        null_ls.builtins.formatting,
        null_ls.builtins.diagnostics,
        null_ls.builtins.code_actions,
      }

      -- Build a lookup for each category
      local function build_lookup(category)
        local lookup = {}
        for _, builtin in pairs(category) do
          lookup[builtin.name] = builtin
        end
        return lookup
      end

      -- Add installed sources per category
      for _, category in ipairs(builtin_categories) do
        local installed = mason_null_ls.get_installed_sources({ category = category })
        local lookup = build_lookup(category)

        for _, name in ipairs(installed) do
          local builtin = lookup[name]
          if builtin then
            table.insert(sources, builtin)
          end
        end
      end

      -- Setup null-ls with all collected sources
      null_ls.setup({
        sources = sources,
        on_attach = function(client, bufnr)
          vim.keymap.set("n", "<leader>ff", function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end, { buffer = bufnr, desc = "Format buffer" })
        end,
      })
    end,
  },
}
