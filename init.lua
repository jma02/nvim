-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("config.lazy")
require("mason").setup()

-- optionally enable 24-bit colour
vim.opt.termguicolors = true
-- LSP
vim.lsp.config.clangd = {
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  single_file_support = true,
  root_markers = { 'compile_flags.txt' },
}

vim.lsp.config.pylsp = {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { 'W391' },
        },
      },
    },
  },
}

vim.lsp.config.lua_ls = {}

vim.lsp.enable({ 'clangd', 'pylsp', 'lua_ls' })

-- empty setup using defaults
require("nvim-tree").setup()

require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip/"})

local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- VimTeX

-- TODO: figure out how to make tectonic work nice, probably need to make it so tectonic doesnt use _preamble / _postamble
-- might be fine to also uninstall vimtex for this
-- vim.g.vimtex_compiler_method = 'tectonic -X watch'

vim.g.vimtex_view_method = "skim"
vim.cmd('filetype plugin indent on')


-- menu
vim.keymap.set("n", "<C-t>", function()
  require("menu").open("default")
end, {})

-- File Runner
vim.keymap.set('n', '<F10>', ':RunFile<CR>', { noremap = true, silent = false })


-- Vim settings
vim.opt.relativenumber = true
vim.opt.cindent = true
vim.opt.showmatch = true
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.syntax = 'on'
vim.opt.wrap = false

vim.api.nvim_set_keymap('i', '(', '()<left>', { noremap = true })
vim.api.nvim_set_keymap('i', '[', '[]<left>', { noremap = true })
vim.api.nvim_set_keymap('i', '{', '{}<left>', { noremap = true })
vim.api.nvim_set_keymap('i', '{<CR>', '{<CR>}<ESC>O', { noremap = true })
vim.api.nvim_set_keymap('i', '{;<CR>', '{<CR>};<ESC>O', { noremap = true })

-- Turn spellcheck off by default
vim.opt.spell = false

-- Set spelllang for .tex and .md files
vim.api.nvim_exec([[
  autocmd FileType tex,md setlocal spell spelllang=en_gb
]], false)

-- Map <C-l> to clear and reapply spelling
vim.api.nvim_set_keymap('i', '<C-l>', '<c-g>u<Esc>[s1z=`]a<c-g>u', { noremap = true })

-- Template files
vim.cmd([[
  autocmd BufNewFile *.cpp 0r ~/.config/nvim/template.cpp
  autocmd BufNewFile *.tex 0r ~/.config/nvim/template.tex
]])

-- When tectonic.nvim activates, copy jma.sty and ensure _preamble includes it
vim.api.nvim_create_autocmd("User", {
  pattern = "TectonicActivated",
  callback = function()
    local root = require("tectonic").state.root_dir
    if not root then return end

    local sty_src = vim.fn.expand("~/.config/nvim/tex/jma.sty")
    local sty_dst = root .. "/src/jma.sty"
    if vim.fn.filereadable(sty_dst) == 0 then
      vim.fn.system({ "cp", sty_src, sty_dst })
    end

    local preamble = root .. "/src/_preamble.tex"
    if vim.fn.filereadable(preamble) == 1 then
      local content = vim.fn.readfile(preamble)
      local insert_at = nil
      for i, line in ipairs(content) do
        if line:match("\\usepackage{jma}") then return end
        if line:match("\\documentclass") then insert_at = i + 1 end
      end
      if insert_at then
        table.insert(content, insert_at, "\\usepackage{jma}")
      else
        table.insert(content, "\\usepackage{jma}")
      end
      vim.fn.writefile(content, preamble)
    end
  end,
})



