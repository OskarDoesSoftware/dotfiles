local map = vim.keymap.set

--tabs
map("n", "<Tab>", "<Cmd>BufferNext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>", { desc = "Previous buffer" })
map("n", "<C-x>", "<Cmd>BufferClose<CR>", { desc = "Close buffer" })

--lsp
map("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "LSP Hover (Saga)" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename (Telescope UI if dressing.nvim)" })

map({ "n" }, "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "Code Action (Telescope)" })

map("n", "<leader>gd", "<cmd>Lspsaga goto_definition<CR>", { desc = "Goto Definition (Saga)" })
map("n", "pd", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek Definition" })

map("n", "<leader>gr", "<cmd>Lspsaga finder<CR>", { desc = "LSP Finder (Defs/Refs/Impls)" })

map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Prev Diagnostic" })
map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Next Diagnostic" })

map("n", "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "Line Diagnostics" })
map("n", "<leader>tb", "<cmd>Lspsaga show_buf_diagnostics<CR>", { desc = "Buffer Diagnostics" })
map("n", "<leader>wd", "<cmd>Telescope diagnostics<cr>", { desc = "Telescope Diagnostics" })
map("n", "<leader>fd", function()
  require("telescope.builtin").diagnostics { bufnr = 0 }
end, { desc = "Telescope Diagnostics (Current File)" })

map("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>", { desc = "Incoming Calls" })
map("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>", { desc = "Outgoing Calls" })

map("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { desc = "Toggle Symbols Outline" })

map("n", "<leader>sb", "<cmd>Telescope dap list_breakpoints<CR>", {
  desc = "Show DAP breakpoints",
})
--debugger

map("n", "<Leader>db", function() require("dap").toggle_breakpoint() end, { desc = "DAP Toggle Breakpoint" })
map("n", "<Leader>dc", function() require("dap").continue() end, { desc = "DAP Continue" })
map("n", "<Leader>do", function() require("dap").step_over() end, { desc = "DAP Step Over" })
map("n", "<Leader>di", function() require("dap").step_into() end, { desc = "DAP Step Into" })
map("n", "<Leader>dO", function() require("dap").step_out() end, { desc = "DAP Step Out" })
map("n", "<Leader>dr", function() require("dap").repl.toggle() end, { desc = "DAP Toggle REPL" })
map("n", "<Leader>du", function() require("dapui").toggle() end, { desc = "DAP UI Toggle" })

-- spell checker
map("n", "<leader>ss", function()
  require("telescope.builtin").spell_suggest(require("telescope.themes").get_dropdown {})
end, { desc = "Telescope Spell Suggest" })

--Noice
map("n", "<C-\\>", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice messages", silent = true })

--Minty
map("n", "<Leader>sh", "<cmd>Shades<CR>", { desc = "Minty Shades" })
map("n", "<Leader>hu", "<cmd>Huefy<CR>", { desc = "Minty Huefy" })

--Emmet (expand in insert mode is <C-y>, see cmp.lua)
map({ "n", "v" }, "<leader>we", function()
  require("nvim-emmet").wrap_with_abbreviation()
end, { desc = "Emmet: wrap with abbreviation" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- telescope
map("n", "<leader>td", "<cmd>TodoTelescope<CR>", { desc = "Search TODOs (Telescope)" })

map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", {
  noremap = true,
  silent = true,
  desc = "Find Files (Telescope)",
})
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>pt", "<cmd>TermSelect<CR>", { desc = "pick terminal" })

-- terminal (toggleterm)
map({ "n", "t" }, "<C-/>", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
map("n", "<leader>Tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Terminal: float" })
map("n", "<leader>Th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Terminal: horizontal" })
map("n", "<leader>Tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Terminal: vertical" })
map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "Terminal: window left" })
map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "Terminal: window down" })
map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "Terminal: window up" })
map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "Terminal: window right" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

-- AI completion (minuet-ai.nvim, local Ollama)
map("n", "<leader>cpt", "<cmd>Minuet virtualtext toggle<CR>", { desc = "AI completion: Toggle" })
map("n", "<leader>cpe", "<cmd>Minuet virtualtext enable<CR>", { desc = "AI completion: Enable" })
map("n", "<leader>cpd", "<cmd>Minuet virtualtext disable<CR>", { desc = "AI completion: Disable" })

--neotest
map("n", "<leader>tn", function()
  require("neotest").run.run()
end, { desc = "Run nearest test" })

map("n", "<leader>tf", function()
  require("neotest").run.run(vim.fn.expand "%")
end, { desc = "Run test file" })

map("n", "<leader>ts", function()
  require("neotest").summary.toggle()
end, { desc = "Toggle test summary" })
map("n", "<leader>to", function()
  require("neotest").output.open()
end, { desc = "Open test output" })
map("n", "<leader>dt", function()
  require("neotest").run.run { strategy = "dap" }
end, { desc = "Debug nearest test" })

-- gitsigns (hunks)
map("n", "]h", function()
  require("gitsigns").nav_hunk "next"
end, { desc = "Next git hunk" })
map("n", "[h", function()
  require("gitsigns").nav_hunk "prev"
end, { desc = "Prev git hunk" })
map("n", "<leader>hs", function()
  require("gitsigns").stage_hunk()
end, { desc = "Stage hunk" })
map("v", "<leader>hs", function()
  require("gitsigns").stage_hunk { vim.fn.line ".", vim.fn.line "v" }
end, { desc = "Stage hunk" })
map("n", "<leader>hr", function()
  require("gitsigns").reset_hunk()
end, { desc = "Reset hunk" })
map("v", "<leader>hr", function()
  require("gitsigns").reset_hunk { vim.fn.line ".", vim.fn.line "v" }
end, { desc = "Reset hunk" })
map("n", "<leader>hp", function()
  require("gitsigns").preview_hunk()
end, { desc = "Preview hunk" })
map("n", "<leader>hb", function()
  require("gitsigns").blame_line { full = true }
end, { desc = "Blame line" })
