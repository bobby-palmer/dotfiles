return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  -- needs some work for choosing what to ignore and allowing more search functionality
  opts = function()
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
      {'<leader>fg', fzf.git_files},
    }
  end,
}
