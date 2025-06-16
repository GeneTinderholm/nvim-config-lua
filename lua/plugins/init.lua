local plugins = {
    'hiphish/rainbow-delimiters.nvim',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/nvim-cmp',
    'mbbill/undotree',
    'navarasu/onedark.nvim',
    'neovim/nvim-lspconfig',
    'nvim-lualine/lualine.nvim',
    'tpope/vim-fugitive',
    'tpope/vim-rsi',
    'tpope/vim-surround',
    'tpope/vim-vinegar',
    'wbthomason/packer.nvim',

    {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    },
    { 'junegunn/fzf.vim', requires = { 'junegunn/fzf', run = ':call fzf#install()' } },
    { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }
}

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

vim.api.nvim_create_user_command(
    'PlugUpdate',
    function(_)
        require('packer').update()
    end,
    { bang = true, desc = 'Update Plugins' }
)

require('packer').startup(function(use)
    for _, plugin in ipairs(plugins) do
        use(plugin)
    end

    if packer_bootstrap then
        require('packer').sync()
    end
end)

require('lualine').setup {
    options = {
        theme = 'onedark'
    }
}
require('nvim-treesitter.configs').setup({
    ensure_installed = { "go", "lua", "zig" },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
})

require('onedark').load()
require('plugins.complete')
require('plugins.lsp')
require('plugins.dap')
