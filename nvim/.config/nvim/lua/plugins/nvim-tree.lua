return {
  --file tree
  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      { "<C-n>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
      { "<leader>e", "<cmd>NvimTreeFocus<CR>", desc = "Focus NvimTree" },
    },
    config = function()
      local nvimtree = require "nvim-tree"

      local opts = {

        disable_netrw = true,
        hijack_cursor = true,
        sync_root_with_cwd = true,

        view = {
          width = 40,
          side = "left",
          preserve_window_proportions = true,
        },
        renderer = {
          root_folder_label = false,
          highlight_git = true,
          indent_markers = { enable = true },
          icons = {
            glyphs = {
              default = "󰈚",
              folder = {
                default = "",
                empty = "",
                empty_open = "",
                open = "",
                symlink = "",
              },
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },
        filters = {
          dotfiles = false,
          git_ignored = false,
          custom = { ".DS_Store", "node_modules", "^\\.git$" },
        },
        update_focused_file = {
          enable = true,
          update_cwd = true,
        },
      }

      nvimtree.setup(opts)
    end,
  },
}
