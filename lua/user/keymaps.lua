local function opts(desc)
	return {
		noremap = true,
		silent = true,
		desc = desc,
	}
end

local function term_opts(desc)
	return {
		silent = true,
		desc = desc,
	}
end

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts("Go right a window"))
keymap("n", "<C-j>", "<C-w>j", opts("Go down a window"))
keymap("n", "<C-k>", "<C-w>k", opts("Go up a window"))
keymap("n", "<C-l>", "<C-w>l", opts("Go left a window"))

-- Navigate to filetree
keymap("n", "<c-n>", ":NvimTreeToggle<cr>", opts("Toggle Explorer"))

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts("Increase width of window"))
keymap("n", "<C-Down>", ":resize -2<CR>", opts("Decrease width of window"))
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts("Increase height of window"))
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts("Decrease height of window"))

-- Navigate buffers
keymap("n", "<tab>", ":BufferNext<CR>", opts("Go to next buffer"))
keymap("n", "<S-tab>", ":BufferPrevious<CR>", opts("Go to previous buffer"))

-- Save with ctrl-s when in normal mode and insert mode
-- TODO: maybe remove thse because they are a bit weird, but IDK
keymap("n", "<C-s>", ":w<CR>", opts("Save"))
keymap("i", "<C-s>", "<ESC>:w<CR>a", opts("Save"))

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts("Dedent"))
keymap("v", ">", ">gv", opts("Indent"))

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts("Move line down"))
keymap("v", "<A-k>", ":m .-2<CR>==", opts("Move line up"))
keymap("v", "p", '"_dP', opts(""))

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts("Move line down"))
keymap("x", "K", ":move '<-2<CR>gv-gv", opts("Move line up"))
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts("Move line down"))
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts("Move line up"))

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts("Leave to left window"))
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts("Leave to down window"))
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts("Leave to up window"))
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts("Leave to right window"))
