vim.lsp.enable({
  'lua_ls',
  'gopls',
  'zls',
  'tinymist',
  'pyright',
})

vim.lsp.config["tinymist"] = {
    cmd = { "tinymist" },
    filetypes = { "typst" },
    settings = {
        -- ...
    }
}
