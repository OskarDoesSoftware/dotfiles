return {
  --linters integration to lsp
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local null_ls = require "null-ls"
      local notify = require("utils").notify

      local phpstan_root_files = {
        "phpstan.neon",
        "phpstan.neon.dist",
        "phpstan.dist.neon",
      }

      local stylelint_root_files = {
        ".stylelintrc",
        ".stylelintrc.json",
        ".stylelintrc.yaml",
        ".stylelintrc.yml",
        ".stylelintrc.js",
        ".stylelintrc.cjs",
        ".stylelintrc.mjs",
        "stylelint.config.js",
        "stylelint.config.cjs",
        "stylelint.config.mjs",
        "stylelint.config.ts",
      }

      null_ls.setup {
        sources = {
          -- JS/TS: linted by the oxlint LSP (see lsp.lua)

          -- CSS / SCSS
          null_ls.builtins.diagnostics.stylelint.with {
            condition = function(utils)
              local ft = vim.bo.filetype
              if ft ~= "css" and ft ~= "scss" then
                return false
              end
              local enabled = utils.root_has_file(stylelint_root_files)
              if not enabled then
                notify("null-ls", "stylelint skipped — no config found", vim.log.levels.WARN)
              end
              return enabled
            end,
          },

          -- YAML
          null_ls.builtins.diagnostics.yamllint.with {
            settings = {
              yaml = {
                schemas = {
                  ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
                    "docker-compose*.yml",
                    "docker-compose*.yaml",
                  },
                },
              },
            },
          },

          --python
          require "none-ls.diagnostics.ruff",

          -- Docker
          null_ls.builtins.diagnostics.hadolint,

          -- PHP
          null_ls.builtins.diagnostics.phpstan.with {
            condition = function(utils)
              if vim.bo.filetype ~= "php" then
                return false
              end
              local enabled = utils.root_has_file(phpstan_root_files)
              if not enabled then
                notify("null-ls", "phpstan skipped — no config found", vim.log.levels.WARN)
              end
              return enabled
            end,
          },

          --shell
          --shellcheck not needed expicite

          --lua
          require("none-ls-luacheck.diagnostics.luacheck").with {
            condition = function(utils)
              if vim.bo.filetype ~= "lua" then
                return false
              end

              local enabled = utils.root_has_file "/nvim/.config/nvim/.luacheckrc" --HACK: workaround the fact the root for this project is .dotfiles

              if not enabled then
                notify("null-ls", "luacheck skipped — no config found", vim.log.levels.WARN)
              end
              return enabled
            end,
            extra_args = function()
              local root = require("null-ls.utils").get_root()
              return { "--config", root .. "/.luacheckrc" }
            end,
            cwd = function()
              return require("null-ls.utils").get_root()
            end,
          },
        },
      }
    end,
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
      "gbprod/none-ls-luacheck.nvim",
    },
  },
}
