-- leader
vim.g.mapleader = ",";

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim", lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- import configs
require("config.options")
require("config.keymaps")
pcall(require, "config.autocmds")
require("plugins.plugins")

