local g = vim.g

g.mapleader = ' '
g.maplocalleader = ' '

local opt = vim.opt

opt.expandtab = true
opt.number = true
opt.relativenumber = true
opt.scrolloff = 5
opt.shiftwidth = 2
opt.signcolumn = 'yes'
opt.softtabstop = 2
opt.tabstop = 2
opt.termguicolors = true

local keymap = vim.keymap.set

---@param command string vim command to execute
---@return function a function that will execute the input command when called
local cmd = function (command)
  return function ()
    vim.cmd(command)
  end
end

keymap("n", "<C-l>", "<C-w><C-l>")
keymap("n", "<C-h>", "<C-w><C-h>")
keymap("n", "<C-j>", "<C-w><C-j>")
keymap("n", "<C-k>", "<C-w><C-k>")

keymap("n", "j", "gj")
keymap("n", "k", "gk")

vim.lsp.enable({
  'lua_ls',
  'clangd',
  'rust_analyzer',
  'zls',
  'ts_ls',
  'pyright',
  'gopls',
  'tinymist',
  'ocamllsp',
})

vim.lsp.config["tinymist"] = {
    cmd = { "tinymist" },
    filetypes = { "typst" },
    settings = {},
}

-- Slowly shift plugins to here when this works (Oil is cooked)
vim.pack.add({
  { src = "https://github.com/folke/tokyonight.nvim" },
  { src = "https://github.com/echasnovski/mini.icons" },
  -- { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
})

vim.cmd "colorscheme tokyonight-night"

require 'mini.icons'.setup {}

-- require'nvim-treesitter.configs'.setup {}

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
      'stevearc/oil.nvim',
      ---@module 'oil'
      ---@type oil.SetupOpts
      opts = {
        keymaps = {
          ["<C-h>"] = false,
          ["<C-l>"] = false,
        },
      },
      keys = {{"-", cmd("Oil")}},
      dependencies = { { "echasnovski/mini.icons", opts = {} } },
      lazy = false,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function ()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
          ensure_installed = {
            "c",
            "cpp",
            "markdown",
            "markdown_inline"
          },
          sync_install = false,
          highlight = {enable = true},
          indent = {enable = true},
        })
      end
    },
    {
      'saghen/blink.cmp',
      dependencies = { 'rafamadriz/friendly-snippets' },
      version = '1.*',
      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
        keymap = { preset = 'super-tab' },
        signature = { enabled = true },
      },
    },
    {
      'chomosuke/typst-preview.nvim',
      lazy = false,
      version = '1.*',
      opts = {},
    },
    {
      "ibhagwan/fzf-lua",
      dependencies = { "echasnovski/mini.icons" },
      opts = {},
      keys = {
        {"<leader>ff", cmd("FzfLua files")},
        {"<leader>fg", cmd("FzfLua lgrep_curbuf")},
      },
      lazy = false,
    },
    { 'neovim/nvim-lspconfig' },
    { 'echasnovski/mini.pairs', version = false, opts = {} },
    { 'echasnovski/mini.comment', version = false, opts = {} },
  },
  install = { colorscheme = { "habamax" } },
})
