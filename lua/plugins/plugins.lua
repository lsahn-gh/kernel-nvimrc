-- plugins
require("lazy").setup({
    -- Monokai
    { "ku1ik/vim-monokai",
        lazy = false, priority = 1000,
        config = function()
            vim.cmd.colorscheme("monokai")
        end
    },

    -- Bufexplorer
    { "jlanzarotta/bufexplorer",
        config = function()
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
            { "<leader>fzf", ":FzfLua<CR>", mode = "n", silent = true, desc = "Open FzfLua dialog" }
        },
        config = function()
            require("fzf-lua").setup({})
        end,
    },

    -- Rust LSP
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

    -- CPP LSP
    { "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = { "cpp" }
        },
    },
    { "p00f/clangd_extensions.nvim",
        lazy = true,
        config = function() end,
        opts = {
            inlay_hints = {
                inline = false,
            },
        },
    },
    { "neovim/nvim-lspconfig",
        config = function() end,
        opts = {
            servers = {
                -- Ensure mason installs the server
                clangd = {
                    keys = {
                        { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
                    },
                    root_dir = function(fname)
                        return require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(fname)
                    end,
                    capabilities = {
                        offsetEncoding = { "utf-16" },
                    },
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--completion-style=detailed",
                        "--function-arg-placeholders",
                        "--fallback-style=llvm",
                    },
                    init_options = {
                        usePlaceholders = true,
                        completeUnimported = true,
                        clangdFileStatus = true,
                    },
                },
            },
            setup = {
                clangd = function(_, opts)
                    local clangd_ext_opts = LazyVim.opts("clangd_extensions.nvim")
                    require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
                    return false
                end,
            },
        },
    },
    { "hrsh7th/nvim-cmp",
        optional = true,
        opts = function(_, opts)
            opts.sorting = opts.sorting or {}
            opts.sorting.comparators = opts.sorting.comparators or {}
            table.insert(opts.sorting.comparators, 1, require("clangd_extensions.cmp_scores"))
        end,
    }
})
