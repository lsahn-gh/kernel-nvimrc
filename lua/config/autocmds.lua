-- Trim trailing whitespaces
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = "keeppatterns %s/\\s\\+$//e",
})

