-- maybe switch to buffer overlay
-- options: neogit, diffview, gitsigns, mini.diff, lazygit
vim.pack.add({ 'https://github.com/lewis6991/gitsigns.nvim' })

require('gitsigns').setup {
  attach_to_untracked = true
}

-- TODO add keymaps
