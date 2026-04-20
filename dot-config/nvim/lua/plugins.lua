-- color scheme
vim.pack.add({'https://github.com/rebelot/kanagawa.nvim'})
vim.cmd('colorscheme kanagawa')


-- mini
vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

require('mini.icons').setup {}

require('mini.pairs').setup {}

require('mini.pick').setup {} -- fzf lua?
vim.keymap.set('n', '<leader>f', ':Pick files<CR>')


-- completion
vim.pack.add({{ src = 'https://github.com/saghen/blink.cmp', version = 'v1' }})

require('blink.cmp').setup {} -- TODO settings


-- file explorer
vim.pack.add({ 'https://github.com/stevearc/oil.nvim' })

require('oil').setup {
  keymaps = {
    -- disable for window switching
    ['<C-h>'] = false,
    ['<C-l>'] = false,
  }
}

vim.keymap.set('n', '-', ':Oil<CR>') -- vim vinegar


-- default lsp configs
vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })


-- treesitter
vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })

require('nvim-treesitter').install {
  'lua',
  'golang',
  'ocaml',
  'zig',
}

-- enable highlighting
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
		local filetype = vim.bo.filetype
		if filetype and filetype ~= "" then
			pcall(vim.treesitter.start)
		end
	end,
})
