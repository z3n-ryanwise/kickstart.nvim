-- Treesitter: syntax highlighting, indentation, and code parsing
-- Treesitter provides much better syntax highlighting than regex-based approaches.
-- It builds a parse tree of your code, enabling accurate highlighting and text objects.
--
-- The build step (:TSUpdate) is handled by the PackChanged hook in init.lua.
-- See `:help nvim-treesitter`
--
-- There are additional nvim-treesitter modules that you can use to interact
-- with nvim-treesitter. You should go explore a few and see what interests you:
--
--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects

vim.pack.add({
  'https://github.com/nvim-treesitter/nvim-treesitter',
})

require('nvim-treesitter.config').setup({
  ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
  -- Autoinstall languages that are not installed
  auto_install = true,
  highlight = {
    enable = true,
    -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
    --  If you are experiencing weird indenting issues, add the language to
    --  the list of additional_vim_regex_highlighting and disabled languages for indent.
    additional_vim_regex_highlighting = { 'ruby' },
  },
  indent = { enable = true, disable = { 'ruby' } },
})

-- vim: ts=2 sts=2 sw=2 et
