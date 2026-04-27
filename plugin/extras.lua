-- Extras: small independent plugins
-- guess-indent:        Detect tabstop and shiftwidth automatically
-- todo-comments:       Highlight TODO, NOTE, WARN, etc. in comments
-- Comment.nvim:        Toggle comments with <leader>c
-- quickfix-reflector:  Makes the quickfix buffer editable (dd to delete entries, :w to save)

vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/NMAC427/guess-indent.nvim',
  'https://github.com/folke/todo-comments.nvim',
  'https://github.com/numToStr/Comment.nvim',
  'https://github.com/stefandtw/quickfix-reflector.vim',
})

require('guess-indent').setup({})

require('todo-comments').setup({ signs = false })

require('Comment').setup()
local comment = require('Comment.api')
vim.keymap.set('n', '<leader>c', function()
  comment.toggle.linewise.current()
end, { desc = 'Toggle comment line' })
vim.keymap.set('x', '<leader>c', function()
  comment.toggle.linewise(vim.fn.visualmode())
end, { desc = 'Toggle comment lines' })

-- Delete quickfix entries without yanking (requires quickfix-reflector plugin)
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    vim.keymap.set('n', 'dd', '"_dd', { buffer = true, desc = 'Delete entry without yanking' })
  end,
})

-- vim: ts=2 sts=2 sw=2 et
