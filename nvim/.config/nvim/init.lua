vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins={
  {"rebelot/kanagawa.nvim"},
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  {"github/copilot.vim"},
  {
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},}
}
local opts={}


require("lazy").setup(plugins,opts)
require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html","go" },
  highlight = { enable = true },
  indent = { enable = true },  
})
vim.cmd("colorscheme catppuccin-mocha")
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
