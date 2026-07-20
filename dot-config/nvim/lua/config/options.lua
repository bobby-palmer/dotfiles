local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.scrolloff = 8
opt.cursorline = true

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Files
opt.swapfile = false
opt.undofile = true
opt.updatetime = 250

-- Misc
opt.clipboard = "unnamedplus"
opt.mouse = "a"
