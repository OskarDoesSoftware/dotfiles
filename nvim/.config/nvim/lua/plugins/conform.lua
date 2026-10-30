return {
  --Formaters manager
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 3000,
      },
      formatters_by_ft = {
        -- Frontend languages
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
        scss = { "prettierd" },

        -- Scripting languages
        lua = { "stylua" },
        python = { "black" },
        php = { "php_cs_fixer" },

        -- Shell
        sh = { "shfmt" },
        bash = { "shfmt" },

        -- Configs
        xml = { "xmlformatter" },
        json = { "prettierd" },
        json5 = { "prettierd" },
        yaml = { "prettierd" },
        toml = { "taplo" },

        -- Docker (compose files use the yaml.docker-compose filetype)
        ["yaml.docker-compose"] = { "prettierd" },

        -- C/C++
        c = { "clang-format" },
        cpp = { "clang-format" },
      },
      formatters = {
        php_cs_fixer = {
          -- style follows a project ruleset if present, else PSR-12;
          -- --using-cache=no stops the .php-cs-fixer.cache file in the project
          args = function(_, ctx)
            local cfg =
              vim.fs.find({ ".php-cs-fixer.php", ".php-cs-fixer.dist.php" }, { upward = true, path = ctx.dirname })[1]
            local args = { "fix", "--using-cache=no" }
            table.insert(args, cfg and ("--config=" .. cfg) or "--rules=@PSR12")
            table.insert(args, "$FILENAME")
            return args
          end,
          -- don't refuse to run on an unsupported PHP version
          env = { PHP_CS_FIXER_IGNORE_ENV = "1" },
        },
      },
    },
  },
}
