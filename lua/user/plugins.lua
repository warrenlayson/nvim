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

  use "lewis6991/impatient.nvim"

  -- Lua Development
  use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins

  -- LSP
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require "user.lsp"
    end,
    requires = {
      { "b0o/SchemaStore.nvim" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "user.lsp.null-ls"
        end,
        after = "nvim-lspconfig",
      },
      {
        "ray-x/lsp_signature.nvim",
        config = function()
          require "user.lsp.lsp-signature"
        end,
        after = "nvim-lspconfig",
      },
      { "tamago324/nlsp-settings.nvim" },
      { "jose-elias-alvarez/typescript.nvim" },
      { "folke/lua-dev.nvim" },
      {
        "SmiteshP/nvim-navic",
        config = function()
          require "user.navic"
        end,
      },
      { "RRethy/vim-illuminate" },
      {
        "j-hui/fidget.nvim",
        config = function()
          require "user.fidget"
        end,
      },
      {
        "lvimuser/lsp-inlayhints.nvim",
        config = function()
          require "user.lsp_inlayhints"
        end,
      },
      { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
    },
    event = "BufWinEnter",
  }

  -- LSP

  -- Completions
  use {
    "hrsh7th/nvim-cmp", -- The complention plugins
    config = function()
      require "user.cmp"
    end,
    requires = {
      {
        "L3MON4D3/LuaSnip",
        requires = {
          "rafamadriz/friendly-snippets",
        },
      },
      { "hrsh7th/cmp-buffer", after = "nvim-cmp" }, -- buffer completions
      { "hrsh7th/cmp-path", after = "nvim-cmp" }, -- path completions
      { "hrsh7th/cmp-cmdline", after = "nvim-cmp" }, -- cmdline completions
      { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
      { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
      -- Lua snippiets
      {
        "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
        config = function()
          return require "user.autopairs"
        end,
        after = "nvim-cmp",
      },
    },
    event = "InsertEnter",
  }

  -- Syntax/Treesitter
  --
  use {
    "nvim-treesitter/nvim-treesitter",
    requires = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "p00f/nvim-ts-rainbow" },
      { "ShooTeX/nvim-treesitter-angular" },
      { "windwp/nvim-ts-autotag" },
      { "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPost" },
    },
    config = function()
      require "user.treesitter"
    end,
    run = ":TSUpdate",
  }

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-media-files.nvim",
      },
    },
    config = function()
      require "user.telescope"
    end,
    event = "BufWinEnter",
  }

  -- Color
  use {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require "user.colorizer"
    end,
    cmd = { "ColorizerToggle" },
  }

  -- Utility
  use {
    "rcarriga/nvim-notify",
    config = function()
      require "user.notify"
    end,
    -- after = "darkplus",
  }

  use "moll/vim-bbye"

  use {
    "stevearc/dressing.nvim",
    config = function()
      require "user.dressing"
    end,
  }

  -- TODO
  use {"ghillb/cybu.nvim", disable = true}
  -- TODO
  use {"lalitmee/browse.nvim", disable = true}

  -- TODO
  -- Motion
  use { "ggandor/leap.nvim", requires = "tpope/vim-repeat", event = "BufRead", disable = true }

  -- Icons
  use {
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
    config = function()
      require "user.webdevicons"
    end,
  }

  -- Statusline
  use {
    "nvim-lualine/lualine.nvim",
    config = function()
      require "user.lualine"
    end,
    -- after = "darkplus"
  }

  -- Startup
  use {
    "goolord/alpha-nvim",
    config = function()
      require "user.alpha"
    end,
  }

  -- Indent
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require "user.indentline"
    end,
    event = "BufReadPre",
  }

  -- File Explorer
  use {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require "user.nvim-tree"
    end,
    cmd = {
      "NvimTreeClipboard",
      "NvimTreeClose",
      "NvimTreeFindFile",
      "NvimTreeOpen",
      "NvimTreeRefresh",
      "NvimTreeToggle",
    },
    event = "VimEnter",
  }
  use {
    "tamago324/lir.nvim",
    disable = true,
    config = function()
      require "user.lir"
    end,
  }

  -- Comment
  use {
    "numToStr/Comment.nvim",
    config = function()
      require "user.comment"
    end,
    event = "BufWinEnter",
  }

  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require "user.todo_comments"
    end,
    event = "BufWinEnter",
  }

  -- Terminal
  use {
    "akinsho/toggleterm.nvim",
    tag = "v2.*",
    event = "BufWinEnter",
    config = function()
      require "user.toggleterm"
    end,
  }

  -- Project
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require "user.project"
    end,
  }

  -- Tabline
  use {
    "akinsho/bufferline.nvim",
    tag = "v2.*",
    config = function()
      require "user.bufferline"
    end,
    event = "BufWinEnter",
  }

  -- TODO
  -- Quickfix
  use { "kevinhwang91/nvim-bqf", disable = true }

  -- Editing Support
  use { "nacro90/numb.nvim", event = "BufRead", disable = true }

  -- Keybinding
  use {
    "folke/which-key.nvim",
    config = function()
      require "user.whichkey"
    end,
    event = "BufWinEnter",
  }

  -- Markdown
  -- TODO
  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
  }

  -- Colorscheme
  use "lunarvim/darkplus.nvim"

  -- git
  use {
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    event = "BufWinEnter",
    config = function()
      require "user.gitsigns"
    end,
  }
  use { "f-person/git-blame.nvim", disable = true }

  -- Sessions
  use {
    "rmagatti/auto-session",
    config = function()
      require "user.auto-session"
    end,
  }

  -- Remote development
  use {
    "chipsenkbeil/distant.nvim",
    config = function()
      require "user.distant"
    end,
  }
  use { "jamestthompson3/nvim-remote-containers", disable = true }

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
