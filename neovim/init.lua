vim.wo.number = true
vim.wo.cursorline = true
vim.wo.cursorcolumn = true

vim.opt.termguicolors = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

local keymap = vim.api.nvim_set_keymap
local keymap_opts = {noremap = true, silent = true}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath
        }
    )
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
    {
        "folke/tokyonight.nvim",
        {
            "stevearc/oil.nvim",
            opts = {},
            dependencies = {"nvim-tree/nvim-web-devicons"}
        },
        {
            "nvim-telescope/telescope.nvim",
            dependencies = {"nvim-lua/plenary.nvim"}
        },
        {
            "nvim-lualine/lualine.nvim",
            dependencies = {"nvim-tree/nvim-web-devicons"}
        },
        {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}
    }
)

vim.g.tokyonight_style = "storm"
vim.g.tokyonight_italic_comments = false
vim.cmd [[colorscheme tokyonight]]

local italic_categories = {
    "TSInclude",
    "Include",
    "TSFuncBuiltin",
    "FuncBuiltin",
    "TSKeyword",
    "TSKeywordFunction",
    "Keyword",
    "TSConditional",
    "Conditional",
    "TSRepeat"
}
for _, v in ipairs(italic_categories) do
    vim.cmd(table.concat({"highlight ", v, " cterm=italic gui=italic"}))
end

require "lualine".setup {
    options = {
        theme = "OceanicNext",
        section_separators = {left = "", right = ""}
    },
    sections = {
        lualine_c = {{"filename", file_status = true, path = 1}}
    },
    inactive_sections = {
        lualine_c = {}
    }
}

require "nvim-treesitter.configs".setup {
    ensure_installed = {"lua", "go", "python", "javascript", "typescript", "rust", "java"},
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true
    }
}

keymap("n", "<space>sc", "<CMD>source ~/.config/nvim/init.lua<CR>", keymap_opts)
keymap("n", "<C-H>", "<C-W><C-H>", keymap_opts)
keymap("n", "<C-J>", "<C-W><C-J>", keymap_opts)
keymap("n", "<C-K>", "<C-W><C-K>", keymap_opts)
keymap("n", "<c-l>", "<c-w><c-l>", keymap_opts)

keymap("n", "<space>o", "<CMD>Oil<CR>", keymap_opts)
keymap("n", "<space>ff", "<CMD>Telescope find_files<CR>", keymap_opts)
keymap("n", "<space>fg", "<CMD>Telescope live_grep find_command=rg,--ignore<CR>", keymap_opts)
keymap("v", "<space>cp", '"*y', keymap_opts)
