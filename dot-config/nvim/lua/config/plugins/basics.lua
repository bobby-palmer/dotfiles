-- collection of little to no config plugins and deps for bigger plugins

-- colorscheme
vim.pack.add({ 'https://github.com/folke/tokyonight.nvim' })
vim.cmd[[colorscheme tokyonight-night]]

-- mini basics
vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

require('mini.pairs').setup()
require('mini.icons').setup()
require('mini.surround').setup()
require('mini.comment').setup()
require('mini.extra').setup()

-- default lsp configs
vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
