vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap.set

keymap("n", "<C-l>", "<C-w><C-l>")
keymap("n", "<C-h>", "<C-w><C-h>")
keymap("n", "<C-j>", "<C-w><C-j>")
keymap("n", "<C-k>", "<C-w><C-k>")
keymap("n", "j", "gj")
keymap("n", "k", "gk")

vim.opt.number = true
vim.wo.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true

vim.lsp.enable({
  'lua_ls',
  'clangd',
  'rust_analyzer',
  'zls',
  'ts_ls',
  'pyright',
  'gopls'
})

vim.diagnostic.config({ virtual_text = true }) -- TODO

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none",
    "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      config = function()
        vim.cmd([[colorscheme tokyonight-night]])
      end
    },
    {
      'stevearc/oil.nvim',
      ---@module 'oil'
      ---@type oil.SetupOpts
      opts = {
        keymaps = {
          ["<C-l>"] = false,
          ["<C-h>"] = false,
        }
      },
      keys = {
        {'-', function ()
          vim.cmd [[Oil]]
        end}
      },
      dependencies = { { "echasnovski/mini.icons", opts = {} } },
      lazy = false,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function ()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
          ensure_installed = {"c", "cpp"},
          sync_install = false,
          highlight = {enable = true},
          indent = {enable = true},
        })
      end
    },
    { 'echasnovski/mini.nvim', version = false },
    { 'neovim/nvim-lspconfig' },
  },

  install = { colorscheme = { "habamax" } },
})

require('mini.pairs').setup()
require('mini.completion').setup()
require('mini.pick').setup()
