

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemn/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {"lua_ls"}
})

local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup({})
lspconfig.gdscript.setup({
	on_attach = on_attach
})

vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

-- Configure diagnostic signs
local signs = { Error = "✗ ", Warn = " ", Hint = "i ", Info = " " }
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

