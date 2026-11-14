return {
  --colors utility
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPost",
    config = function()
      require("colorizer").setup {
        filetypes = { "*" }, -- or specifically { "lua", "css", "html", ... }
        user_default_options = {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          names = false, -- "blue" or "red" supported?
          css = true, -- Enable all CSS features: rgb(...), hsl(...)
          mode = "background", -- foreground | background | virtualtext
          tailwind = "both", -- name-based + colors reported by tailwindcss LSP
        },
      }

      --attach colorizer to buffer
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function(args)
          local ok, c = pcall(require, "colorizer")
          if ok then
            c.attach_to_buffer(args.buf)
          end
        end,
      })
    end,
  },
  {
    "nvzone/minty",
    cmd = { "Shades", "Huefy" },
  },
}
