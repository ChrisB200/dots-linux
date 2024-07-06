require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls" },
})

local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require("luasnip/loaders/from_vscode").load()

local on_attach = function(client, bufnr)
    -- Example key bindings
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- Add more as needed
end

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities
})
lspconfig.gdscript.setup({
	on_attach = on_attach,
	capabilities = capabilities
})
lspconfig.clangd.setup({
	on_attach = on_attach,
	capabilities = capabilities
})
lspconfig.bashls.setup({
	on_attach = on_attach,
	capabilities = capabilities
})
lspconfig.ruby_lsp.setup({
	on_attach = on_attach,
	capabilities = capabilities
})
lspconfig.tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities
})

-- Configure diagnostic signs
local signs = { Error = "✗ ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Configure diagnostic display settings
vim.diagnostic.config({
	virtual_text = {
		prefix = "●", -- Could be '■', '▎', 'x'
	},
	signs = true,
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		source = "always", -- Or "if_many"
	},
})
