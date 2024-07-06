require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls" },
})

local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require("luasnip/loaders/from_vscode").load()

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities
})
lspconfig.gdscript.setup({
	on_attach = on_attach,
	capabilities = capabilities
})
lspconfig.pylsp.setup({
	capabilities = capabilities
})

vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

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
