-- orchestrate the order of plugin loading
require('config.plugins.basics')
require('config.plugins.oil')
require('config.plugins.treesitter')
require('config.plugins.lsp')
require('config.plugins.completion')
require('config.plugins.picker')
