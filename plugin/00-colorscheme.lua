-- Colorscheme: tokyonight
-- Loaded first (00- prefix) so highlight groups are available to all other plugins.
--
-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
-- This theme has different styles: 'tokyonight-storm', 'tokyonight-moon', 'tokyonight-day'.

vim.pack.add({ 'https://github.com/folke/tokyonight.nvim' })

---@diagnostic disable-next-line: missing-fields
require('tokyonight').setup({
  styles = {
    comments = { italic = false }, -- Disable italics in comments
  },
})

vim.cmd.colorscheme('tokyonight-night')

-- vim: ts=2 sts=2 sw=2 et
