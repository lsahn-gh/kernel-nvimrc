local o = vim.opt

-- basic
o.termguicolors     = true
o.number            = true
o.relativenumber    = false
o.completeopt       = "menu,menuone,noselect"

-- from legacy VIM
o.expandtab     = true          -- set et
o.smarttab      = true
o.shiftwidth    = 4             -- set shiftwidth=4
o.tabstop       = 4
o.number        = true          -- set nu

o.colorcolumn   = "80"          -- set colorcolumn=80
o.cursorline    = true          -- set cursorline

o.history       = 500           -- max history line
o.ruler         = true          -- show current position
o.cmdheight     = 1             -- height of the cmd bar

o.hid           = true
o.ignorecase    = true
o.smartcase     = true
o.hlsearch      = true
o.incsearch     = true
o.lazyredraw    = true
o.magic         = true
o.showmatch     = true
o.mat           = 2

o.errorbells    = false          -- off error bells
o.visualbell    = false
o.foldcolumn    = "1"

o.syntax        = "on"
o.background    = "dark"
o.encoding      = "utf8"
o.ffs           = "unix,dos,mac"

o.backup        = false         -- file, backup, and undo
o.wb            = false
o.swapfile      = false

o.lbr           = true          -- linebreak on 500 chs
o.tw            = 500

o.ai            = true          -- auto indent
o.si            = true          -- smart indent
o.wrap          = true          -- wrap lines

o.list          = true
o.listchars = {
    tab = "┊ ",
    trail = "●",
    extends = "…",
    precedes = "…",
}

do
    local local_rc = ".vimrc_local"
    if vim.fn.filereadable(local_rc) == 1 then
        vim.cmd("silent source " .. local_rc)
    end
end

