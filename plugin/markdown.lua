-- Markdown: preview and inline rendering
-- markdown-preview:  Opens a live preview in your browser (GitHub-flavored)
-- render-markdown:   Renders markdown inline in the Neovim buffer

vim.pack.add({
  -- Dependencies for render-markdown (duplicate add()s are no-ops if already loaded)
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/echasnovski/mini.nvim',

  -- markdown-preview: browser preview (build step handled by PackChanged hook in init.lua)
  'https://github.com/iamcco/markdown-preview.nvim',

  -- render-markdown: inline rendering in Neovim buffer
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
})

vim.g.mkdp_filetypes = { 'markdown' }

require('render-markdown').setup({
  enabled = false, -- Start disabled, toggle on with <leader>mr
})

vim.keymap.set('n', '<leader>mp', '<cmd>MarkdownPreview<cr>', { desc = 'Markdown Preview (browser)' })
vim.keymap.set('n', '<leader>ms', '<cmd>MarkdownPreviewStop<cr>', { desc = 'Markdown Preview Stop' })
vim.keymap.set('n', '<leader>mr', '<cmd>RenderMarkdown toggle<cr>', { desc = 'Markdown Render (inline)' })

-- vim: ts=2 sts=2 sw=2 et
