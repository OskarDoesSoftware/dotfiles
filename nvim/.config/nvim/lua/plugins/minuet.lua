-- Copilot-like inline completion backed by a local Ollama model (FIM).
-- Requires: `ollama pull qwen2.5-coder:3b` and Ollama running on :11434.
return {
  "milanglacier/minuet-ai.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "InsertEnter",
  opts = {
    provider = "openai_fim_compatible",
    n_completions = 1,
    context_window = 4096,
    request_timeout = 3,
    throttle = 500,
    debounce = 300,
    provider_options = {
      openai_fim_compatible = {
        api_key = "TERM", -- any non-empty env var; Ollama ignores it
        name = "Ollama",
        end_point = "http://localhost:11434/v1/completions",
        model = "qwen2.5-coder:3b",
        optional = { max_tokens = 64, top_p = 0.9 },
      },
    },
    virtualtext = {
      auto_trigger_ft = { "*" },
      keymap = {
        accept = "<C-a>",
        accept_line = "<C-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
    },
  },
}
