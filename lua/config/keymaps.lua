-- basic
local map = vim.keymap.set
local tc = function(s) return vim.api.nvim_replace_termcodes(s, true, false, true) end

-- general
map("n", "<leader>w",   "<cmd>w!<CR>", { silent = true, desc = "Force save" })
map("n", "<leader>qa",  "<cmd>qa<CR>", { silent = true, desc = "Quit all" })
map("n", "<leader>xa",  "<cmd>xa<CR>", { silent = true, desc = "Save & quit all" })

map("n", "<leader>pp",  "<cmd>setlocal paste!<CR>", { silent = true, desc = "Toggle paste mode on / off" })

map("n", "<leader><cr>","<cmd>noh<CR>", { silent = true, desc = "Remove search hightlight" })

-- tab management
map("n", "<leader>ts",  "<cmd>tab split<CR>", { silent = true, desc = "Split tab" })
map("n", "<leader>tn",  "<cmd>tab new<CR>", { silent = true, desc = "New tab" })
map("n", "<leader>to",  "<cmd>tab only<CR>", { silent = true, desc = "Close all tabs except this" })
map("n", "<leader>tc",  "<cmd>tab close<CR>", { silent = true, desc = "Close current tab" })
map("n", "<leader>tml", "<cmd>-tabmove<CR>", { silent = true, desc = "Move tab one left" })
map("n", "<leader>tml", "<cmd>+tabmove<CR>", { silent = true, desc = "Move tab one right" })

-- terminal Emulating
map("n", "<leader>lt",  function()
                            vim.cmd("belowright split | resize 15 | terminal")
                        end, { silent = true, desc = "Terminal (bottom 15)" })
map("n", "<leader>gdb", function()
                            vim.cmd("belowright split | resize 15 | terminal gdb")
                        end, { silent = true, desc = "Terminal gdb" })
map("t", "<Esc><Esc>",  [[<C-\><C-n>:q<CR>]], { silent = true, desc = "Exit terminal & close" })
map("t", "<Esc>",       [[<C-\><C-n>]],       { silent = true, desc = "Exit terminal-mode" })

-- IAMROOT stamps
map("n", "<leader>1",   function()
                            local s = "a/* IAMROOT, " .. os.date("%Y.%m.%d") .. ":*/"
                            vim.api.nvim_feedkeys(tc(s .. "<Left><Esc>"), "n", false)
                        end, { silent = true, desc = "Insert IAMROOT inline stamp" })
map("n", "<leader>2",   function()
                            local s = "o/* IAMROOT, " .. os.date("%Y.%m.%d") .. ":"
                            vim.api.nvim_feedkeys(tc(s .. "<CR>/<Esc><Up><End>"), "n", false)
                        end, { silent = true, desc = "Insert IAMROOT block" })

