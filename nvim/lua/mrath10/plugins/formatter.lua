return {
  {
    "stevearc/conform.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("conform").setup({
        format = {
          timeout_ms = 1000,
          lsp_fallback = true,
        },
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "prettierd" },
          typescript = { "prettierd" },
          javscriptreact = { "prettierd" },
          typescriptreact = { "prettierd" },
          json = { "prettierd" },
          css = { "prettierd" },
          c = { "clang-format" },
          cpp = { "clang-format" },
          html = { "prettierd" },
          haskell = { "ormolu" },
          blade = { "prettierd" },
          php = { "prettierd" },
          astro = { "prettierd" },
        },
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format({ bufnr = args.buf, lsp_fallback = true })
        end,
      })

      vim.keymap.set("n", "<leader>f", function()
        require("conform").format({ async = true, lsp_fallback = true })
      end, { desc = "Format" })
    end,
  },
}
