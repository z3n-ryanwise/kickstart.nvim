-- Neo-tree: file system browser
-- Available with `\` key, but not the primary navigation tool.
-- Use telescope (<leader><leader> and <leader>sg) for file navigation instead.
-- https://github.com/nvim-neo-tree/neo-tree.nvim

vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/MunifTanjim/nui.nvim',
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range('*') },
})

require('neo-tree').setup({
  filesystem = {
    hijack_netrw_behavior = 'disabled', -- Don't open when running 'nvim .'
    filtered_items = {
      visible = true,
    },
    window = {
      mappings = {
        ['\\'] = 'close_window',
      },
    },
  },
})

vim.keymap.set('n', '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })

-- vim: ts=2 sts=2 sw=2 et
