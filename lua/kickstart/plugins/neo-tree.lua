-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
--
-- Layout: file tree on the left, file content on the right.
-- The tree opens automatically on startup and follows the current file.

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>e', ':Neotree toggle<CR>', desc = 'Toggle file [E]xplorer', silent = true },
    { '<leader>ge', ':Neotree float git_status<CR>', desc = '[G]it status [E]xplorer', silent = true },
  },
  opts = {
    close_if_last_window = true, -- quit nvim if the tree is the only window left
    popup_border_style = 'rounded',
    window = {
      position = 'left',
      width = 32,
    },
    filesystem = {
      follow_current_file = { enabled = true }, -- highlight the file shown in the right pane
      use_libuv_file_watcher = true, -- auto-refresh on external changes
      hijack_netrw_behavior = 'disabled', -- `nvim .` shows the tree on the left, not full-screen
      filtered_items = {
        visible = true, -- show hidden files, dimmed
        hide_dotfiles = false,
        hide_gitignored = false,
        never_show = { '.DS_Store', '__pycache__', '.mypy_cache', '.pytest_cache', '.ruff_cache' },
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Open the tree on startup on the left, keeping the cursor in the file pane on the right.
    vim.api.nvim_create_autocmd('VimEnter', {
      group = vim.api.nvim_create_augroup('neotree-autoopen', { clear = true }),
      callback = function()
        local arg = vim.fn.argv(0)
        if vim.fn.argc() == 1 and vim.fn.isdirectory(arg) == 1 then
          -- `nvim some/dir`: make it the working directory and drop the directory buffer
          local dir_buf = vim.api.nvim_get_current_buf()
          vim.cmd.cd(arg)
          vim.cmd.enew()
          pcall(vim.api.nvim_buf_delete, dir_buf, { force = true })
        end
        vim.cmd 'Neotree show left'
      end,
    })
  end,
}
