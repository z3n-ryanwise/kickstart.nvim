-- Formatting: conform.nvim
-- Provides auto-format on save and manual formatting with <leader>f.
-- Conform automatically finds formatters in:
--   1. node_modules/.bin (for prettier, eslint, etc)
--   2. Project root (for local tool configs)
--   3. System PATH (for globally installed tools)
-- This means project-specific prettier configs are automatically respected!

vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })

require('conform').setup({
  notify_on_error = false,
  format_on_save = function(bufnr)
    -- Disable "format_on_save lsp_fallback" for languages that don't
    -- have a well standardized coding style. You can add additional
    -- languages here or re-enable it for the disabled ones.
    local disable_filetypes = { c = true, cpp = true, ruby = true }
    if disable_filetypes[vim.bo[bufnr].filetype] then
      return nil
    else
      return {
        timeout_ms = 500,
        lsp_format = 'fallback',
      }
    end
  end,
  formatters_by_ft = {
    -- Lua
    lua = { 'stylua' },

    -- JavaScript/TypeScript - prefer project-local prettier
    javascript = { 'prettier', stop_after_first = true },
    javascriptreact = { 'prettier' },
    typescript = { 'prettier' },
    typescriptreact = { 'prettier' },

    -- Web
    html = { 'prettier' },
    css = { 'prettier' },
    scss = { 'prettier' },
    json = { 'prettier' },
    jsonc = { 'prettier' },
    yaml = { 'prettier' },
    markdown = { 'prettier' },

    -- Python - runs isort then black
    python = { 'isort', 'black' },

    -- Go
    go = { 'gofmt', 'goimports' },

    -- Rust
    rust = { 'rustfmt' },

    -- Ruby
    ruby = { 'rubocop' },

    -- Shell
    sh = { 'shfmt' },
    bash = { 'shfmt' },

    -- Use LSP fallback for anything not listed above
  },
})

vim.keymap.set('', '<leader>f', function()
  require('conform').format({ async = true, lsp_format = 'fallback' })
end, { desc = '[F]ormat buffer' })

-- vim: ts=2 sts=2 sw=2 et
