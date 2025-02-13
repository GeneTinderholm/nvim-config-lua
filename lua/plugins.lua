local plugins = {
  'navarasu/onedark.nvim',
  'neovim/nvim-lspconfig',
  'tpope/vim-fugitive',
  'tpope/vim-vinegar',
  'wbthomason/packer.nvim',
}

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.api.nvim_create_user_command(
    'PlugUpdate',
    function(input)
        require('packer').update()
    end,
    {bang = true, desc = 'Update Plugins'}
)

return require('packer').startup(function(use)
    for _, plugin in ipairs(plugins) do
        use(plugin)
    end

    if packer_bootstrap then
        require('packer').sync()
    end
end)

