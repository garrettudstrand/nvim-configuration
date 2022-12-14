local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	--[[ operators = { gc = "Comments" }, ]]
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	["/"] = { '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', "Comment" },
	["a"] = { "<cmd>Alpha<cr>", "Alpha" },
	["e"] = { "<cmd>NvimTreeFocus<cr>", "Explorer" },
	["q"] = { "<cmd>q!<CR>", "Quit" },
	["c"] = { "<cmd>BufferClose<CR>", "Close Buffer" },
	["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },

	f = {
		name = "Find",
		f = { "<cmd>Telescope find_files<cr>", "Files" },
		s = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		c = { "<cmd>Telescope commands<cr>", "Commands" },
		h = { "<cmd>Telescope help_tags<cr>", "Help" },
		r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		t = { "<cmd>Telescope live_grep<cr>", "Text" },
		b = { "<cmd>Telescope buffers<cr>", "Buffers" },
		p = { "<cmd>Telescope projects<cr>", "Projects" },
	},

	p = {
		name = "Packer",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},

	g = {
		name = "Git",
		g = { "<cmd>abo :Git<CR>", "Fugitive" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame Line" },
		L = { "<cmd>Git blame<cr>", "Blame File" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout Branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout Commit" },
		d = {
			"<cmd>Gvdiffsplit<cr>",
			"Diff",
		},
	},

	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = {
			"<cmd>TroubleToggle document_diagnostics<cr>",
			"Document Diagnostics",
		},
		w = {
			"<cmd>TroubleToggle workspace_diagnostics<cr>",
			"Workspace Diagnostics",
		},
		f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		--[[ j = { ]]
		--[[ 	"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", ]]
		--[[ 	"Next Diagnostic", ]]
		--[[ }, ]]
		--[[ k = { ]]
		--[[ 	"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", ]]
		--[[ 	"Prev Diagnostic", ]]
		--[[ }, ]]
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		m = { "<cmd>Mason<cr>", "Mason (Insall LSPs)" },
		q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
		s = { "<cmd>SymbolsOutline<cr>", "Toggle Symbols Outline" },
	},

	d = {
		name = "Debugging",
		r = { "<Cmd>lua require'dap'.continue()<CR>", "Continue/Run Debug" },
		n = { "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle Normal Breakpoint" },
		c = {
			"<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
			"Set Conditional Breakpoint",
		},
		l = { "<Cmd>lua require'dap'.run_last()<CR>", "Run Last Debug Config" },
		e = { "<Cmd>lua require('dapui').eval(nil, {enter = true})<CR>", "Evaluate Highlighted Code" },
	},

	--[[ t = { ]]
	--[[   name = "Terminal", ]]
	--[[   n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" }, ]]
	--[[   u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" }, ]]
	--[[   t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" }, ]]
	--[[   p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" }, ]]
	--[[   f = { "<cmd>ToggleTerm direction=float<cr>", "Float" }, ]]
	--[[   h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" }, ]]
	--[[   v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" }, ]]
	--[[ }, ]]
}

local vopts = {
	mode = "v", -- VISUAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}
local vmappings = {
	["/"] = { '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', "Comment" },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
