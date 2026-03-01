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
            ensure_installed = { "rust", "cpp" }
        },
    },
    { "p00f/clangd_extensions.nvim",
        config = function()
        end,
        lazy = true,
        opts = {
            inlay_hints = {
                inline = false,
            },
        },
    },
    { "neovim/nvim-lspconfig",
        config = function()
        end,
        opts = {
            servers = {
                bacon_ls = {
                    enabled = diagnostics == "bacon-ls",
                },
                rust_analyzer = { enabled = false },
            },
        }
    },
    { "mrcjkb/rustaceanvim",
        ft = { "rust" },
        opts = {
            server = {
                on_attach = function(_, bufnr)
                    vim.keymap.set("n", "<leader>cR", function()
                        vim.cmd.RustLsp("codeAction")
                    end, { desc = "Code Action", buffer = bufnr })
                    vim.keymap.set("n", "<leader>dr", function()
                        vim.cmd.RustLsp("debuggables")
                    end, { desc = "Rust Debuggables", buffer = bufnr })
                end,
                default_settings = {
                    -- rust-analyzer language server configuration
                    ["rust-analyzer"] = {
                        cargo = {
                            allFeatures = true,
                            loadOutDirsFromCheck = true,
                            buildScripts = {
                                enable = true,
                            },
                        },
                        -- Add clippy lints for Rust if using rust-analyzer
                        checkOnSave = diagnostics == "rust-analyzer",
                        -- Enable diagnostics if using rust-analyzer
                        diagnostics = {
                            enable = diagnostics == "rust-analyzer",
                        },
                        procMacro = {
                            enable = true,
                        },
                        files = {
                            exclude = {
                                ".direnv",
                                ".git",
                                ".jj",
                                ".github",
                                ".gitlab",
                                "bin",
                                "node_modules",
                                "target",
                                "venv",
                                ".venv",
                            },
                            watcher = "client",
                        },
                    },
                },
            },
        },
        config = function(_, opts)
            vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
            if vim.fn.executable("rust-analyzer") == 0 then
                LazyVim.error(
                    "**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
                    { title = "rustaceanvim" }
                )
            end
        end,
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
