-- Personal additions on top of kickstart.nvim
return {
  -- Buffer tabs across the top of the right pane: work with many open files at once
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = 'VimEnter',
    keys = {
      { '<S-l>', '<cmd>BufferLineCycleNext<CR>', desc = 'Next buffer' },
      { '<S-h>', '<cmd>BufferLineCyclePrev<CR>', desc = 'Previous buffer' },
      { '<leader>bp', '<cmd>BufferLinePick<CR>', desc = '[B]uffer [P]ick' },
      { '<leader>bo', '<cmd>BufferLineCloseOthers<CR>', desc = '[B]uffer close [O]thers' },
      -- mini.bufremove keeps the right pane open (plain :bdelete would close it, leaving only the tree)
      { '<leader>bd', function() require('mini.bufremove').delete(0, false) end, desc = '[B]uffer [D]elete' },
    },
    opts = {
      options = {
        diagnostics = 'nvim_lsp',
        close_command = function(n) require('mini.bufremove').delete(n, false) end,
        always_show_bufferline = true,
        offsets = {
          { filetype = 'neo-tree', text = 'Explorer', highlight = 'Directory', text_align = 'left', separator = true },
        },
      },
    },
  },

  -- LazyGit inside nvim: full Git UI (stage, commit, branch, rebase, push)
  {
    'kdheepak/lazygit.nvim',
    cmd = { 'LazyGit', 'LazyGitCurrentFile', 'LazyGitFilter' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<CR>', desc = 'Lazy[G]it' },
      { '<leader>gl', '<cmd>LazyGitFilter<CR>', desc = '[G]it [L]og (repo)' },
    },
  },

  -- Side-by-side diffs and file history
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<CR>', desc = '[G]it [D]iff view' },
      { '<leader>gD', '<cmd>DiffviewClose<CR>', desc = '[G]it [D]iff close' },
      { '<leader>gf', '<cmd>DiffviewFileHistory %<CR>', desc = '[G]it [F]ile history' },
    },
  },

  -- Pick the Python virtualenv / conda env used by the LSP
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim' },
    ft = 'python',
    keys = { { '<leader>pv', '<cmd>VenvSelect<CR>', desc = '[P]ython select [V]env' } },
    opts = {},
  },

  -- Sticky header showing the current class/function while scrolling
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'BufReadPost',
    opts = { max_lines = 3 },
  },
}
