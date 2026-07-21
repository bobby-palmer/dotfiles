require('mini.pick').setup {}

vim.keymap.set('n', '<leader>ff', '<cmd>Pick files tool="git"<CR>', { desc = "Pick git files" })
vim.keymap.set('n', '<leader>fr', '<cmd>Pick resume<CR>', { desc = "Resume last picker" })
vim.keymap.set('n', '<leader>fb', '<cmd>Pick buffers<CR>', { desc = "Pick open buffers" })
