return {
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			theme = "hyper",
			config = {
				packages = { enable = false },
				week_header = {
					enable = true,
					append = (function()
						math.randomseed(os.time())
						local lines = { "" }

						-- Last 2 commits with stats
						local log = io.popen("git log -n 2 --pretty=format:'%s' --shortstat 2>/dev/null")
						if log then
							local output = log:read("*a")
							log:close()
							local commits = {}
							local current_msg = nil
							for line in output:gmatch("[^\n]+") do
								if not line:match("^%s") then
									current_msg = line:sub(1, 50)
									if #line > 50 then current_msg = current_msg .. "..." end
								elseif current_msg and line:match("insertion") then
									local ins = line:match("(%d+) insertion") or "0"
									local del = line:match("(%d+) deletion") or "0"
									table.insert(commits, current_msg .. " +" .. ins .. " -" .. del)
									current_msg = nil
								end
							end
							for _, c in ipairs(commits) do
								table.insert(lines, "  " .. c)
							end
						end

						-- This week stats
						local week_stats = io.popen("git log --since='1 week ago' --shortstat --format='' 2>/dev/null")
						local week_commits = io.popen("git rev-list --count --since='1 week ago' HEAD 2>/dev/null")
						if week_stats and week_commits then
							local stats_out = week_stats:read("*a")
							local count = tonumber(week_commits:read("*l")) or 0
							week_stats:close()
							week_commits:close()
							if count > 0 then
								local total_ins, total_del = 0, 0
								for line in stats_out:gmatch("[^\n]+") do
									total_ins = total_ins + (tonumber(line:match("(%d+) insertion")) or 0)
									total_del = total_del + (tonumber(line:match("(%d+) deletion")) or 0)
								end
								local quotes = {
									"Lets build!",
									"Happy coding!",
									"Keep shipping!",
									"You got this!",
									"Make it happen!",
									"Ship it!",
									"Code wins arguments",
									"Launch fast, iterate faster",
									"Done is better than perfect",
									"Keep it simple",
									"Make it work, make it right, make it fast",
									"Less is more",
									"Design is how it works",
									"Stay hungry, stay foolish",
									"Build something people want",
									"Move fast, break things",
									"Think different",
									"Just ship it already!",
									"Simplicity is the ultimate sophistication",
									"First make it work, then make it beautiful",
									"Perfect is the enemy of good",
									"One commit at a time",
									"Trust the process",
									"Focus and ship",
									"Small steps, big progress",
								}
								table.insert(lines, "")
								table.insert(lines, "  This week: +" .. total_ins .. " -" .. total_del .. " | " .. count .. " commits")
								table.insert(lines, "  " .. quotes[math.random(#quotes)])
								table.insert(lines, "")
								table.insert(lines, "")
							end
						end

						return lines
					end)(),
				},
				project = {
					enable = true,
					limit = 8,
					action = function(path)
						vim.cmd("cd " .. path)
						vim.cmd("edit .")
					end,
				},
				mru = { limit = 10, cwd_only = true },
				shortcut = {
					{ desc = "Harpoon", group = "Label", action = "lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())", key = "h" },
					{ desc = "New", group = "Label", action = "enew", key = "n" },
					{ desc = "Quit", group = "Number", action = "qa", key = "q" },
				},
				footer = (function()
					local fortune = io.popen("fortune -a 2>/dev/null")
					if fortune then
						local q = fortune:read("*a")
						fortune:close()
						if q and q ~= "" then
							local lines = { "", "", "" }
							for line in q:gmatch("[^\n]+") do
								table.insert(lines, line)
							end
							return lines
						end
					end
					local quotes = { "Lets build!", "Happy coding!", "Keep shipping!", "You got this!", "Make it happen!" }
					return { "", "", "", quotes[math.random(#quotes)] }
				end)(),
			},
		},
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme kanagawa-dragon]])
		end,
	},
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				icons_enabled = false,
				-- theme = "codedark",
				theme = "catppuccin",
				globalstatus = true,
			},
			sections = {
        lualine_x = {'filetype'},
				lualine_y = {
					{
						"datetime",
						-- options: default, us, uk, iso, or your own format string ("%H:%M", etc..)
						style = "default",
					},
				},
				lualine_z = { "progress", "location" },
			},
		},
	},
}
