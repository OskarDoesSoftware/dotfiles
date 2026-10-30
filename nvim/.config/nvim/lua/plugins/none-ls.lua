return {
  --linters integration to lsp
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local null_ls = require "null-ls"
      local notify = require("utils").notify

      local eslint_root_files = {
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.json",
        ".eslintrc.cjs",
        ".eslintrc.yaml",
        ".eslintrc.yml",
        "eslint.config.js",
        "eslint.config.mjs",
        "eslint.config.cjs",
      }

      local js_langs = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
      }

      local phpstan_root_files = {
        "phpstan.neon",
        "phpstan.neon.dist",
        "phpstan.dist.neon",
      }

      null_ls.setup {
        sources = {
          -- JS/TS
          require("none-ls.diagnostics.eslint_d").with {
            condition = function(utils)
              if not vim.tbl_contains(js_langs, vim.bo.filetype) then
                return false
              end
              local enabled = utils.root_has_file(eslint_root_files)
              if not enabled then
                notify("null-ls", "ESLint skipped — no config found", vim.log.levels.WARN)
              end
              return enabled
            end,
          },
          require("none-ls.code_actions.eslint_d").with {
            condition = function(utils)
              if not vim.tbl_contains(js_langs, vim.bo.filetype) then
                return false
              end
              local enabled = utils.root_has_file(eslint_root_files)
              if not enabled then
                notify("null-ls", "ESLint code actions skipped", vim.log.levels.WARN)
              end
              return enabled
            end,
          },

          -- CSS / SCSS
          -- null_ls.builtins.diagnostics.stylelint,

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
