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
vim.o.wrap = true
vim.o.clipboard = 'unnamedplus'

vim.env.fzf_preview_args = '--preview bat --style=numbers --color=always --line-range :500 {}'

vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

local utils = require('utils')
vim.o.undodir = utils.ensure_data_dir(".undo")
vim.o.undofile = true
vim.o.backupdir = utils.ensure_data_dir(".backup")
vim.o.directory = utils.ensure_data_dir(".swp")

vim.g.mapleader = ' '
utils.nmap('<Leader>w', '<C-w>')
utils.nmap('<Leader><CR>', ':noh<CR>')
utils.nmap('<Leader>u', ':UndotreeToggle<CR>')
utils.nmap('<Leader>t', ':terminal<cr>')
utils.nmap('<Leader>f', ':Files<CR>')
utils.nmap('<Leader>b', ':Buffers<CR>')
utils.nmap('<Leader><Space>', ':Commands<CR>')

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
require('plugins')
