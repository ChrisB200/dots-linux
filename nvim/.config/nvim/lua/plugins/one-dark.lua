return {
  "olimorris/onedarkpro.nvim",
  priority = 1000, -- Ensure it loads first
  config = function()
    require("onedarkpro").setup({
      colors = {
        purple = "#7FB4CA"
      }
    })
    vim.cmd("colorscheme onedark_vivid")
  end
}
