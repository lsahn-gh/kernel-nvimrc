-- plugins
require("lazy").setup({
    -- Monokai
    { "ku1ik/vim-monokai",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("monokai")
        end
    },

    -- Bufexplorer
    { "jlanzarotta/bufexplorer",
        config = function() end
    },

    -- Git-Messenger
    { "rhysd/git-messenger.vim",
        keys = {
            { "<leader>gm", "<Plug>(git-messenger)", mode = "n", silent = true, desc = "Git messenger" }
        },
        init = function()
            vim.g.git_messenger_always_into_popup = true
        end,
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "gitmessengerpopup",
                callback = function()
                    -- work on popup buffer
                    vim.keymap.set("n", "<C-o>", "o", { buffer = true, silent = true })
                    vim.keymap.set("n", "<C-i>", "O", { buffer = true, silent = true })
                end,
            })
        end,
    },

    -- Outline (as TagList)
    { "hedyhli/outline.nvim",
        cmd = "Outline",
        keys = {
            { "<leader>mm", ":Outline<CR>", mode="n", silent=true, desc="Symbols outline" }
        },
        config = function()
            require("outline").setup({})
        end
    },

    -- nvim-tree (as NERDTree)
    { "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<leader>nn", ":NvimTreeToggle<CR>", mode="n", silent=true, desc="Tree" },
            { "<leader>nf", ":NvimTreeFindFile<CR>", mode="n", silent=true, desc="Tree find" },
        },
        config = function()
            require("nvim-tree").setup({})
        end
    },

    -- GitSigns (as Signify)
    { "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("gitsigns").setup()
        end
    },

    -- cscope_map (with fzf-lua picker)
    { "dhananjaylatkar/cscope_maps.nvim",
        dependencies = { "ibhagwan/fzf-lua" },
        config = function()
            require("cscope_maps").setup({
                skip_input_prompt = true,
                cscope = {
                    picker = "fzf-lua",
                    qf_window_size = 3,
                    skip_picker_for_single_result = true
                },
            })
        end
    },

    -- fzf-lua
    { "ibhagwan/fzf-lua",
        cmd = "FzfLua",
        keys = {
            { "<leader>fzf", ":FzfLua<CR>", mode = "n", silent = true, desc = "Open FzfLua dialog" },
            { "<leader>fdg", ":FzfLua grep_cword<CR>", mode = "n", silent = true, desc = "Grep current word" },
            { "<leader>fdf", ":FzfLua files<CR>", mode = "n", silent = true, desc = "Open files dialog" }
        },
        config = function()
            require("fzf-lua").setup({})
        end,
    },

    -- Easy Align
    { "junegunn/vim-easy-align",
        config = function()
        end,
    },

    -- LSP
    { "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = { "rust", "cpp", "c" }
        },
    },
    { "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "clangd",
                "rust_analyzer"
            },
        },
        dependencies = {
            { "mason-org/mason.nvim", config = true },
            { "neovim/nvim-lspconfig" },
        },
    },
})
