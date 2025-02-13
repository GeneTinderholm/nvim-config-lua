vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.background = 'dark'
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.modeline = false
vim.o.wrap = false
vim.o.clipboard = 'unnamedplus'

vim.env.fzf_preview_args = '--preview bat --style=numbers --color=always --line-range :500 {}'

vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

local function nmap(key, binding, opts)
    opts = opts or { noremap = true, silent = true }
    vim.api.nvim_set_keymap('n', key, binding, opts)
end
require('plugins')
require('lsp')
require('complete')
require('onedark').load()

vim.g.mapleader = ' '
nmap('<Leader>w', '<C-w>')
nmap('<Leader><CR>', ':noh<CR>')
nmap('<Leader>t', ':terminal<cr>')
nmap('<Leader>f', ':Files<CR>')
nmap('<Leader>b', ':Buffers<CR>')
nmap('<Leader><Space>', ':Commands<CR>')

vim.api.nvim_create_autocmd({ "TermOpen" }, { command = "setlocal nonumber norelativenumber" })

vim.cmd([[
function! QuickGrep(searchString)
  cgetexpr system("grep -irn '" . a:searchString . "'")
  copen
endfunction
]])

vim.api.nvim_create_user_command(
    'QuickGrep',
    'call QuickGrep("<args>")',
    {
        nargs = '+',
        bang = true, -- redefines function when you resource file without an error
        desc = 'QuickGrep',
    }
)
