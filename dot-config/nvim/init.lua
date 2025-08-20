-- keymaps
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap.set

keymap("n", "<C-l>", "<C-w><C-l>")
keymap("n", "<C-h>", "<C-w><C-h>")
keymap("n", "<C-j>", "<C-w><C-j>")
keymap("n", "<C-k>", "<C-w><C-k>")

keymap("n", "j", "gj")
keymap("n", "k", "gk")

-- options
vim.opt.number = true
vim.wo.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true

-- lsp
vim.lsp.enable({
  'lua_ls',
  'clangd',
  'rust_analyzer',
  'zls',
  'ts_ls',
  'pyright',
  'gopls'
})

vim.diagnostic.config({ virtual_text = true }) -- TODO: make nicer

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

-- setup plugins
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
      "ibhagwan/fzf-lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      keys = function ()
        local fzf = require("fzf-lua")
        return {
          {'<leader>ff', fzf.files},
          {'<leader>fs', fzf.lsp_document_symbols},
          {'<leader>ft', fzf.treesitter},
        }
      end,
    },
    {
      'stevearc/oil.nvim',
      ---@module 'oil'
      ---@type oil.SetupOpts
      opts = {},
      dependencies = { { "echasnovski/mini.icons", opts = {} } },
      lazy = false,
      keys = {
        {'-', "<CMD>OilCR>"},
      },
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
    {
      'saghen/blink.cmp',
      version = '1.*',
      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
        keymap = {
          preset = 'super-tab',
        },
        appearance = { nerd_font_variant = 'mono' },
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        completion = {
          list = {
            selection = { preselect = false }
          }
        },
        fuzzy = { implementation = "prefer_rust_with_warning" }
      },
      opts_extend = { "sources.default" }
    },
    {
      'saghen/blink.pairs',
      version = '*',
      dependencies = 'saghen/blink.download',
      --- @module 'blink.pairs'
      --- @type blink.pairs.Config
      opts = {
        mappings = {
          enabled = true,
          pairs = {},
        },
        highlights = {
          enabled = true,
          groups = {
            'BlinkPairsOrange',
            'BlinkPairsPurple',
            'BlinkPairsBlue',
          },
          matchparen = {
            enabled = true,
            group = 'MatchParen',
          },
        },
        debug = false,
      }
    },
    -- for default configs
    { 'neovim/nvim-lspconfig' }
  },

  install = { colorscheme = { "habamax" } },
})
