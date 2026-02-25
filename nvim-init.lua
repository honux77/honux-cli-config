-------------------------------------------------
-- Neovim init.lua (0.11+)
-- - lazy.nvim
-- - vim.lsp.config / vim.lsp.enable
-------------------------------------------------

-------------------------------------------------
-- 기본 설정
-------------------------------------------------
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus" -- macOS 클립보드
vim.opt.updatetime = 250
vim.opt.mouse = "a"

-------------------------------------------------
-- lazy.nvim 자동 설치
-------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop
if not uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-------------------------------------------------
-- LspAttach: LSP 키맵
-------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})

-------------------------------------------------
-- 플러그인
-------------------------------------------------
require("lazy").setup({
  -- 테마 (가볍고 깔끔)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  -- 아이콘 (상태바/파일탐색 등에 사용)
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- 상태바 (가볍고 충분)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          globalstatus = true,
          section_separators = "",
          component_separators = "",
        },
      })
    end,
  },

  -- 파일 탐색: Oil (네트워크/remote 없이 로컬 탐색에 가볍고 좋음)
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({
        view_options = { show_hidden = true }, -- dotfiles 항상 보기
      })
      vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Oil (file explorer)" })
    end,
  },

  -- Telescope (검색/파일찾기)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local t = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", t.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", t.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", t.buffers, { desc = "Buffers" })
      vim.keymap.set("n", "<leader>fh", t.help_tags, { desc = "Help" })
    end,
  },

  -- Treesitter (구문 하이라이트/인덴트)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.config").setup({
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -------------------------------------------------
  -- LSP: Mason + nvim-lspconfig(정의 제공) + vim.lsp.config/enable
  -------------------------------------------------
  { "neovim/nvim-lspconfig" }, -- server 정의 제공(필수)
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",   -- TypeScript/JavaScript
          "lua_ls",  -- Lua (Neovim 설정)
        },
        automatic_installation = true,
      })

      -- ✅ Neovim 0.11+ 방식
      -- LSP 서버별 설정
      vim.lsp.config("ts_ls", {})
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      -- 활성화
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("lua_ls")
    end,
  },

  -------------------------------------------------
  -- 자동완성: nvim-cmp (+ LSP/경로/버퍼)
  -------------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer" },
        }),
      })
    end,
  },
})

-------------------------------------------------
-- 자주 쓰는 키맵
-------------------------------------------------
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Explorer (Oil)" })

-------------------------------------------------
-- (선택) 진단 표시 조금 덜 시끄럽게
-------------------------------------------------
vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = { border = "rounded" },
})
