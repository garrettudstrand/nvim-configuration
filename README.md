# Nice Neovim Configuration

This is just a nice neovim configuration to make neovim work like an IDE while
still running reasonably fast. It's based on the neovim configuration shown in
this series:
[Neovim IDE from Scratch - Introduction (100% lua config) - YouTube](https://www.youtube.com/watch?v=ctH-a-1eUME&list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ&index=1).
However, I've gone beyond what the series shows, changed some of the
configurations used in the series and have generally made this configuration my
own

# Usage

This configuration is intended to be used as an IDE. Most features should appear
after hitting one of the following keys. The leader key, or space, is to find
features that are used once and then only used after a bit of time. For example,
you'll find all the commands for finding text or files here. Hitting the square
bracket keys `[` or `]` will allow you to jump forward to different blocks or
lines in your file. It's how you jump between hunks, diagnostics, functions,
etc. The `g` key is for commands that are common and will be used over and over
again. It's also responsible for commands that make you go to certain locations,
like different files. This includes commands like showing a line's diagnostic or
going to definitions or declarations. These are bound to change as I use this
more and other people use it and I determine what's easiest to understand and
most comfortable.

Which key is used to tell you what commands you can run from your current
keybinding. If you hit "g", you'll see all the commands you can run from "g". If
you hit "<leader>", you'll see all the commands you can run from that.
Currently, which key outputs every helpful binding it can, but that may be fine
tuned in the future.

Below, I describe what all the plugins do, and, in the case they do a lot more
than we use, I describe what exactly we use from each plugin

Of course, in terms of navigating the editor and editing things, just use all
the neovim stuff you know and love.

# Plugins

- [wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim) - this is
  a plugin that manages plugins. Packer is used to install everything else in
  `plugins.lua`

- [nvim-lua/popup.nvim](https://github.com/nvim-lua/popup.nvim) and
  [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim) are common
  dependencies of other plugins

- [catppuccin/nvim](https://github.com/catppuccin/nvim) is the colorscheme used
  in the configuration, which has also been setup to use its integrations with
  many of the other plugins installed

- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) is what provides
  completions while you're typing

  - [nvim-cmp · GitHub Topics](https://github.com/topics/nvim-cmp) and
    [List of sources · hrsh7th/nvim-cmp Wiki (github.com)](https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources)
    list out all the different plugins that can be used as sources for
    `nvim-cmp`. `nvim-cmp` doesn't provide any completions out of the box, you
    install plugin sources to provide completions, and those are lists of plugin
    sources to try

- [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer) provides
  completions to `nvim-cmp` by searching through the current buffer

- [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path) provides completions
  to `nvim-cmp` for filesystem paths

- [hrsh7th/cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline) provides
  completions for command mode and searches to `nvim-cmp`

- [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
  provides completions from
  [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip) to `nvim-cmp`

- [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip) is a snippet engine
  for neovim

- [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
  provides a large set of snippets to
  [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip).

- [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) provides
  completions from neovim's built-in language server client to `nvim-cmp`
  (setting up an LSP will provide the completions to the language server client
  which will provide them to this plugin which will provide them to `nvim-cmp`)

- [hrsh7th/cmp-nvim-lua](https://github.com/hrsh7th/cmp-nvim-lua) will provide
  completions for neovim's Lua API to `nvim-cmp`

- [rcarriga/cmp-dap](https://github.com/rcarriga/cmp-dap) will provide
  completions for
  [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap)'s REPL to
  `nvim-cm\p`

- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) is an
  installer used to install LSP servers, DAP servers, linters and formatters

- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) -
  this plugin helps
  [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) work
  with [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) and
  makes it easier to configure our language servers

  - This plugin maps the names of lspconfig server to mason. The list of
    mappings if found
    [here](https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md)

- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) allows you
  to configure neovim's LSP client

- [jose-elias-alvarez/null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)
  allows to use the LSP client to perform code actions, diagnostics, formatting,
  hovers and completions. We leave the completions to `nvim-cmp`, but the rest
  of our LSP stuff is done through this

- [folke/trouble.nvim](https://github.com/folke/trouble.nvim) allows us to open
  a prety list for diagnostics, references, telescope lists, whatever else

- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
  is a fuzzy finder that we use for basically any list that needs to be searched
  through

- [ahmedkhalf/project.nvim](https://github.com/ahmedkhalf/project.nvim) is a
  plugin that detects projects when you open files, and uses that to set
  [kyazdani42/nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua) to the
  right root. It also keeps a list of recent projects that you can search
  through with
  [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
  parses files and uses that parsing information to provide a bunch of cool
  features. The main one we use is superior syntax highlighting

- [p00f/nvim-ts-rainbow](https://github.com/p00f/nvim-ts-rainbow) is an
  extension to treesitter that gives nested parantheses different colors

- [kyazdani42/nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)
  is a set of cool icons to use in neovim. This is used by a lot of plugins, but
  most notably
  [kyazdani42/nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)

- [kyazdani42/nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)
  provides a file tree that is all-around better than netrw. Nice symbols,
  support for adding and deleting files and other things like that

- [goolord/alpha-nvim](https://github.com/goolord/alpha-nvim) provides a nice
  dashboard when you open neovim and a bunch of options on what to do

- [folke/which-key.nvim)](https://github.com/folke/which-key.nvim) displays a
  popup for what commands you may be trying to run

- [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) adds
  symbols in your gutter to show you what has been added, removed or modified in
  git. It also allows you to preview hunks

- [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive) is a git wrapper
  for vim

- [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap) provides
  debugging to vim using Debugging Adapter Protocols (DAPs)

- [nvim-telescope/telescope-dap.nvim](https://github.com/nvim-telescope/telescope-dap.nvim)
  overrides [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap)'s
  menus to use
  [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

- [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) provides an
  experimental UI for
  [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap) so that it
  looks nicer

- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) provides
  autopairing. When you type an open parantheses, it closes it

- [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim) allows you
  to easily comment out lines

- [JoosepAlviste/nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)
  uses
  [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
  to make the commenting for
  [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim) smarter (it
  will comment out JSX properly in a React file, for example)

- [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim) displays
  buffers as a list of tabs, so you can more easily go through them

- [moll/vim-bbye](https://github.com/moll/vim-bbye) allows you to close buffers
  without messing up your layout or deleting windows

- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
  makes the statusline look a lot fancier and adds useful information to it

- [lewis6991/impatient.nvim](https://github.com/lewis6991/impatient.nvim)
  improves startup time for neovim by caching plugins

- [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
  adds little indentation lines

- [antoinemadec/FixCursorHold.nvim](https://github.com/antoinemadec/FixCursorHold.nvim)
  fixes the performance of CursorHold events, which are used in some of the
  plugins

- [simrat39/symbols-outline.nvim](https://github.com/simrat39/symbols-outline.nvim)
  allows you to pull open a treelike view of symbols in a file

# Dependencies

If you ever want to see if you are missing any dependencies, run `:checkhealth`

- You'll need to install a fresh copy of [Neovim](https://neovim.io/)

- Neovim relies on
  [VCRedist](https://docs.microsoft.com/en-US/cpp/windows/latest-supported-vc-redist?view=msvc-170)

- You'll need to install each formatter, diagnostic tool, etc. you use with
  [jose-elias-alvarez/null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim).
  You can usually find these available in Mason. But, if not, there also usually
  installed in your package manager. Only two are setup currently, but more may
  be added in the future depending on what is needed

  - [JohnnyMorganz/StyLua](https://github.com/JohnnyMorganz/StyLua) is installed
    for Lua formatting
  - [prettier/prettier](https://github.com/prettier/prettier) is installed for
    markdown files, but is able to handle a large number of different file types

- [BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep) is used by
  [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
  to perform its searches

- [sharkdp/fd](https://github.com/sharkdp/fd) is used by
  [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim),
  but it is not required

- [Git](https://git-scm.com/) is required for all the git commands and support

- [Tar](https://www.gnu.org/software/tar/) and [curl](https://curl.se/) are
  needed to run Treesitter, but come by default with most installations of
  [Git](https://git-scm.com/)

- A C compiler is also required for Treesitter. Mac and Linux users should be
  fine, but windows users will want to refer to
  [Treesitter's documentation on the matter](https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support)

- [7-Zip](https://www.7-zip.org/) is required for
  [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)

- There are also a series of dependncies fpr
  [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) that can
  be seen when you run `:checkhealth mason`. You don't necessarily need all of
  them, but check there if mason complains about missing dependencies

# Extending the Existing Plugins

You can use this source -
[rockerBOO/awesome-neovim](https://github.com/rockerBOO/awesome-neovim) - to
find more plugins that may be useful to you. Once you find one, go to
`plugins.lua` and add a `use` statement to import the plugin. Then, create a new
file at the same level as `plugins.lua` called `<plugin_name>.lua`. In that
file, require the new plugin and add all your configurations. When requiring the
plugin, do it like this

```lua
local status_ok, project = pcall(require, "project_nvim")
if not status_ok then
    return
end
```

So that the plugin doesn't throw a bunch of unecessary errors in the case it
isn't installed.

In terms of the actual configurations, most plugins provide a section where they
show all the default configurations in one big object. I would recommend copy
and pasting that over so you can change settings easier. This does mean the
config will break on some updates and you'll need to fix it, but it's good to
know about config changes and it's good to know what all the possible
configurations you can do are.

In any case, after you write your configurations, go to the top level `init.lua`
file and add the line `require "user.<plugin_name>"`.

If you are working on adding a lot of plugins for a particularly complex
feature, like `LSP` stuff, you can add a folder into `user` and group all the
configurations there. Use `LSP` as an example if you need to do that.

# Useful Files to Know About

- `plugins.lua` is where Packer installs all our plugins

- `whichkey.lua` configures the popup that comes up when you hit the leader key,
  g or ctrl-w

- `options.lua` is what configures all the options you get with neovim out of
  the box

- `keymaps.lua` is where the key mappings that aren't displayed in
  `whichkey.lua` are configured.

- `lsp/handlers.lua` is where most of the visible parts of the `LSP`
  configuration are configured, and is where all the keymaps not shown in the
  popup for `LSP` are configured

# Useful Commands to Know About

- In most areas, hitting `g?` will toggle a help pane to give you the commands
  possible in that buffer

- Hitting `I` in nvim tree pulls up all your git ignored files, they are hiddedn
  by default

  - There are various other commands in nvim tree for hiding/showing certain
    files, use `g?` to learn them all

# Troubleshooting

- A lot of the LSP stuff and plugins work by automagically determining what set
  of folders and files make up a project. Makign your project a git repo can
  suddenly make a lot of features that are bugging out suddenly work

# Potential Things to Work On

- Keymaps will always need work! I want to make them easier to understand and
  more useful over time

- Currently with debugging, you have to hit `<leader>d` to get any of the
  commands to appear. I'm considering using something like
  [anuvyklack/hydra.nvim](https://github.com/anuvyklack/hydra.nvim) to create a
  debugging mode, but I'm not too sure on that yet

- `g`, as can be expected, stores A LOT of keybindings, I'm wondering if there's
  a way to reduce the strain on `g` based bindings

- Each language should probably be organized into its own file for the `dap`
  stuff. Also, apparently Mason somehow provides the executable so you don't
  need to dig up the `dap` path, but I can't figure that out

- `null-ls` has code actions and other features that would be great to implement

- Should possibly configure `nvim-dap-ui` to look nicer and to close the file
  tree when it starts up

- Currently, I use prettier to lint markdown files, because it is easy to setup
  and doesn't require me creating a configuration file, but perhaps I should use
  `markdownlint`, which would require some JSON file

- Potentially port lua code over to fennel
  ([the Fennel programming language (fennel-lang.org)](https://fennel-lang.org/))?
  It looks interesting, but I'm not sure if it's worth it yet
