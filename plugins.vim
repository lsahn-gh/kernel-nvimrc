call plug#begin('~/.vim/plugged')
Plug 'ku1ik/vim-monokai'
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'rhysd/git-messenger.vim'
Plug 'mhinz/vim-signify'
Plug 'jlanzarotta/bufexplorer'
Plug 'vim-scripts/taglist.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'embear/vim-localvimrc'
Plug 'dhananjaylatkar/cscope_maps.nvim'
Plug 'ibhagwan/fzf-lua'
Plug 'mrcjkb/rustaceanvim'
call plug#end()

" NERDTree
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <silent><leader>nn :NERDTreeToggle<cr>
map <silent><leader>nb :NERDTreeFromBookmark<Space>
map <silent><leader>nf :NERDTreeFind<cr>

" bufExplorer
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <silent><leader>o :BufExplorer<cr>

" TagList
map <silent><leader>mm :TlistToggle<CR>

" Git-Messenger
function! s:setup_git_messenger_popup() abort
    " Your favorite configuration here

    " For example, set go back/forward history to <C-o>/<C-i>
    nmap <buffer><C-o> o
    nmap <buffer><C-i> O
endfunction
autocmd FileType gitmessengerpopup call <SID>setup_git_messenger_popup()
let g:git_messenger_always_into_popup = v:true
nmap <silent><Leader>gm <Plug>(git-messenger)


" lua plugins, modify carefully
lua << EOF
-- fzf-lua
require("fzf-lua")

-- cscope_maps
local defaults = {
    skip_input_prompt = true,
    cscope = {
        picker = "fzf-lua",
        qf_window_size = 3,
        skip_picker_for_single_result = true,
    }}
require("cscope_maps").setup(defaults)

-- rustaceanvim
vim.g.rustaceanvim = {
    -- Plugin cfg
    tools = {
    },
    -- LSP cfg
    server = {
        on_attach = function(client, bufnr)
            -- put keymaps in here
        end,
        default_settings = {
            -- rust-analyzer lsp cfg
            ['rust-analyzer'] = {
                cargo = {
                    allFeatures = true,
                },
            },
        },
    },
    -- DAP cfg
    dap = {
    },
}
EOF

