return {
  --lsp integration plugins
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local severity_icons = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.HINT] = "",
        [vim.diagnostic.severity.INFO] = "",
      }

      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      vim.diagnostic.config {
        virtual_text = true,

        signs = {
          text = severity_icons,
        },
        underline = true,
        update_in_insert = true,
        severity_sort = true,
      }

      -- shared defaults applied to every server (nvim 0.11 native API)
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- per-server overrides; servers without overrides are just enabled below
      local overrides = {
        clangd = {
          cmd = { "clangd", "--background-index", "--clang-tidy" },
        }, --c/cpp
        arduino_language_server = {
          cmd = {
            "arduino-language-server",
            "-cli-config",
            vim.fn.expand "~/Library/Arduino15/arduino-cli.yaml",
            "-fqbn",
            "arduino:avr:uno",
            "-cli",
            "arduino-cli",
            "-clangd",
            vim.fn.stdpath "data" .. "/mason/bin/clangd",
          },
        }, --arduino (.ino); fqbn must match lua/arduino.lua
        phpactor = {
          init_options = {
            -- inlay hints (off by default for perf); phpactor has no return-type hints
            ["language_server_worse_reflection.inlay_hints.enable"] = true,
            ["language_server_worse_reflection.inlay_hints.types"] = true, -- variable types
            ["language_server_worse_reflection.inlay_hints.params"] = true, -- param names
            -- diagnostics
            ["language_server_worse_reflection.diagnostics.enable"] = true,
          },
        }, --php
        basedpyright = {
          settings = {
            basedpyright = {
              diagnosticMode = "openFilesOnly",
              inlayHints = {
                variableTypes = true,
                functionReturnTypes = true,
                callArgumentNames = true,
              },
              typeCheckingMode = "basic",
              reportUnknownMemberType = "none",
              reportMissingTypeStubs = "none",
              reportPrivateImportUsage = "none",
              reportUnusedImport = "warning",
              reportUnusedVariable = "information",

              autoImportCompletions = true,
            },
            python = {
              venvPath = ".",
              venv = ".venv",
            },
          },
        }, --python
        angularls = {
          -- only start inside angular projects; never for react .tsx
          root_markers = { "angular.json" },
          workspace_required = true,
          filetypes = { "typescript", "html", "htmlangular" },
        }, --angular
        tailwindcss = {
          settings = {
            tailwindCSS = {
              experimental = {
                -- class completion inside clsx()/cn()/cva()/tw`` helpers
                classRegex = {
                  { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                  { "cn\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                  { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                  "tw`([^`]*)",
                },
              },
            },
          },
        }, --tailwind
      }
      for name, cfg in pairs(overrides) do
        vim.lsp.config(name, cfg)
      end

      vim.lsp.enable {
        "clangd", --c/cpp
        "arduino_language_server", --arduino
        "ts_ls", --JS/TS/TSX and JSX
        "oxlint", --JS/TS linter (needs .oxlintrc.json or oxlint in package.json)
        "angularls", --angular
        "html", --html
        "emmet_language_server", --html/jsx abbreviations
        "tailwindcss", --tailwind classes (only attaches in tailwind projects)
        "lua_ls", --lua
        "cssls", --css/scss
        "lemminx", --xml
        "yamlls", --yaml
        "jsonls", --json
        "taplo", --toml
        "bashls", --shell
        "dockerls", --dockerfile
        "docker_compose_language_service", --docker compose
        "phpactor", --php
        "basedpyright", --python
      }

      -- enable inlay hints once a server that supports them attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
          end
        end,
      })
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup {
        lightbulb = {
          enable = true,
          sign = false,
          virtual_text = true,
        },
      }
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
