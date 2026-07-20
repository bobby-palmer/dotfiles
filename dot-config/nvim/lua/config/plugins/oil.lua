vim.pack.add({ "https://github.com/stevearc/oil.nvim" })

require("oil").setup({
  columns = { "icon" },
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    -- Remove for window switching
    ["<C-h>"] = false,
    ["<C-l>"] = false,
  },
})

vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" }) -- vim vinegar
