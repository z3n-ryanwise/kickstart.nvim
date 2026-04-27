-- init.lua — Settings, options, and global autocommands only.
--
-- Plugins live in plugin/*.lua files, which Neovim auto-sources
-- alphabetically during startup. This file runs BEFORE any of them.
--
-- Structure:
--   init.lua           <- You are here (settings, options, hooks)
--   plugin/*.lua       <- Auto-sourced alphabetically by Neovim
--   nvim-pack-lock.json <- Plugin lockfile (committed to version control)
--
-- To test this config without affecting your main one:
--   NVIM_APPNAME=nvim-new nvim

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Disable netrw (built-in file browser) - use telescope instead
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- [[ Setting options ]]
-- See `:help vim.o`
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Increase command line height for better visibility on large displays
vim.opt.cmdheight = 2

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Plugin build hooks ]]
-- These must be defined BEFORE any vim.pack.add() call (which happens in plugin/*.lua).
-- When bootstrapping on a new machine, the very first add() installs everything
-- from the lockfile at once — so hooks need to already exist to catch those installs.
-- See `:help PackChanged`
vim.api.nvim_create_autocmd('PackChanged', {
  desc = 'Build hooks for plugins that need post-install/update steps',
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind == 'install' or kind == 'update' then
      if name == 'telescope-fzf-native.nvim' then
        vim.system({ 'make' }, { cwd = ev.data.path })
      elseif name == 'LuaSnip' then
        if vim.fn.executable('make') == 1 then
          vim.system({ 'make', 'install_jsregexp' }, { cwd = ev.data.path })
        end
      elseif name == 'markdown-preview.nvim' then
        vim.system({ 'npm', 'install' }, { cwd = ev.data.path .. '/app' })
      elseif name == 'nvim-treesitter' then
        if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
        vim.cmd('TSUpdate')
      end
    end
  end,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
