return {
  {
    "lewis6991/gitsigns.nvim"
  },
  {
  "tpope/vim-fugitive",
  config = function()
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
  end
  }
}