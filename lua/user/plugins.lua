local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Plugin Manager
  use "wbthomason/packer.nvim" -- Have packer manage itself

  -- Lua Development
  use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "ray-x/lsp_signature.nvim"
  use "SmiteshP/nvim-navic"
  use "b0o/SchemaStore.nvim"
  use "RRethy/vim-illuminate"
  use "j-hui/fidget.nvim"
  use "lvimuser/lsp-inlayhints.nvim"
  use { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" }

  -- Completions
  use "hrsh7th/nvim-cmp" -- The complention plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  -- Lua snippets
  use "L3MON4D3/LuaSnip"
  use "rafamadriz/friendly-snippets"

  -- Syntax/Treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use "p00f/nvim-ts-rainbow"
  use "ShooTeX/nvim-treesitter-angular"
  use "windwp/nvim-ts-autotag"
  use {"JoosepAlviste/nvim-ts-context-commentstring", event = "BufRead"}

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-media-files.nvim"

  -- Color
  use "NvChad/nvim-colorizer.lua"

  -- Utility
  use "rcarriga/nvim-notify"
  use "moll/vim-bbye"
  use "lewis6991/impatient.nvim"
  use "stevearc/dressing.nvim"
  -- TODO
  use "ghillb/cybu.nvim"
  -- TODO
  use "lalitmee/browse.nvim"

  -- TODO
  -- Motion
  use { "ggandor/leap.nvim", requires = "tpope/vim-repeat", event = "BufRead" }

  -- Icons
  use "kyazdani42/nvim-web-devicons"

  -- Statusline
  use "nvim-lualine/lualine.nvim"

  -- Startup
  use "goolord/alpha-nvim"

  -- Indent
  use "lukas-reineke/indent-blankline.nvim"

  -- File Explorer
  use "kyazdani42/nvim-tree.lua"

  -- Comment
  use "numToStr/Comment.nvim"
  -- TODO
  use "folke/todo-comments.nvim"

  -- Terminal
  use "akinsho/toggleterm.nvim"

  -- Project
  use "ahmedkhalf/project.nvim"

  -- Tabline
  use "akinsho/bufferline.nvim"

  -- TODO
  -- Quickfix
  use "kevinhwang91/nvim-bqf"

  -- Editing Support
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use { "nacro90/numb.nvim", event = "BufRead" }

  -- Keybinding
  use "folke/which-key.nvim"

  -- Typescript TODO: set this up, also add keybinds to ftplugin
  use "jose-elias-alvarez/typescript.nvim"

  -- Markdown
  -- TODO
  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
  }

  -- Colorscheme
  use "folke/tokyonight.nvim"
  use "lunarvim/onedarker.nvim"
  use "lunarvim/darkplus.nvim"

  -- git
  use "lewis6991/gitsigns.nvim"
  -- TODO
  use "f-person/git-blame.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
