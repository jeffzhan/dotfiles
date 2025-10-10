-- ~/.config/nvim/init.lua
-- basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.g.mapleader = ","

-- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- keymaps you'll actually use
vim.keymap.set("n","<leader>f", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n","<leader>g", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n","<leader>b", "<cmd>Telescope buffers<cr>")
-- quick build/test loop
vim.opt.makeprg = "make"
vim.keymap.set("n","<leader>m", "<cmd>make -j<cr>")
vim.keymap.set("n","]q","<cmd>cnext<cr>")
vim.keymap.set("n","[q","<cmd>cprev<cr>")

-- format C/C++ on save via clang-format
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.c","*.h","*.cpp","*.hpp"},
  callback = function() vim.cmd("%!clang-format") end,
})

