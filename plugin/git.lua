-- Git: gitsigns
-- Adds git diff signs to the gutter (+, ~, _) and utilities for managing changes.
-- See `:help gitsigns` to understand the configuration keys.

vim.pack.add({ 'https://github.com/lewis6991/gitsigns.nvim' })

require('gitsigns').setup({
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  current_line_blame = false, -- Off by default, toggle with <leader>gb
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    -- Toggle inline blame (shows author, date, commit message at end of line)
    vim.keymap.set('n', '<leader>gb', gitsigns.toggle_current_line_blame,
      { buffer = bufnr, desc = '[G]it [B]lame toggle' })
  end,
})

-- vim: ts=2 sts=2 sw=2 et
