-- ~/.config/nvim/lua/plugins/core.lua
return {
  -- Telescope (fuzzy finder)
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope.nvim", branch = "0.1.x" },

  -- Treesitter (better syntax)
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- LSP for C/C++ (clangd)
{ "neovim/nvim-lspconfig",
  config = function()
    -- LSP keymaps (same as before)
    vim.keymap.set("n","gd", vim.lsp.buf.definition)
    vim.keymap.set("n","gr", vim.lsp.buf.references)
    vim.keymap.set("n","K",  vim.lsp.buf.hover)
    vim.keymap.set("n","<leader>rn", vim.lsp.buf.rename)
    vim.keymap.set("n","<leader>e", function() vim.diagnostic.open_float(nil,{focus=false}) end)
    vim.keymap.set("n","[d", vim.diagnostic.goto_prev)
    vim.keymap.set("n","]d", vim.diagnostic.goto_next)

    -- Prefer native API on Neovim 0.11+
    if vim.lsp and vim.lsp.config then
      -- Configure clangd (you can pass options in this table)
      vim.lsp.config('clangd', {
        cmd = { 'clangd' },
        -- root_dir = vim.fs.root(0, {'.git','compile_commands.json'}),
        -- capabilities = ...,
        -- on_attach = function(client, bufnr) ... end,
      })
      -- Enable it (starts/attaches by filetype)
      vim.lsp.enable('clangd')
    else
      -- Back-compat (0.10 and earlier)
      require('lspconfig').clangd.setup({})
    end
  end
},

  -- Git gutter + Git commands
  { "lewis6991/gitsigns.nvim", config = true },
  { "tpope/vim-fugitive" },

  -- Editing QoL
  { "tpope/vim-commentary" },  -- gc to comment
  { "tpope/vim-surround" },    -- cs, ds, ys
  { "windwp/nvim-autopairs", config = true },

  -- Move seamlessly between tmux panes & nvim splits
  { "christoomey/vim-tmux-navigator" },
}

