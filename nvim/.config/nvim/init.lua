vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.signcolumn = 'yes'

-- colorscheme
vim.opt.termguicolors = true

-- Bootstrap lazy.nvim
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
--
-- PLUGINS
require("lazy").setup({
  spec = {
		{import = "plugins"},
	  {'hrsh7th/nvim-cmp'},
		{'m4xshen/autoclose.nvim'},
		{
			"nvim-telescope/telescope-file-browser.nvim",
			dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
		},
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
})


-- autocomplete
local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  mapping = cmp.mapping.preset.insert({
    -- Navigate between completion items
    ['<s-Tab>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
    ['<Tab>'] = cmp.mapping.select_next_item({behavior = 'select'}),

    -- `Enter` key to confirm completion
    ['<cr>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
})

require("autoclose").setup()

require("telescope").setup()
vim.keymap.set("n", "<space>fb", ":Telescope file_browser<CR>")
