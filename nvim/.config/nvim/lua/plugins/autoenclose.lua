return {
  {
    "windwp/nvim-autopairs",
    opts = { check_ts = true },
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}

