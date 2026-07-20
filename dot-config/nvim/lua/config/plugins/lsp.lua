-- lua/plugins/lsp.lua
vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
})

-- Native config: nvim-lspconfig supplies definitions for lua_ls, gopls,
-- ocamllsp, and everything else via its lsp/ directory. vim.lsp.config/enable
-- are pure Neovim APIs -- this plugin just adds more servers to pick from.

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

vim.lsp.enable({ "lua_ls", "gopls", "ocamllsp" })

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  severity_sort = true,
})
