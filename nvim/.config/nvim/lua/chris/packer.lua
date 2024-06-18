local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Discord rich presence
    use 'andweeb/presence.nvim'

    -- Command Auto complete
    use 'gelguy/wilder.nvim'

    -- terminal
    use "akinsho/toggleterm.nvim"

    -- context aware hovers
    use "lewis6991/hover.nvim"

    use 'sheerun/vim-polyglot'

    use 'windwp/nvim-autopairs'

    -- The breadcrumbs
    use({
        "utilyre/barbecue.nvim",
        tag = "*",
        requires = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        after = "nvim-web-devicons", -- keep this if you're using NvChad
        config = function()
            require("barbecue").setup()
        end,
    })

    -- Status bar at the bottom
    use({
        "NTBBloodbath/galaxyline.nvim",
        -- your statusline
        config = function()
            require("galaxyline.themes.eviline")
        end,
        -- some optional icons
        requires = { "kyazdani42/nvim-web-devicons", opt = true }
    })

    -- Telescope plugin
    use {
        'nvim-lua/plenary.nvim',
        'nvim-lua/popup.nvim',
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        'nvim-telescope/telescope-media-files.nvim',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Colour Scheme
    use { "catppuccin/nvim", as = "catppuccin" }
    vim.cmd("colorscheme catppuccin")

    -- These optional plugins should be loaded directly because of a bug in Packer lazy loading
    use 'lewis6991/gitsigns.nvim' -- OPTIONAL: for git status
    
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')

    -- Installation
    use { 'L3MON4D3/LuaSnip' }
    use {
        'hrsh7th/nvim-cmp',
        config = function ()
            require'cmp'.setup {
                snippet = {
                    expand = function(args)
                        require'luasnip'.lsp_expand(args.body)
                    end
                },

                sources = {
                    { name = 'luasnip' },
                    -- more sources
                },
            }
        end
    }
    use "rafamadriz/friendly-snippets"
    use { 'saadparwaiz1/cmp_luasnip' }
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    }

    use {
  "ray-x/lsp_signature.nvim",
}
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment the two plugins below if you want to manage the language servers from neovim
            -- {'williamboman/mason.nvim'},
            -- {'williamboman/mason-lspconfig.nvim'},

            -- LSP Support
            {'neovim/nvim-lspconfig'},
            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
        }
    }
end)
