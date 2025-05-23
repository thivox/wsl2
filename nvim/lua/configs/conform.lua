local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		c_pp = { "clang-format" },
		c = { "clang_format" },
		cpp = { "clang_format" },
		go = { "gofumpt", "goimports-reviser", "golines" },
		python = { "black", },
		-- css = { "prettier" },
		-- html = { "prettier" },
	},

	formatters = {
		-- Python
		black = {
			prepend_args = {
				"--fast",
				"--line-length",
				"80",
			},
		},
		["goimports-reviser"] = {
			prepend_args = { "-rm-unused" },
		},
		golines = {
			prepend_args = { "--max-len=80" },
		},
		["clang-format"] = {
			prepend_args = {
				"-style={ \
                IndentWidth: 4, \
                TabWidth: 4, \
                UseTab: Never, \
                AccessModifierOffset: 0, \
                IndentAccessModifiers: true, \
                PackConstructorInitializers: Never}",
			},
		},
	},

	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
}

return options
