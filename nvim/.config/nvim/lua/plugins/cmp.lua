return {
	"hrsh7th/nvim-cmp",
	dependencies = {"m4xshen/autoclose.nvim"},
	config = function()

		local cmp = require('cmp')

		cmp.setup({
			sources = {
				{name = 'nvim_lsp'},
			},

			mapping = cmp.mapping.preset.insert({
				['<cr>'] = cmp.mapping.confirm({select = false}),
				['<Tab>'] = cmp.mapping.confirm({select = true}),

        ['<C-e>'] = cmp.mapping.abort(),
				['<C-Space>'] = cmp.mapping.complete(),

        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),

				['<C-u>'] = cmp.mapping.scroll_docs(-4),
				['<C-d>'] = cmp.mapping.scroll_docs(4),
			}),

			snippet = {
				expand = function(args)
					vim.snippet.expand(args.body)
				end,
			},
		})

		require("autoclose").setup()

	end
}
