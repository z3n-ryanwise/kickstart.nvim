-- Navigation: telescope + extensions
-- Telescope is a fuzzy finder that can search files, grep, LSP symbols, and more.
-- It's the primary navigation tool — use it instead of a file tree.
--
-- The easiest way to use Telescope is to start by doing something like:
--   :Telescope help_tags
--
-- Two important keymaps to use while in Telescope are:
--   - Insert mode: <c-/>
--   - Normal mode: ?
--
-- This opens a window that shows you all of the keymaps for the current
-- Telescope picker. This is really useful to discover what Telescope can
-- do as well as how to actually do it!

vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',

  -- fzf-native: native fzf sorter for telescope (build step handled by PackChanged hook in init.lua)
  -- If `make` is not available, telescope still works — just without the native sorter.
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',

  'https://github.com/nvim-telescope/telescope-ui-select.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup({
  defaults = {
    -- Show hidden files but still respect .gitignore
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden', -- Include hidden files
      '--glob',
      '!.git/', -- But exclude .git directory
    },
    mappings = {
      i = {
        -- Exit telescope with jk (matches insert mode and shell vi-mode)
        ['jk'] = require('telescope.actions').close,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true, -- Show hidden files in file finder
      find_command = { 'rg', '--files', '--hidden', '--glob', '!.git/' },
    },
  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
  },
})

-- Enable Telescope extensions if they are installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

-- See `:help telescope.builtin`
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>st', builtin.builtin, { desc = '[S]earch [T]elescope pickers' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>ss', builtin.lsp_document_symbols, { desc = '[S]earch Document [S]ymbols' })
vim.keymap.set('n', '<leader>sS', builtin.lsp_dynamic_workspace_symbols, { desc = '[S]earch Workspace [S]ymbols' })

-- Git telescope pickers
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = '[G]it [S]tatus' })
vim.keymap.set('n', '<leader>gh', builtin.git_bcommits, { desc = '[G]it [H]istory (buffer)' })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = '[/] Fuzzily search in current buffer' })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set('n', '<leader>s/', function()
  builtin.live_grep({
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  })
end, { desc = '[S]earch [/] in Open Files' })

-- Shortcut for searching your Neovim configuration files
vim.keymap.set('n', '<leader>sn', function()
  builtin.find_files({ cwd = vim.fn.stdpath('config') })
end, { desc = '[S]earch [N]eovim files' })

-- vim: ts=2 sts=2 sw=2 et
