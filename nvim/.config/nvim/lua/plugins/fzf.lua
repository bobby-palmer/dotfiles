return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  opts = function ()
    return {
      files = {
        hidden = false
      }
    }
  end,

  keys = function ()
    local fzf = require("fzf-lua")
    return {
      {'<leader>ff', fzf.files},
      {'<leader>fs', fzf.lsp_document_symbols},
      {'<leader>ft', fzf.treesitter},
    }
  end,
}
