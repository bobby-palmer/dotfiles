vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.wo.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true

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

local toggle_diagnostics = function ()
  local is_on = false
  return function ()
    is_on = not is_on
    vim.diagnostic.config({ virtual_lines = is_on })
  end
end

keymap("n", "<leader>d", toggle_diagnostics())

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
      config = cmd("colorscheme tokyonight-night")
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
