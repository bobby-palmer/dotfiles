vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
})

require("blink.cmp").setup({
  keymap = { preset = "default" },
  completion = {
    documentation = { auto_show = false },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
    -- Experimental signature help support
  signature = { enabled = true }

})

-- Advertise blink's completion capabilities to every server. Neovim's defaults
-- have completionItem.snippetSupport = false, so without this ocamllsp won't
-- emit function-argument placeholders. The '*' config merges into all servers.
vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})
