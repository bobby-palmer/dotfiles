-- maybe switch to buffer overlay
-- options: neogit, diffview, gitsigns, mini.diff, lazygit
vim.pack.add({ 'https://github.com/lewis6991/gitsigns.nvim' })

require('gitsigns').setup {
  attach_to_untracked = true
}

vim.keymap.set('n', ']h', '<cmd>Gitsigns nav_hunk next<CR>', { desc = "Jump to next hunk" })
vim.keymap.set('n', '[h', '<cmd>Gitsigns nav_hunk prev<CR>', { desc = "Jump to prev hunk" })
