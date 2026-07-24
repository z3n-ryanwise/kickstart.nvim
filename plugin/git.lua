-- Git: gitsigns + gitlinker
-- gitsigns: diff signs in the gutter and blame utilities
-- gitlinker: generate GitHub permalinks for the current line or selection
-- See `:help gitsigns` to understand the configuration keys.

vim.pack.add({
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/ruifm/gitlinker.nvim',
})

require('gitlinker').setup()
vim.keymap.set('n', '<leader>gy', function() require('gitlinker').get_buf_range_url('n') end,
  { desc = '[G]it [Y]ank permalink (copy)' })
vim.keymap.set('v', '<leader>gy', function() require('gitlinker').get_buf_range_url('v') end,
  { silent = false, desc = '[G]it [Y]ank permalink (copy)' })

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
