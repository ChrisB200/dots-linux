return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim', "nvim-telescope/telescope-media-files.nvim", "nvim-telescope/telescope-ui-select.nvim", "nvim-lua/popup.nvim"},
    config = function()
        local builtin = require("telescope.builtin")
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string( {search = vim.fn.input("Grep > ") });
        end)

        local telescope = require("telescope")
        telescope.load_extension("media_files")
        telescope.extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_dropdown{}
            },
        }

        telescope.load_extension("ui-select")
    end
}