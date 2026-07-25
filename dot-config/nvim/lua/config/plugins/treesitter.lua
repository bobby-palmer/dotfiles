-- Requires tree-sitter-cli installed

vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

require('nvim-treesitter').setup {}

require('nvim-treesitter').install {
  'go',
  'lua',
  'markdown',
  'markdown_inline',
  'ocaml',
  'python'
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function(args)
    if vim.bo[args.buf].buftype ~= "" then
      return
    end

    local ft = vim.bo[args.buf].filetype
    local lang = vim.treesitter.language.get_lang(ft) or ft

    -- only start if a parser is actually installed for this language
    if vim.treesitter.language.add(lang) then
      vim.treesitter.start(args.buf, lang)
    end
  end,
})
