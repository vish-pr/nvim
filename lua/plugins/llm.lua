-- return {
--   "olimorris/codecompanion.nvim",
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "nvim-treesitter/nvim-treesitter",
--   },
--   opts = {
--     adapters = {
--       vish = function()
--         return require("codecompanion.adapters").extend("openai_compatible", {
--           env = {
--             url = "http://127.0.0.1:8000",
--             model = "schema.model.default",
--             api_key = nil,
--           },
--           schema = {
--             model = {
--               order = 1,
--               mapping = "parameters",
--               type = "enum",
--               desc = "ID of the model to use. See the model endpoint compatibility table for details on which models work with the Chat API.",
--               ---@type string|fun(): string
--               default = "default",
--               choices = {
--                 "default",
--               },
--             },
--           },
--         })
--       end,
--     },
--     strategies = {
--       chat = {
--         adapter = "vish",
--       },
--     },
--   },
-- }
return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false,
	opts = {
    provider = "gemini",
    providers = {
      groq = { -- define groq provider
        __inherited_from = 'openai',
        api_key_name = 'GROQ_API_KEY',
        endpoint = 'https://api.groq.com/openai/v1/',
        model = 'llama-3.3-70b-versatile',
        extra_request_body = {
          temperature = 1,
          max_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
        },
      },
    },
    windows = {
      position = "left",
    },

  },
-- 		provider = "was",
-- 		-- auto_suggestions_provider = "copilot",
-- 		-- behaviour = {
-- 		--   auto_suggestions = true,
-- 		-- },
-- 		vendors = {
-- 			vish = {
-- 				__inherited_from = "openai",
-- 				endpoint = "http://localhost:8080/v1", -- The full endpoint of the provider
-- 				api_key_name = "",
-- 				model = "Qwen/Qwen2.5-7B-Instruct-AWQ",
-- 			},
-- 			was = {
-- 				--- This function below will be used to parse in cURL arguments.
-- 				--- It takes in the provider options as the first argument, followed by code_opts retrieved from given buffer.
-- 				--- This code_opts include:
-- 				--- - question: Input from the users
-- 				--- - code_lang: the language of given code buffer
-- 				--- - code_content: content of code buffer
-- 				--- - selected_code_content: (optional) If given code content is selected in visual mode as context.
-- 				---@type fun(opts: AvanteProvider, code_opts: AvantePromptOptions): AvanteCurlOutput
-- 				parse_curl_args = function(opts, code_opts)
-- 					return {
-- 						url = "http://localhost:8000/chat",
-- 						method = "POST",
-- 						headers = {
-- 							["Content-Type"] = "application/json",
-- 						},
-- 						body = code_opts,
-- 					}
-- 				end,
-- 				--- This function will be used to parse incoming SSE stream
-- 				--- It takes in the data stream as the first argument, followed by SSE event state, and opts
-- 				--- retrieved from given buffer.
-- 				--- This opts include:
-- 				--- - on_chunk: (fun(chunk: string): any) this is invoked on parsing correct delta chunk
-- 				--- - on_complete: (fun(err: string|nil): any) this is invoked on either complete call or error chunk
-- 				---@type fun(data_stream: string, event_state: string, opts: ResponseParser): nil
-- 				--        parse_response = function(data_stream, event_state, opts)
-- 				--          opts.on_chunk('vanana')
-- 				--          opts.on_complete()
-- 				--         vim.pretty_print('in response')
-- 				--        print(data_stream)
-- 				--          if data_stream == "" then
-- 				--            return
-- 				--          end
-- 				--
-- 				--          local success, decoded = pcall(vim.json.decode, data_stream)
-- 				--          opts.on_complete()
-- 				--          if success then
-- 				--          elseif decoded and decoded.error then
-- 				--            opts.on_complete(decoded.error.message)
-- 				--          end
-- 				--          return
-- 				--       end,
-- 				--- The following function SHOULD only be used when providers doesn't follow SSE spec [ADVANCED]
-- 				--- this is mutually exclusive with parse_response_data
-- 				---@type fun(data: string, handler_opts: AvanteHandlerOptions): nil
-- 				parse_stream_data = function(data, handler_opts)
-- 					print("vish", data)
-- 					if data then
-- 						handler_opts.on_chunk(data .. "\n")
-- 					else
-- 						handler_opts.on_complete(nil)
-- 					end
-- 				end,
-- 			},
-- 			-- -@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
-- 			--    provider = "claude_small",                        -- Recommend using Claude
-- 			-- auto_suggestions_provider = "claude", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
-- 			--     claude = {
-- 			--       endpoint = "https://api.anthropic.com",
-- 			--       model = "claude-3-5-sonnet-20241022",
-- 			--       temperature = 0,
-- 			--       max_tokens = 4096,
-- 			--     },
-- 			-- --    claude_small = {
-- 			-- --      endpoint = "https://api.anthropic.com",
-- 			-- --      model = "claude-3-5-haiku-20241022",
-- 			-- --      temperature = 0,
-- 			-- --      max_tokens = 2096,
-- 			-- --    },
-- 		},
-- 	},
-- 	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
    dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    -- "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
