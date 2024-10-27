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
				-- Navigate between completion items
				['<s-Tab>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
				['<Tab>'] = cmp.mapping.select_next_item({behavior = 'select'}),

				-- `Enter` key to confirm completion
				['<cr>'] = cmp.mapping.confirm({select = false}),

				-- Ctrl+Space to trigger completion menu
				['<C-Space>'] = cmp.mapping.complete(),

				-- Scroll up and down in the completion documentation
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
