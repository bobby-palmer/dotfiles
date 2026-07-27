vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
})

require("blink.cmp").setup({
  keymap = { preset = "default" },
  fuzzy = { implementation = "prefer_rust_with_warning" },
    -- Experimental signature help support
  signature = { enabled = true }
})
