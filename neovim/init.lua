vim.wo.number       = true
vim.wo.cursorline   = true
vim.wo.cursorcolumn = true

vim.opt.termguicolors = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

local keymap      = vim.api.nvim_set_keymap
local keymap_opts = { noremap = true, silent = true }

local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

require 'packer'.startup(
	function()
		use 'wbthomason/packer.nvim'

		use {
			'kyazdani42/nvim-tree.lua',
			requires = { 'kyazdani42/nvim-web-devicons' }
		}

		use 'ayu-theme/ayu-vim'
		use 'folke/tokyonight.nvim'

		use {
			'lewis6991/gitsigns.nvim'
		}

		use 'nvim-treesitter/nvim-treesitter'
		use 'windwp/nvim-autopairs'
		use 'lukas-reineke/indent-blankline.nvim'

		use {
			'nvim-telescope/telescope.nvim',
			requires = { 'nvim-lua/plenary.nvim' }
		}

		use 'voldikss/vim-floaterm'

		use {
			'nvim-lualine/lualine.nvim',
			requires = { 'kyazdani42/nvim-web-devicons', opt = true }
		}
		use { 'akinsho/bufferline.nvim', tag = '*', requires = 'kyazdani42/nvim-web-devicons' }

		use 'numToStr/Comment.nvim'

		use 'neovim/nvim-lspconfig'
		use 'hrsh7th/cmp-nvim-lsp'
		use 'hrsh7th/cmp-buffer'
		use 'hrsh7th/cmp-path'
		use 'hrsh7th/cmp-cmdline'
		use 'hrsh7th/nvim-cmp'
		use({
			'glepnir/lspsaga.nvim',
			branch = 'main',
			config = function()
				local saga = require 'lspsaga'
				saga.init_lsp_saga {}
			end
		})

		use {
			'folke/trouble.nvim',
			requires = 'kyazdani42/nvim-web-devicons',
		}

		use 'fatih/vim-go'
		use 'rust-lang/rust.vim'
		use 'simrat39/rust-tools.nvim'
		use 'mfussenegger/nvim-jdtls'

		use 'L3MON4D3/LuaSnip'
		use 'rafamadriz/friendly-snippets'
		use { 'saadparwaiz1/cmp_luasnip' }

		use 'folke/which-key.nvim'
	end
)

require 'nvim-treesitter.configs'.setup {
	ensure_installed = { 'go', 'rust', 'lua', 'java' },
	sync_install = false,
	highlight = { enable = true }
}

-- vim.g.ayucolor = 'mirage'
-- vim.cmd 'colorscheme ayu'
vim.g.tokyonight_style = 'storm'
vim.g.tokyonight_italic_comments = false
vim.cmd [[colorscheme tokyonight]]

local italic_categories = {
	'TSInclude', 'Include',
	'TSFuncBuiltin', 'FuncBuiltin',
	'TSKeyword', 'TSKeywordFunction', 'Keyword',
	'TSConditional', 'Conditional',
	'TSRepeat',
}
for _, v in ipairs(italic_categories) do
	vim.cmd(table.concat({ 'highlight ', v, ' cterm=italic gui=italic' }))
end

require 'nvim-tree'.setup {}

require 'gitsigns'.setup {
	current_line_blame = true,
	current_line_blame_opts = {
		delay = 300,
		ignore_whitespace = true
	}
}

local npairs = require 'nvim-autopairs'
local npairs_rule = require 'nvim-autopairs.rule'
npairs.setup {
	disable_filetype = { 'TelescopePrompt', 'guihua', 'guihua_rust', 'clap_input' },
}
npairs.add_rule(npairs_rule('<', '>', 'rust'))

require 'indent_blankline'.setup {
	show_current_context = true,
}

require 'lualine'.setup {
	options = {
		theme = 'tokyonight',
		section_separators = { left = '', right = '' },
	},
	sections = {
		lualine_c = { { 'filename', file_status = true, path = 1 } }
	},
	inactive_sections = {
		lualine_c = {}
	}
}

require 'bufferline'.setup {
	options = {
		mode = 'tabs',
		separator_style = 'slant',
		show_buffer_close_icons = false,
		show_close_icon = false,
		offsets = {
			{
				filetype = 'NvimTree',
				text = 'File Explorer',
				highlight = 'Directory',
				text_align = 'center'
			}
		}
	},

}

require 'Comment'.setup {}

require 'lspconfig'.sumneko_lua.setup {
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				globals = { 'vim' },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file('', true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
}

require 'lspconfig'.gopls.setup {}
vim.g.go_def_mapping_enabled = 0
vim.g.go_doc_keywordprg_enabled = 0
vim.g.go_doc_popup_window = 1

require 'rust-tools'.setup {
	tools = {
		autoSetHints = true,
		inlay_hints = {
			show_parameter_hints = false,
			parameter_hints_prefix = '<- ',
			other_hints_prefix = '=> '
		}
	},
	server = {
		settings = {
			['rust-analyzer'] = {
				checkOnSave = {
					command = 'clippy'
				}
			}
		}
	}
}

require 'lspconfig'.jdtls.setup {}
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = '/path/to/workspace-root/' .. project_name
require 'jdtls'.start_or_attach {
	cmd = {
		'/Users/xu.hu/.java/jdk-17.0.3.1.jdk/Contents/Home/bin/java',
		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-Xms1g',
		'--add-modules=ALL-SYSTEM',
		'--add-opens', 'java.base/java.util=ALL-UNNAMED',
		'--add-opens', 'java.base/java.lang=ALL-UNNAMED',
		'-jar',
		'/Users/xu.hu/.java/jdt-language-server-1.14.0-202207211651/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
		'-configuration', '/Users/xu.hu/.java/jdt-language-server-1.14.0-202207211651/config_mac',
		'-data', workspace_dir
	},
	root_dir = require 'jdtls.setup'.find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml' }),
	settings = {
		java = {
		}
	},
	init_options = {
		bundles = {}
	},
}

local luasnip = require 'luasnip'
require 'luasnip.loaders.from_vscode'.lazy_load()

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end
local cmp = require 'cmp'
require 'cmp'.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = cmp.config.sources(
		{ { name = 'nvim_lsp' } },
		{ { name = 'luasnip' } },
		{ { name = 'buffer' } }
	),
	mapping = {
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		['<C-n>'] = function(fallback)
			if not cmp.select_next_item() then
				if vim.bo.buftype ~= 'prompt' and has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end
		end,
		['<C-p>'] = function(fallback)
			if not cmp.select_prev_item() then
				if vim.bo.buftype ~= 'prompt' and has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end
		end,
	}
}

local lang_test_command = {
	go = 'GoTest',
	rust = 'rightbelow vert 80RustTest'
}
function _G.execute_test_command()
	local command = lang_test_command[vim.bo.filetype]
	if command ~= nil then
		vim.api.nvim_command(command)
	else
		print('Test command not defined')
	end
end

keymap('n', 'gt', '<CMD>lua execute_test_command()<CR>', keymap_opts)

keymap('n', '<space>source', '<CMD>source ~/.config/nvim/init.lua<CR>', keymap_opts)
keymap('n', 'nt', '<CMD>NvimTreeToggle<CR>', keymap_opts)
keymap('n', 'ff', '<CMD>Telescope find_files<CR>', keymap_opts)
keymap('n', 'fg', '<CMD>Telescope live_grep<CR>', keymap_opts)
keymap('n', 'nh', '<CMD>noh<CR>', keymap_opts)
keymap('n', 'ft', '<CMD>FloatermToggle<CR>', keymap_opts)
keymap('t', '<Esc>', '<C-\\><C-n><CMD>FloatermToggle<CR>', keymap_opts)

keymap('n', 'gd', '<CMD>lua vim.lsp.buf.definition()<CR>', keymap_opts)
keymap('n', '<C-k>', '<CMD>lua vim.lsp.buf.signature_help()<CR>', keymap_opts)
keymap('n', '<space>wa', '<CMD>lua vim.lsp.buf.add_workspace_folder()<CR>', keymap_opts)
keymap('n', '<space>wr', '<CMD>lua vim.lsp.buf.remove_workspace_folder()<CR>', keymap_opts)
keymap('n', '<space>wl', '<CMD>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', keymap_opts)
keymap('n', '<space>D', '<CMD>lua vim.lsp.buf.type_definition()<CR>', keymap_opts)
keymap('n', 'gr', '<CMD>lua vim.lsp.buf.references()<CR>', keymap_opts)
keymap('n', '<space>f', '<CMD>lua vim.lsp.buf.format { async = true }<CR>', keymap_opts)

keymap('n', '<space>sp', '<CMD>split<CR>', keymap_opts)
keymap('n', '<space>vsp', '<CMD>vsplit<CR>', keymap_opts)
keymap('n', '<C-H>', '<C-W><C-H>', keymap_opts)
keymap('n', '<C-J>', '<C-W><C-J>', keymap_opts)
keymap('n', '<C-K>', '<C-W><C-K>', keymap_opts)
keymap('n', '<c-l>', '<c-w><c-l>', keymap_opts)

keymap('n', '<c-c>', '<esc>', keymap_opts)
keymap('i', '<c-c>', '<esc>', keymap_opts)
keymap('v', '<C-c>', '<Esc>', keymap_opts)
keymap('s', '<C-c>', '<Esc>', keymap_opts)
keymap('x', '<C-c>', '<Esc>', keymap_opts)
keymap('c', '<C-c>', '<Esc>', keymap_opts)
keymap('o', '<C-c>', '<Esc>', keymap_opts)
keymap('l', '<C-c>', '<Esc>', keymap_opts)

keymap('n', '<space>d', '<CMD>bdelete<CR>', keymap_opts)
keymap('n', '<space>n', '<CMD>tabnew<CR>', keymap_opts)
keymap('n', '<space>.', '<CMD>BufferLineCycleNext<CR>', keymap_opts)
keymap('n', '<space>,', '<CMD>BufferLineCyclePrev<CR>', keymap_opts)

keymap('n', 'tw', '<CMD>Trouble workspace_diagnostics<CR>', keymap_opts)
keymap('n', 'td', '<CMD>Trouble document_diagnostics<CR>', keymap_opts)

keymap('n', 'ca', '<CMD>Lspsaga code_action<CR>', keymap_opts)
keymap('n', 'K', '<CMD>Lspsaga hover_doc<CR>', keymap_opts)
keymap('n', 'gs', '<Cmd>Lspsaga signature_help<CR>', keymap_opts)
keymap('n', '<space>rn', '<CMD>Lspsaga rename<CR>', keymap_opts)
keymap('n', 'gp', '<CMD>Lspsaga preview_definition<CR>', keymap_opts)

keymap('v', '<space>cp', '"*y', keymap_opts)

require 'which-key'.register({
	c = {}, f = {}, g = {}, n = {}, r = {}, t = {},
})

vim.g.neovide_cursor_animation_length = 0.015
vim.g.neovide_cursor_trail_length = 0
vim.g.neovide_cursor_vfx_mode = 'railgun'
vim.opt.guifont = 'Iosevka NF:h18'
