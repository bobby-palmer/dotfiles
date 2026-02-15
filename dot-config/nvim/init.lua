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

-- Autoformat golang files
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format { async = false }
  end,
})

-- Enable treesitter highlights (golang)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function ()
    vim.treesitter.start()
  end
})

vim.pack.add({
  'https://github.com/rebelot/kanagawa.nvim',
  'https://github.com/folke/snacks.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/echasnovski/mini.icons',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/echasnovski/mini.pairs',
  'https://github.com/echasnovski/mini.comment',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("^1"), -- Bundle prebuilt
  },
})

vim.cmd("colorscheme kanagawa")

require("snacks").setup {
  picker = {}
}

keymap("n", "<leader>ff", function () Snacks.picker.files() end)

require("mini.icons").setup {}

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

require('nvim-treesitter').setup {}

require('nvim-treesitter').install {
  "c",
  "cpp",
  "python",
  "lua",
  "markdown",
  "markdown_inline",
  "ocaml",
  "go"
}

require("mini.pairs").setup {}

require("mini.comment").setup {}

require("blink.cmp").setup {
  keymap = { preset = "super-tab" },
  signature = { enabled = true },
}
