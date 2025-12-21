local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

local opt = vim.opt

opt.clipboard = "unnamedplus"
opt.expandtab = true
opt.number = true
opt.relativenumber = true
opt.scrolloff = 5
opt.shiftwidth = 2
opt.signcolumn = "yes"
opt.softtabstop = 2
opt.tabstop = 2
opt.termguicolors = true
opt.winborder = "rounded"

local keymap = vim.keymap.set

keymap("n", "<C-l>", "<C-w><C-l>")
keymap("n", "<C-h>", "<C-w><C-h>")
keymap("n", "<C-j>", "<C-w><C-j>")
keymap("n", "<C-k>", "<C-w><C-k>")

keymap("n", "-", "<cmd>Oil<CR>")

keymap("n", "<leader>ff", "<cmd>FzfLua files<CR>")

vim.lsp.enable({
  "lua_ls",
  "clangd",
  "rust_analyzer",
  "zls",
  "ts_ls",
  "pyright",
  "gopls",
  "ocamllsp",
})

vim.pack.add({
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/echasnovski/mini.icons",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/neovim/nvim-lspconfig",
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("^1") -- bundle prebuilt binary
  },
  "https://github.com/echasnovski/mini.pairs",
  "https://github.com/echasnovski/mini.comment",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/nvim-lualine/lualine.nvim",
})

vim.cmd("colorscheme tokyonight-night")

require("mini.icons").setup {}

require("oil").setup {
  keymaps = {
    ["<C-h>"] = false,
    ["<C-l>"] = false,
  }
}

require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "c",
    "cpp",
    "markdown",
    "markdown_inline",
    "ocaml"
  },
  sync_install = false,
  highlight = {enable = true},
  indent = {enable = true},
}

require("blink.cmp").setup {
  keymap = { preset = "super-tab" },
  signature = { enabled = true },
}

require("mini.pairs").setup {}

require("mini.comment").setup {}

require("fzf-lua").setup {}

require("lualine").setup {}
