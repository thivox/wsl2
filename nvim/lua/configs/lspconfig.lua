local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")
-- list of all servers configured.
lspconfig.servers = {
	"lua_ls",
	"clangd",
	"gopls",
	"pyright",
	"ltex",
}

-- list of servers configured with default config.
local default_servers = { "pyright" }

-- lsps with default config
for _, lsp in ipairs(default_servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		on_init = on_init,
		capabilities = capabilities,
	})
end
lspconfig.ltex.setup({
	on_attach = on_attach,
	on_init = on_init,
	capabilities = capabilities,
	settings = {
		ltex = {
			language = "auto", -- Automatically detect language (supports en, fr, etc.)
			dictionary = {
				["en-US"] = {
					"~/.config/nvim/spell/en.utf-8.add", -- Custom English dictionary
				},
				["fr-FR"] = {
					"~/.config/nvim/spell/fr.utf-8.add", -- Custom French dictionary
				},
			},
			checkFrequency = "edit", -- Check on every edit for real-time feedback
			disabledRules = {}, -- No rules disabled, so all grammar/spelling checks are active
			hiddenFalsePositives = true, -- Show all potential issues, including false positives
		},
	},
})
-- lspconfig.ltex.setup({
-- 	on_attach = on_attach,
-- 	on_init = on_init,
-- 	capabilities = capabilities,
-- 	settings = {
-- 		ltex = {
-- 			language = { "en,fr" }, -- Default language
-- 			enabled = { "en", "fr" }, -- Explicitly enable these languages
-- 			dictionary = {
-- 				-- Paths to your custom dictionaries
-- 				["en-US"] = {
-- 					"~/.config/nvim/spell/en.utf-8.add", -- English words
-- 					-- Add more paths if needed
-- 				},
-- 				["fr-FR"] = {
-- 					"~/.config/nvim/spell/fr.utf-8.add", -- French words
-- 				},
-- 			},
-- 			-- Optional: Disable rules (e.g., "MORFOLOGIK_RULE_EN_US" for English)
-- 			disabledRules = {},
-- 			-- Enable hidden false positives (grammar/style checks)
-- 			hiddenFalsePositives = true,
-- 		},
-- 	},
-- })
lspconfig.clangd.setup({
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
		on_attach(client, bufnr)
	end,
	on_init = on_init,
	capabilities = capabilities,
})

lspconfig.gopls.setup({
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
		on_attach(client, bufnr)
	end,

	on_init = on_init,
	capabilities = capabilities,
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gotmpl", "gowork" },
	root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			completeUnimported = true,
			usePlaceholders = true,
			staticcheck = true,
		},
	},
})

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	on_init = on_init,
	capabilities = capabilities,

	settings = {
		Lua = {
			diagnostics = {
				enable = false, -- Disable all diagnostics from lua_ls
				-- globals = { "vim" },
			},
			workspace = {
				library = {
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
					vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
					vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
					"${3rd}/love2d/library",
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
		},
	},
})
