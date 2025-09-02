-- plugins
require("lazy").setup({
    -- Monokai
    { "ku1ik/vim-monokai",
        lazy = false, priority = 1000,
        config = function()
            vim.cmd.colorscheme("monokai")
        end
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

    -- LSP
    { "neovim/nvim-lspconfig", event = "BufReadPre" },

    -- cscope_map (with fzf-lua picker)
    { "dhananjaylatkar/cscope_maps.nvim",
        ft = { "c", "cpp" },
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
        config = function() require("fzf-lua").setup({}) end,
    },

    -- Rustaceanvim
    { "mrcjkb/rustaceanvim",
        ft = "rust",
        init = function()
            vim.g.rustaceanvim = {
                tools = {},
                server = {
                    on_attach = function(_, _) end,
                    default_settings = {
                        ["rust-analyzer"] = {
                            cargo = { allFeatures = true }
                        }
                    },
                },
                dap = {},
            }
        end,
    },
})
