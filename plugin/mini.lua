-- Mini.nvim: collection of small independent plugins/modules
-- mini.ai:         Better Around/Inside textobjects
-- mini.surround:   Add/delete/replace surroundings (brackets, quotes, etc.)
-- mini.statusline: Simple and easy statusline
--
-- Check out the full collection: https://github.com/echasnovski/mini.nvim

vim.pack.add({ 'https://github.com/echasnovski/mini.nvim' })

-- Better Around/Inside textobjects
--
-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
require('mini.ai').setup({ n_lines = 500 })

-- Add/delete/replace surroundings (brackets, quotes, etc.)
--
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
require('mini.surround').setup()

-- Simple and easy statusline.
local statusline = require('mini.statusline')

-- Dynamic filename: shows more path segments when the window is wide enough
local function smart_filename()
  local path = vim.fn.expand('%:p')
  if path == '' then
    return '[No Name]'
  end

  local modified = vim.bo.modified and ' [+]' or ''
  local width = vim.api.nvim_win_get_width(0)

  if width >= 120 then
    -- Relative path from cwd
    return vim.fn.fnamemodify(path, ':~:.') .. modified
  else
    -- parent/file.ext
    local parent = vim.fn.fnamemodify(path, ':h:t')
    local file = vim.fn.fnamemodify(path, ':t')
    return parent .. '/' .. file .. modified
  end
end

statusline.setup({
  use_icons = vim.g.have_nerd_font,
  content = {
    active = function()
      local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
      local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
      local location = '%2l:%-2v'

      return statusline.combine_groups({
        { hl = mode_hl, strings = { mode } },
        { hl = 'MiniStatuslineDevinfo', strings = { diagnostics } },
        '%<',
        { hl = 'MiniStatuslineFilename', strings = { smart_filename() } },
        '%=',
        { hl = mode_hl, strings = { location } },
      })
    end,
    inactive = function()
      return statusline.combine_groups({
        { hl = 'MiniStatuslineFilename', strings = { smart_filename() } },
      })
    end,
  },
})

-- vim: ts=2 sts=2 sw=2 et
