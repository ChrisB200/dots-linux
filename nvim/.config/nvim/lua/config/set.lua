-- Line numbers
vim.opt.nu = true;
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.g.mapleader = " "

-- Show file names in the statusline
vim.opt.laststatus = 2
vim.opt.statusline = '%F'

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

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "css", "html", "lua", "sql", "typescript", "typescriptreact", "javascriptreact" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})
