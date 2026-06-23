-- Options
do
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  local opt = vim.opt
  opt.number = true
  opt.relativenumber = true
  opt.ignorecase = true
  opt.smartcase = true
  opt.wrap = false
  opt.tabstop = 2
  opt.shiftwidth = 2
  opt.softtabstop = 2
  opt.expandtab = true
  opt.smartindent = true
  opt.autoindent = true
  opt.signcolumn = "yes"
  opt.termguicolors = true
  opt.clipboard = "unnamedplus"
  opt.winborder = "rounded"
  opt.swapfile = false
end

---@param repo string
---@return string
local function gh(repo) return 'https://github.com/' .. repo end

-- Theme
do
  vim.pack.add { gh 'folke/tokyonight.nvim' }
  vim.cmd.colorscheme 'tokyonight-night'
end

-- Mini
do
  vim.pack.add { gh 'nvim-mini/mini.nvim' }

  require('mini.icons').setup()
  MiniIcons.mock_nvim_web_devicons()

  require('mini.pairs').setup()

  require('mini.surround').setup()

  require('mini.extra').setup()

  require('mini.comment').setup()
end

-- Picker
do
  local centered_window = function ()
    local height = math.floor(vim.o.lines * 0.60)
    local width = math.floor(vim.o.columns * 0.60)
    return {
      anchor = 'NW',
      row = math.floor((vim.o.lines - height) / 2),
      col = math.floor((vim.o.columns - width) / 2),
      width = width,
      height = height,
      border = 'rounded', -- 'single', 'double', 'shadow', etc.
    }
  end

  require('mini.pick').setup {
    window = {
      config = centered_window
    }
  }

  vim.keymap.set('n', '<leader>ff', ':Pick files<CR>')
end

-- LSP
do
  vim.pack.add { gh 'neovim/nvim-lspconfig' }
  vim.lsp.enable {
    'lua_ls',
    'ocamllsp',
  }
end

-- Treesitter
do
  vim.pack.add { gh 'nvim-treesitter/nvim-treesitter' }
  require('nvim-treesitter').install {
    'lua',
    'ocaml',
  }

  vim.pack.add { gh 'nvim-treesitter/nvim-treesitter-textobjects' }
  require("nvim-treesitter-textobjects").setup {}

  local spec_treesitter = require('mini.ai').gen_spec.treesitter
  require('mini.ai').setup {
    custom_textobjects = {
      f = spec_treesitter({ a = '@function.outer', i = '@function.inner' })
    }
  }
end

-- Filesystem
do
  vim.pack.add { gh 'stevearc/oil.nvim' }
  require('oil').setup {}
  vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
end

-- Completion
do
  vim.pack.add {{ src = gh 'saghen/blink.cmp', version = vim.version.range("^1") }}
  require('blink.cmp').setup {
    signature = { enabled = true }
  }
end
