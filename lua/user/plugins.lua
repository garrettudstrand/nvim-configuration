local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used by lots of plugins
	use({ "catppuccin/nvim", as = "catppuccin" }) -- Catppuccin colorscheme

	-- Completion(autocomplete) plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp") -- LSP completions
	use("hrsh7th/cmp-nvim-lua") -- Completions for working on lua configs (like this file)
	use("rcarriga/cmp-dap") -- Completions when working in nvim-dap's REPL

	-- Snippets - we need a snippet engine and a set of snippets for snippet completions. These plugins provide those
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- LSP or Language Server Protocol. Used for linting and more advanced language completions
	use("williamboman/mason.nvim") -- LSP installer
	use("williamboman/mason-lspconfig.nvim") -- Helper to make LSP installer work nicer with nvim-lspconfig
	use("neovim/nvim-lspconfig") -- enable LSP
	use("jose-elias-alvarez/null-ls.nvim") -- null-ls - formatting and style linting
	use("folke/trouble.nvim") -- Make it easier to read through diagnostics
	use("j-hui/fidget.nvim") -- Show loading information on LSP

	-- Telescope - our fuzzy finder search thing
	use("nvim-telescope/telescope.nvim")
	use("ahmedkhalf/project.nvim") -- support for finding and opening projects

	-- Treesitter - better syntax highlighting for files (there is more to use if wanted though)
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("p00f/nvim-ts-rainbow") -- add rainbow colors to parantheses

	-- nvim-tree - a nicer file tree replacement for netrw
	use("kyazdani42/nvim-web-devicons") -- the icons it uses
	use("kyazdani42/nvim-tree.lua") -- the actual file tree

	-- alpha - a dashboard when you open neovim
	use("goolord/alpha-nvim")

	-- whichkey - provides help in determining what shortcut to use
	use("folke/which-key.nvim")

	-- Git - the extensions that add git support
	use("lewis6991/gitsigns.nvim") -- Git support (like showing which lines are added or removed)
	use("tpope/vim-fugitive") -- Another git client

	-- DAP - add debugging
	use("mfussenegger/nvim-dap") -- add debugging
	use("nvim-telescope/telescope-dap.nvim") -- override nvim-dap menus to use telescope
	use("rcarriga/nvim-dap-ui") -- nice, experimental UI for nvim-dap

	-- Extra quality of life improvements
	use("windwp/nvim-autopairs") -- if you insert an open parantheses, add the closed one, works with CMP and Treesitter
	use("numToStr/Comment.nvim") -- easily comment stuff by hitting gc
	use("JoosepAlviste/nvim-ts-context-commentstring") -- fancier commenting. It can figure out if something is, like, JSX. Works with Treesitter
	use("romgrk/barbar.nvim") -- Tabline for buffers
	use("nvim-lualine/lualine.nvim") -- statusline plugin
	use("lewis6991/impatient.nvim") -- improve package loading time on startup
	use("lukas-reineke/indent-blankline.nvim") -- add indent lines to neovim
	use("antoinemadec/FixCursorHold.nvim") -- fix performance on CursorHold events
	use("simrat39/symbols-outline.nvim") -- show symbols in a file

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
