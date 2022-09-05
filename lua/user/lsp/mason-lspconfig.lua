local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
	return
end

mason_lspconfig.setup({
	-- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "sumneko_lua" }
	-- This setting has no relation with the `automatic_installation` setting.
	ensure_installed = {"jsonls", "sumneko_lua"},

	-- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
	-- This setting has no relation with the `ensure_installed` setting.
	-- Can either be:
	--   - false: Servers are not automatically installed.
	--   - true: All servers set up via lspconfig are automatically installed.
	--   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
	--       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
	automatic_installation = false,
})

local opts = {
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
}

require("mason-lspconfig").setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup({})
	end,

  ["jsonls"] = function (server_name)
    local jsonls_opts = require("user.lsp.settings.jsonls")
	 	local final_opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
    require("lspconfig")[server_name].setup(final_opts)
  end,

  ["sumneko_lua"] = function (server_name)
    local sumneko_opts = require("user.lsp.settings.sumneko_lua")
	 	local final_opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    require("lspconfig")[server_name].setup(final_opts)
  end,
})
