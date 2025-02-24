local servers = {
	tsserver = {},
	rust_analyzer = {},
	pyright = {},
	clangd = {},
}

local system_servers = {
	ocamllsp = {
		cmd = { "opam", "exec", "--", "ocamllsp" },
	},
	hls = {},
	ccls = {},
	zls = {},
}

local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>vrr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
end

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"williamboman/mason.nvim",
				config = true,
				build = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			"williamboman/mason-lspconfig.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			require("neodev").setup({
				override = function(_, library)
					library.enabled = true
					library.plugins = true
				end,
				pathStrict = false,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")

			servers = vim.tbl_extend("keep", servers, {
				lua_ls = {
					Lua = {
						workspace = {
							checkThirdParty = "Disable",
							library = {
								vim.fn.expand("$VIMRUNTIME"),
								require("neodev.config").types(),
							},
						},
						telemetry = { enable = false },
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			})

			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers),
			})

			mason_lspconfig.setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						on_attach = on_attach,
						settings = servers[server_name],
						filetypes = (servers[server_name] or {}).filetypes,
					})
				end,
			})

			for server_name, server_config in pairs(system_servers) do
				lspconfig[server_name].setup({
					on_attach = on_attach,
					settings = server_config,
					capabilities = capabilities,
				})
			end
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			require("luasnip.loaders.from_vscode").lazy_load()
			luasnip.config.setup({})

			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<Tab>"] = nil,
					["<S-Tab>"] = nil,
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				},
			})
		end,
	},
	{
		"dmmulroy/ts-error-translator.nvim",
		config = true,
	},
	--[[{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({})
		end,
	},--]]
	{
		"folke/trouble.nvim",
		keys = {
			{
				"<leader>vd",
				"<cmd>Trouble diagnostics toggle focus=false filter.buf=0<cr>",
				desc = "Diagnostics (Trouble)",
			},
		},
		cmd = { "Trouble" },
		opts = {},
	},
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			local refactoring = require("refactoring")
			refactoring.setup()

			vim.keymap.set({ "n", "x" }, "<leader>ri", function()
				refactoring.refactor("Inline Variable")
			end)

			vim.keymap.set("n", "<leader>rI", function()
				refactoring.refactor("Inline Function")
			end)
		end,
	},
}
