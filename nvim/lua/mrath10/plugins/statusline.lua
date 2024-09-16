return {
	{
		"tjdevries/express_line.nvim",
		config = function()
			local builtin = require "el.builtin"
			local extensions = require "el.extensions"
			local subscribe = require "el.subscribe"
			local sections = require "el.sections"

			vim.opt.laststatus = 3 -- Global statusline

			require("el").setup {
				generator = function()
					local segments = {}

					-- Left: Mode (e.g., NORMAL) and Git branch
					table.insert(segments, extensions.mode)
					table.insert(segments, " ")

					table.insert(
						segments,
						subscribe.buf_autocmd("el-git-branch", "BufEnter", function(win, buf)
							local branch = extensions.git_branch(win, buf)
							if branch then
								return branch
							end
							return ""
						end)
					)

					-- Separator to move to middle
					table.insert(segments, sections.split)

					-- Middle: File path
					table.insert(segments, "%f")

					-- Separator to move to right
					table.insert(segments, sections.split)

					-- Right: Filetype and line/column
					table.insert(segments, builtin.filetype) -- Filetype as text, not icon

					table.insert(segments, "[")
					table.insert(segments, builtin.line_with_width(3))
					table.insert(segments, ":")
					table.insert(segments, builtin.column_with_width(2))
					table.insert(segments, "]")

					return segments
				end,
			}
		end,
	},
}
