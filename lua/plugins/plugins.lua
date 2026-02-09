return {
  -- the colorscheme should be available when starting Neovim
  {
    "Shatur/neovim-ayu",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme ayu-mirage]])
    end,
  },
  { "nvim-tree/nvim-tree.lua"},

  {
    "hrsh7th/nvim-cmp",
    -- load cmp on InsertEnter
    event = "InsertEnter",
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
    },
    config = function()
    end,
  },

  -- if some code requires a module from an unloaded plugin, it will be automatically loaded.
  -- So for api plugins like devicons, we can always set lazy=true
  {"neovim/nvim-lspconfig"},
  { 
    "nvim-tree/nvim-web-devicons", 
    lazy = true,
    dependencies = { 
      "nvim-lualine/lualine.nvim"
    },
  },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/nvim-cmp" },

  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

  { 
    "nvim-lualine/lualine.nvim",
    opts = {
      icons_enabled = true,
      theme = "ayu_mirage",
    }
  },

  -- you can use the VeryLazy event for things that can
  -- load later and are not important for the initial UI
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  { "lervag/vimtex" },
  { "CRAG666/code_runner.nvim",
  opts = {
    filetype = {
      python = "python3 -u",
      rust = {
        "cd $dir &&",
        "rustc $fileName &&",
        "$dir/$fileNameWithoutExt"
      },
      -- should default to brew installation of g++ on macos, otherwise, g++
      cpp = {
      "cd $dir &&",
      "[[ $(uname) == 'Darwin' ]] && COMPILER=g++-15 || COMPILER=g++ &&",
      "$COMPILER -std=c++20 $fileName -o $fileNameWithoutExt &&",
      "$dir/$fileNameWithoutExt"
    }
 
  },

  }
},

  {
    "Wansmer/treesj",
    keys = {
      { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },

  {
    "monaqa/dial.nvim",
    -- lazy-load on keys
    -- mode is `n` by default. For more advanced options, check the section on key mappings
    keys = { "<C-a>", { "<C-x>", mode = "n" } },
  },
{
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    -- Optional configuration settings
  },
  keys = {
    -- Keybinding to paste image from clipboard
    { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
  },
},
{
  "karb94/neoscroll.nvim",
  opts = {},
},
{
  "sphamba/smear-cursor.nvim",
  opts = {},
}

}
