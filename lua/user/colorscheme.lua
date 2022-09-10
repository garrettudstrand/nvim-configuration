-- This will give a more reasonable error message if we can't set the colorscheme we want
vim.g.catppuccin_flavour = "mocha"
local colorscheme = "catppuccin"

local catppuccin_status_ok, catppuccin = pcall(require, "catppuccin")
if not catppuccin_status_ok then
	return
end

catppuccin.setup({
	transparent_background = false,
	term_colors = false,
	compile = {
		enabled = false,
		path = vim.fn.stdpath("cache") .. "/catppuccin",
	},
	dim_inactive = {
		enabled = false,
		shade = "dark",
		percentage = 0.15,
	},
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
	integrations = {
		-- For various plugins integrations see https://github.com/catppuccin/nvim#integrations
		aerial = false,
		barbar = true,
		beacon = false,
		cmp = true,
		coc_nvim = false,
		dashboard = false,
		fern = false,
		fidget = true,
		gitgutter = false,
		gitsigns = true,
		hop = false,
		leap = false,
		lightspeed = false,
		lsp_saga = false,
		lsp_trouble = true,
		markdown = true,
		mini = false,
		neogit = false,
		notify = false,
		nvimtree = true,
		overseer = false,
		pounce = false,
		symbols_outline = true,
		telekasten = false,
		telescope = true,
		treesitter = true,
		treesitter_context = false,
		ts_rainbow = true,
		vim_sneak = false,
		vimwiki = false,
		which_key = true,

		indent_blankline = {
			enabled = true,
			colored_indent_levels = false,
		},

		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
	},
	color_overrides = {},
	highlight_overrides = {},
})

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end
