local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

local status, packer = pcall(require, "packer")
if not status then
    return
end

return require("packer").startup(function(use)
    -- Plugin Manager
    use("wbthomason/packer.nvim") -- package manager

    -- Utilities
    use("lewis6991/impatient.nvim") -- speed up loading time
    use("rcarriga/nvim-notify") -- notifications
    use("akinsho/toggleterm.nvim") -- terminal in a floating window
    use("rmagatti/auto-session") -- auto save session
    use("windwp/nvim-autopairs") -- auto pairs
    use({ -- show trouble diagnostics
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
    })
    use("lukas-reineke/indent-blankline.nvim") -- indent lines

    -- File Explorer
    use("nvim-tree/nvim-tree.lua")

    -- Status Line
    use("nvim-lualine/lualine.nvim") -- status line (bottom bar)
    use("akinsho/bufferline.nvim") -- buffer line (top bar)

    --  Auto Completion
    -- use("github/copilot.vim") -- github copilot

    use({
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({})
        end,
    })
    use({
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end,
    })

    use("numToStr/Comment.nvim") -- returns types or etc smart comments

    -- LSP Installer
    use("williamboman/mason.nvim") -- lsp server package manager
    use("williamboman/mason-lspconfig.nvim") -- bridge between lspconfig and mason

    -- With Rust Programming
    use("simrat39/rust-tools.nvim") -- rust syntax highlighting, requires "rust-analyzer"
    use({ -- managing rust crates dependencies
        "saecki/crates.nvim",
        tag = "v0.3.0",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("crates").setup()
        end,
    })

    -- LSP
    use("neovim/nvim-lspconfig") -- easily configure language servers
    use("glepnir/lspsaga.nvim") -- lsp ui
    use("ray-x/lsp_signature.nvim") -- show function signature while typing

    -- Lua
    use("nvim-lua/plenary.nvim")

    -- Telescope
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder
    use({
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
            require("telescope").load_extension("frecency")
        end,
        requires = { "kkharji/sqlite.lua" },
    })

    use({
        "rebelot/kanagawa.nvim",
        config = function()
            vim.cmd([[colorscheme kanagawa-dragon]])
        end,
    })
    use("hiphish/rainbow-delimiters.nvim") -- rainbow parentheses

    -- Autocompletion

    -- Installation
    use("L3MON4D3/LuaSnip")
    use("hrsh7th/nvim-cmp")
    use("saadparwaiz1/cmp_luasnip")
    use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-buffer")

    use("nathanaelkane/vim-indent-guides")

    -- Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
    })

    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    })
    use({
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    })

    -- Git
    use("NeogitOrg/neogit")
    use("lewis6991/gitsigns.nvim")

    -- deprecated
    use("jayp0521/mason-null-ls.nvim") -- birdge between null-ls and mason
    use("jose-elias-alvarez/null-ls.nvim")
    -- use("tpope/vim-surround") -- surroundings in pairs
    -- use("editorconfig/editorconfig-vim")

    if packer_bootstrap then
        require("packer").sync()
    end
end)
