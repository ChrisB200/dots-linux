return {
  "theprimeagen/harpoon",
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    -- marks a file
    vim.keymap.set("n", "<leader>a", mark.add_file)

    -- shows all marked files
    vim.keymap.set("n", "<leader>s", ui.toggle_quick_menu)

    vim.keymap.set("n", "<leader>h", function()
      -- goes to marked file 1
      ui.nav_file(1)
    end)
    vim.keymap.set("n", "<leader>j", function()
      -- goes to marked file 2
      ui.nav_file(2)
    end)
    vim.keymap.set("n", "<leader>k", function()
      -- goes to marked file 3
      ui.nav_file(3)
    end)
    vim.keymap.set("n", "<leader>l", function()
      -- goes to marked file 4
      ui.nav_file(4)
    end)
  end,
}
