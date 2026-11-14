return {
  --auto close and auto rename html/jsx tags
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  --wrap/change/delete surroundings, incl. tags: ysiwt, cst, dst, visual S
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  --treesitter-aware commentstring ({/* */} inside jsx markup)
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },
  --wrap selection with an emmet abbreviation (uses emmet_language_server)
  {
    "olrtg/nvim-emmet",
    lazy = true,
  },
}
