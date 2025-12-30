local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.expandtab = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2
opt.clipboard = "unnamedplus" -- Sync to system clipboard
opt.scrolloff = 5 -- Keep 5 lines before the start or end of the buffer
opt.termguicolors = true -- True color support
opt.winborder = "rounded" -- Border around popup-windows
opt.wrap = false -- Let lines go off the screen

local keymap = vim.keymap.set

-- Better window switching!
keymap("n", "<C-l>", "<C-w><C-l>")
keymap("n", "<C-h>", "<C-w><C-h>")
keymap("n", "<C-j>", "<C-w><C-j>")
keymap("n", "<C-k>", "<C-w><C-k>")

vim.lsp.enable({
  "lua_ls",
  "clangd",
  "rust_analyzer",
  "zls",
  "ts_ls", -- ts pmo :sob
  "pyright",
  "gopls",
  "ocamllsp",
})

-- Set colorscheme
vim.pack.add {'https://github.com/rebelot/kanagawa.nvim'}
vim.cmd("colorscheme kanagawa")

-- Add default LSP configurations (maybe write my own later)
vim.pack.add {'https://github.com/neovim/nvim-lspconfig'}

-- Nicer icons
vim.pack.add {'https://github.com/echasnovski/mini.icons'}
require("mini.icons").setup {}

-- Filesystem editing plugin
vim.pack.add {'https://github.com/stevearc/oil.nvim'}

require("oil").setup {
  keymaps = {
    ["<C-h>"] = false, -- Disable for window switching
    ["<C-l>"] = false, -- Ditto
  },
  view_options = {
    show_hidden = true -- Show files begining with '.'
  }
}

keymap("n", "-", "<cmd>Oil<CR>") -- Vim vinegar keybind

-- Treesitter
vim.pack.add {'https://github.com/nvim-treesitter/nvim-treesitter'}

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

-- Autopair charaters ie (){}[]
vim.pack.add {'https://github.com/echasnovski/mini.pairs'}
require("mini.pairs").setup {}

-- Comment toggling
vim.pack.add {'https://github.com/echasnovski/mini.comment'}
require("mini.comment").setup {}

-- Fuzzy finder
vim.pack.add {'https://github.com/ibhagwan/fzf-lua'}
require("fzf-lua").setup {}
keymap("n", "<leader>ff", "<cmd>FzfLua files<CR>")

-- Autocomplete
vim.pack.add({
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("^1") -- bundle prebuilt binary
  },
})

require("blink.cmp").setup {
  keymap = { preset = "super-tab" },
  signature = { enabled = true },
}
