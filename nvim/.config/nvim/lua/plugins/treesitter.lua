return {
  --Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",

    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",

    config = function()
      require("nvim-treesitter.configs").setup {
        highlight = {
          enable = true,
          use_languagetree = true,
          additional_vim_regex_highlighting = false,
        },

        auto_install = true,
        indent = { enable = true },
        ensure_installed = {
          --web dev languages
          "javascript",
          "typescript",
          "tsx",

          --templates
          "html",
          "angular",

          --styles
          "css",
          "scss",

          --database
          "sql",

          --config files
          "xml",
          "yaml",
          "json",
          "json5",
          "toml",
          "gitignore",
          "editorconfig",
          "ini",
          "dockerfile",

          --scripting languages
          "python",
          "lua",
          "php",
          "phpdoc",

          --Shell
          "bash",

          --c/c++
          "c",
          "cpp",
        },
      }
    end,
  },
}
