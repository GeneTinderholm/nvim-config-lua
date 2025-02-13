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

vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

function nmap(key, binding, opts)
    opts = opts or { noremap = true, silent = true }
    vim.api.nvim_set_keymap('n', key, binding, opts)
end
require('plugins')
require('onedark').load()

vim.g.mapleader = ' '
nmap('<Leader>w', '<C-w>')

vim.api.nvim_create_user_command(
    'Test',
    function(input)
        print(input.fargs)
        for i, arg in ipairs(input.fargs) do
            print(i, arg)
        end
    end,
    {
        nargs = '*',
        bang = true, -- redefines function when you resource file without an error
        desc = 'Example so I remember how to use this',
    }
)
