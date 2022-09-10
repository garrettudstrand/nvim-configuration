-- Configurations for nvim-tree
-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
	return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

-- Move barbar when nvim-tree opens https://github.com/romgrk/barbar.nvim#integration-with-filetree-plugins
local function get_tree_size()
	return require("nvim-tree.view").View.width
end

local events_status_ok, nvim_tree_events = pcall(require, "nvim-tree.events")
if not events_status_ok then
	return
end

local state_status_ok, bufferline_state = pcall(require, "bufferline.state")
if not state_status_ok then
	return
end

nvim_tree_events.subscribe("TreeOpen", function()
	bufferline_state.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe("Resize", function()
	bufferline_state.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe("TreeClose", function()
	bufferline_state.set_offset(0)
end)

nvim_tree.setup({
	disable_netrw = true,
	hijack_netrw = true,
	open_on_setup = false,
	ignore_ft_on_setup = {
		"startify",
		"dashboard",
		"alpha",
	},
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = true,
	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = true,
		update_cwd = true,
		ignore_list = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	actions = {
		open_file = {
			resize_window = true,
			quit_on_open = false,
		},
	},
	view = {
		width = 30,
		height = 30,
		hide_root_folder = false,
		side = "left",
		mappings = {
			custom_only = false,
			list = {
				{ key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
				{ key = "h", cb = tree_cb("close_node") },
				{ key = "v", cb = tree_cb("vsplit") },
			},
		},
		number = false,
		relativenumber = false,
	},
	renderer = {
		root_folder_modifier = ":t",
		highlight_git = true,
		icons = {
			show = {
				git = true,
				file = true,
				folder = true,
				folder_arrow = true,
			},
			glyphs = {
				default = "",
				symlink = "",
				git = {
					unstaged = "",
					staged = "S",
					unmerged = "",
					renamed = "➜",
					deleted = "",
					untracked = "U",
					ignored = "◌",
				},
				folder = {
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
				},
			},
		},
	},
})
