vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.enable({
  "gopls",
  "lua_ls",
  "ocamllsp",
})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  severity_sort = true,
})

-- TODO inlay hints, keymaps, etc:
--
--   -- Formatting (no default; or do it on BufWritePre instead)
-- map("<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Format")
--
-- -- Go-to-definition on gd (default is only <C-]> via tagfunc)
-- map("gd", vim.lsp.buf.definition, "Definition")
-- map("gD", vim.lsp.buf.declaration, "Declaration")   -- rarely useful, but free
--
-- -- Call hierarchy — "who calls this / what does this call"
-- map("<leader>ci", vim.lsp.buf.incoming_calls, "Incoming calls")
-- map("<leader>co", vim.lsp.buf.outgoing_calls, "Outgoing calls")
--
-- -- Workspace symbol search (gO is document-only)
-- map("<leader>cS", vim.lsp.buf.workspace_symbol, "Workspace symbols")
--
-- -- Code lens (only if you enabled codelens.enable — e.g. your ocamllsp signatures)
-- map("<leader>cl", vim.lsp.codelens.run, "Run code lens")
--
-- Toggles — very handy, no defaults
--
-- -- Inlay hints on/off (the OCaml type hints)
-- map("<leader>th", function()
--   vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
-- end, "Toggle inlay hints")
--
-- -- Diagnostics display toggle (declutter when you want to just read code)
-- map("<leader>td", function()
--   vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
-- end, "Toggle diagnostic text")
--
-- Diagnostics → lists
--
-- -- All diagnostics into quickfix/loclist (pairs with your quickfix workflow)
-- map("<leader>cq", vim.diagnostic.setqflist, "Diagnostics → quickfix")
-- map("<leader>cQ", vim.diagnostic.setloclist, "Diagnostics → loclist")
--
