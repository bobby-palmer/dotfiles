-- TODO add diagnostics/work on fzf and autocmp (get rid of ghost text probably and make cmp pop up less often)

-- keymaps
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")

-- options
vim.opt.number = true
vim.wo.relativenumber = true
vim.opt.signcolumn = 'yes'

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.termguicolors = true

-- lsp: add languages here
vim.lsp.config('luals', {
  cmd = {'lua-language-server'},
  filetypes = {'lua'},
  root_markers = {'.luarc.json', '.luarc.jsonc'},
})

vim.lsp.config('clangd', {
  cmd = { 'clangd', '--background-index' },
  root_markers = { 'compile_commands.json', 'compile_flags.txt' },
  filetypes = { 'c', 'cpp' },
})

vim.lsp.enable({'luals', 'clangd'})

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
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
        vim.cmd([[colorscheme tokyonight]])
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
        {'-', "<CMD>Oil<CR>"},
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
          preset = 'default',
          ['<Tab>'] = {'select_and_accept', 'fallback'}
        },
        appearance = { nerd_font_variant = 'mono' },
        completion = {
          menu = { auto_show = false },
          documentation = { auto_show = false },
          ghost_text = {
            enabled = true,
            show_with_menu = false,
          }
        },
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },
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
    }
  },

  install = { colorscheme = { "habamax" } },
})
