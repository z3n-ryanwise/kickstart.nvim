-- Keymaps: non-plugin keybindings
-- General keybindings that don't depend on specific plugins.
-- Plugin-specific keymaps live in their respective plugin/*.lua files.
--
-- See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Quickfix and diagnostics keymaps (<leader>q prefix)
--  Quickfix is a global list for search results, build errors, etc.
--  Location list is per-window, used for current file diagnostics
vim.keymap.set('n', '<leader>qq', '<cmd>copen<CR>', { desc = 'Open/focus quickfix (q to close)' })
vim.keymap.set('n', '<leader>qn', '<cmd>cnext<CR>zz', { desc = 'Next quickfix (]q)' })
vim.keymap.set('n', '<leader>qp', '<cmd>cprev<CR>zz', { desc = 'Prev quickfix ([q)' })
vim.keymap.set('n', '<leader>qc', vim.diagnostic.setloclist, { desc = 'Current file diagnostics -> loclist' })
vim.keymap.set('n', '<leader>qa', vim.diagnostic.setqflist, { desc = 'All diagnostics -> quickfix' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Buffer navigation keybinds
--  Use Shift+<hl> to cycle through buffers (like browser tabs)
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<CR>', { desc = 'Go to previous buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>bnext<CR>', { desc = 'Go to next buffer' })

-- Quick escape from insert mode
--  Common Vim community pattern - faster than reaching for ESC
vim.keymap.set('i', 'jk', '<ESC>', { desc = 'Exit insert mode with jk' })
vim.keymap.set('v', 'jk', '<ESC>', { desc = 'Exit visual mode with jk' })

-- Split window shortcuts
--  Leverage ultrawide monitor with easy vertical splits
--  Using <leader>w[indow] prefix for all window/split operations
vim.keymap.set('n', '<leader>wv', '<cmd>vsplit<CR>', { desc = '[W]indow split [V]ertical' })
vim.keymap.set('n', '<leader>wh', '<cmd>split<CR>', { desc = '[W]indow split [H]orizontal' })

-- Enhanced scrolling and search - keep cursor centered
--  Makes it easier to track cursor on large displays
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down half-page (centered)' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up half-page (centered)' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result (centered)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result (centered)' })

-- Lazygit integration
--  Opens lazygit in a floating terminal window
--  Press <leader>gg to launch lazygit for full git workflow
vim.keymap.set('n', '<leader>gg', function()
  -- Create a floating window that takes up most of the screen
  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create a new buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  -- Open lazygit in terminal mode
  vim.fn.termopen('lazygit', {
    on_exit = function()
      vim.api.nvim_buf_delete(buf, { force = true })
    end,
  })

  -- Start in terminal mode
  vim.cmd('startinsert')

  -- Set up keybinding to close lazygit with <Esc>
  vim.api.nvim_buf_set_keymap(buf, 't', '<Esc>', '<cmd>close<CR>', { noremap = true, silent = true })
end, { desc = '[G]it [G]UI (lazygit)' })

-- Markdown link from selection
--  Visual select text, press <leader>ml, enter URL
vim.keymap.set('v', '<leader>ml', function()
  -- Get the visually selected text
  vim.cmd('normal! "xy')
  local selected_text = vim.fn.getreg('x')

  -- Prompt for URL
  local url = vim.fn.input('URL: ')

  if url ~= '' then
    -- Replace selection with markdown link
    local link = string.format('[%s](%s)', selected_text, url)
    vim.fn.setreg('x', link)
    vim.cmd('normal! gv"xp')
  end
end, { desc = 'Markdown link from selection' })

-- Reload Neovim config
--  Quickly reload config from any file
vim.keymap.set('n', '<leader>R', '<cmd>source $MYVIMRC<CR><cmd>echo "Config reloaded!"<CR>', { desc = 'Reload config' })

-- vim: ts=2 sts=2 sw=2 et
