-- OPTIONS

vim.opt.background = "dark"
vim.cmd("colorscheme monoglow")
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 30
vim.opt.sidescrolloff = 8

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.showmatch = true
vim.opt.cmdheight = 1
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.showmode = false
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.winblend = 0
vim.opt.conceallevel = 0
vim.opt.concealcursor = ""
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 300

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 0
vim.opt.autoread = true
vim.opt.autowrite = false

vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")
vim.opt.selection = "exclusive"
vim.opt.mouse = "a"
vim.opt.clipboard:append("unnamedplus")
vim.opt.modifiable = true
vim.opt.encoding = "UTF-8"
vim.opt.guicursor =
"n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- KEYMAPS

vim.keymap.set("n", "Y", "y$", { desc = "Yank to end of line" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set("n", "<leader>e", ":Lexplore 35<CR>", { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>ff", ":find ", { desc = "Find file" })

vim.keymap.set("n", "<leader>rc", ":e ~/.nixos/user/config/nvim/lua/settings.lua", { desc = "Edit config" })
-- vim.keymap.set("n", "<leader>rl", ":so $MYVIMRC<CR>", { desc = "Reload config" })

-- FUNCTIONS

-- Copy Full Filepath
vim.keymap.set("n", "<leader>pa", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    print("file:", path)
end)

local augroup = vim.api.nvim_create_augroup("UserConfig", {})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        local line = mark[1]
        local ft = vim.bo.filetype
        if line > 0 and line <= lcount
            and vim.fn.index({ "commit", "gitrebase", "xxd" }, ft) == -1
            and not vim.o.diff then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

vim.api.nvim_create_autocmd("TermClose", {
    group = augroup,
    callback = function()
        if vim.v.event.status == 0 then
            vim.api.nvim_buf_delete(0, {})
        end
    end,
})

vim.api.nvim_create_autocmd("VimResized", {
    group = augroup,
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    callback = function()
        local dir = vim.fn.expand('<afile>:p:h')
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, 'p')
        end
    end,
})

vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })

vim.opt.diffopt:append("linematch:60")

vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end

-- TERMINAL

local terminal_state = {
    buf = nil,
    win = nil,
    is_open = false
}

local function FloatingTerminal()
    if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
        return
    end

    if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
        terminal_state.buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_option(terminal_state.buf, 'bufhidden', 'hide')
    end

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = "single",
    })

    local has_terminal = false
    local lines = vim.api.nvim_buf_get_lines(terminal_state.buf, 0, -1, false)
    for _, line in ipairs(lines) do
        if line ~= "" then
            has_terminal = true
            break
        end
    end

    if not has_terminal then
        vim.fn.termopen(os.getenv("SHELL"))
    end

    terminal_state.is_open = true
    vim.cmd("startinsert")

    vim.api.nvim_create_autocmd("BufLeave", {
        buffer = terminal_state.buf,
        callback = function()
            if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
                vim.api.nvim_win_close(terminal_state.win, false)
                terminal_state.is_open = false
            end
        end,
        once = true
    })
end

local function CloseFloatingTerminal()
    if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
    end
end

vim.keymap.set("n", "<leader>t", FloatingTerminal, { noremap = true, silent = true, desc = "Toggle floating terminal" })
vim.keymap.set("t", "<Esc>", function()
    if terminal_state.is_open then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
    end
end, { noremap = true, silent = true, desc = "Close floating terminal from terminal mode" })

-- TABS

vim.opt.showtabline = 2
vim.opt.tabline = ''

vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', { desc = 'Close tab' })

vim.keymap.set('n', '<leader>tm', ':tabmove<CR>', { desc = 'Move tab' })
vim.keymap.set('n', '<leader>t>', ':tabmove +1<CR>', { desc = 'Move tab right' })
vim.keymap.set('n', '<leader>t<', ':tabmove -1<CR>', { desc = 'Move tab left' })
vim.keymap.set('n', '<leader>tf', ':tabn<CR>', { desc = 'Next tab' })
vim.keymap.set('n', '<leader>tb', ':tabp<CR>', { desc = 'Previous tab' })

local function open_file_in_tab()
    vim.ui.input({ prompt = 'File to open in new tab: ', completion = 'file' }, function(input)
        if input and input ~= '' then
            vim.cmd('tabnew ' .. input)
        end
    end)
end

local function duplicate_tab()
    local current_file = vim.fn.expand('%:p')
    if current_file ~= '' then
        vim.cmd('tabnew ' .. current_file)
    else
        vim.cmd('tabnew')
    end
end

local function close_tabs_right()
    local current_tab = vim.fn.tabpagenr()
    local last_tab = vim.fn.tabpagenr('$')

    for i = last_tab, current_tab + 1, -1 do
        vim.cmd(i .. 'tabclose')
    end
end

local function close_tabs_left()
    local current_tab = vim.fn.tabpagenr()

    for i = current_tab - 1, 1, -1 do
        vim.cmd('1tabclose')
    end
end

vim.keymap.set('n', '<leader>tO', open_file_in_tab, { desc = 'Open file in new tab' })
vim.keymap.set('n', '<leader>td', duplicate_tab, { desc = 'Duplicate current tab' })
vim.keymap.set('n', '<leader>tr', close_tabs_right, { desc = 'Close tabs to the right' })
vim.keymap.set('n', '<leader>tL', close_tabs_left, { desc = 'Close tabs to the left' })

local function smart_close_buffer()
    local buffers_in_tab = #vim.fn.tabpagebuflist()
    if buffers_in_tab > 1 then
        vim.cmd('bdelete')
    else
        vim.cmd('tabclose')
    end
end
vim.keymap.set('n', '<leader>bd', smart_close_buffer, { desc = 'Smart close buffer/tab' })

-- STATUSLINE
--[[
local colors = {
    normal  = { fg = '#000000', bg = '#eaffff', bold = true },
    insert  = { fg = '#000000', bg = '#ffffea', bold = true },
    visual  = { fg = '#000000', bg = '#aaccaa', bold = true },
    command = { fg = '#000000', bg = '#ccaacc', bold = true },
    replace = { fg = '#ffffff', bg = '#aa0000', bold = true },
    string  = { fg = '#000000', bg = '#f5f5dc' },
    extra   = { fg = '#000000', bg = '#f5f5dc' },
}
]]

local colors = {
    normal  = { fg = '#ffffff', bg = '#080808', bold = true },
    insert  = { fg = '#1d2021', bg = '#1bfd9c', bold = true },
    visual  = { fg = '#1d2021', bg = '#f1f1f1', bold = true },
    command = { fg = '#1d2021', bg = '#4fcdf3', bold = true },
    replace = { fg = '#1d2021', bg = '#fb4934', bold = true },
    string  = { fg = '#ffffff', bg = '#191919' },
    extra   = { fg = '#ffffff', bg = '#191919' },
}

local function set_highlights()
    vim.api.nvim_set_hl(0, 'StatusLineNormal', colors.normal)
    vim.api.nvim_set_hl(0, 'StatusLineInsert', colors.insert)
    vim.api.nvim_set_hl(0, 'StatusLineVisual', colors.visual)
    vim.api.nvim_set_hl(0, 'StatusLineReplace', colors.replace)
    vim.api.nvim_set_hl(0, 'StatusLineCmd', colors.command)
    vim.api.nvim_set_hl(0, 'StatusLineBody', colors.string)
    vim.api.nvim_set_hl(0, 'StatusLineExtra', colors.extra)
end

set_highlights()
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_highlights })

local git_branch_cache = ""
local function update_git_branch()
    local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
    git_branch_cache = branch ~= "" and ("  " .. branch .. " ") or ""
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    callback = update_git_branch,
})

local function get_mode_highlight()
    local m = vim.fn.mode()
    if m == 'n' then return "%#StatusLineNormal#" end
    if m == 'i' then return "%#StatusLineInsert#" end
    if m == 'v' or m == 'V' or m == '\22' then return "%#StatusLineVisual#" end
    if m == 'R' then return "%#StatusLineReplace#" end
    if m == 'c' then return "%#StatusLineCmd#" end
    return "%#StatusLineNormal#"
end

local function file_info()
    local ft = vim.bo.filetype
    if ft == "" then return "" end
    local icons = { lua = "", python = "", c = "", html = "", rust = "" }
    return string.format(" %s [%s] ", icons[ft] or "", ft:upper())
end

local function file_size()
    local size = vim.fn.getfsize(vim.fn.expand('%'))
    if size < 0 then return "" end
    if size < 1024 then
        return string.format(" %dB ", size)
    elseif size < 1048576 then
        return string.format(" %.1fK ", size / 1024)
    else
        return string.format(" %.1fM ", size / 1048576)
    end
end

local function mode_name()
    local mode_map = {
        ['n'] = 'NORMAL',
        ['i'] = 'INSERT',
        ['v'] = 'VISUAL',
        ['V'] = 'V-LINE',
        ['\22'] = 'V-BLOCK',
        ['c'] = 'COMMAND',
        ['R'] = 'REPLACE',
        ['t'] = 'TERMINAL'
    }
    return string.format(" %s ", mode_map[vim.fn.mode()] or vim.fn.mode():upper())
end

function _G.statusline_active()
    return table.concat {
        get_mode_highlight(), -- Color Switch
        mode_name(), -- Mode Name
        "%#StatusLineBody#", -- Dark Grey Body
        git_branch_cache, -- Git Branch
        " │ %f %m%r", -- File Path
        "%=", -- Right Align
        "%#StatusLineExtra#", -- Lighter Grey
        file_info(), -- File Type
        "│",
        file_size(), -- File Size
        get_mode_highlight(), -- Color Switch
        " %l:%c %P " -- Line:Col %
    }
end

function _G.statusline_inactive()
    return "%#Comment#  %f %m %=  %l:%c "
end

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    callback = function()
        vim.opt_local.statusline = "%!v:lua.statusline_active()"
    end
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    callback = function()
        vim.opt_local.statusline = "%!v:lua.statusline_inactive()"
    end
})

-- TREESITTER

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if status_ok then
    configs.setup({
        auto_install = false,
        sync_install = false,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true,
        },
    })
end

-- COMPLETION

local kind_icons = {
    Text = " ",
    Method = "󰆧 ",
    Function = "󰊕",
    Constructor = " ",
    Field = "󰇽",
    Variable = "󰂡",
    Class = "󰠱 ",
    Interface = " ",
    Module = " ",
    Property = "󰜢 ",
    Unit = " ",
    Value = "󰎠 ",
    Enum = " ",
    Keyword = "󰌋 ",
    Snippet = " ",
    Color = "󰏘",
    File = "󰈙",
    Reference = " ",
    Folder = "󰉋 ",
    EnumMember = " ",
    Constant = "󰏿",
    Struct = " ",
    Event = " ",
    Operator = "󰆕 ",
    TypeParameter = "󰅲 ",
}

local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    window = {
        documentation = {
            border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
        },
        completion = {
            border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
        },
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
    }),
    view = {
        entries = "custom"
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
            vim_item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[LaTeX]",
            })[entry.source.name]
            return vim_item
        end
    },
})
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" }
    }
})
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" }
    }, {
        { name = "cmdline" }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
})

-- LSP

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        opts.desc = "Show LSP references"
        vim.keymap.set("n", "gR", vim.lsp.buf.references, opts)
        opts.desc = "Go to declaration"
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        opts.desc = "Show LSP definitions"
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        opts.desc = "Show LSP implementations"
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        opts.desc = "Show LSP type definitions"
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
        opts.desc = "Show buffer diagnostics"
        vim.keymap.set("n", "<leader>D", vim.diagnostic.setqflist, opts)
        opts.desc = "See available code actions"
        vim.keymap.set({ "n", "v" }, "<leader>vca", function()
            vim.lsp.buf.code_action()
        end, opts)
        opts.desc = "Format buffer"
        vim.keymap.set("n", "<leader>fb", function()
            vim.lsp.buf.format({ async = true })
        end, opts)
        opts.desc = "Smart rename"
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        opts.desc = "Show line diagnostics"
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        opts.desc = "Show documentation for what is under cursor"
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        opts.desc = "Restart LSP"
        vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
        opts.desc = "Signature help"
        vim.keymap.set("i", "<A-h>", vim.lsp.buf.signature_help, opts)
    end,
})

local signs = {
    [vim.diagnostic.severity.ERROR] = " ",
    [vim.diagnostic.severity.WARN] = " ",
    [vim.diagnostic.severity.HINT] = "󰠠 ",
    [vim.diagnostic.severity.INFO] = " ",
}
vim.diagnostic.config({
    signs = {
        text = signs,
    },
    virtual_text = true,
    underline = true,
    update_in_insert = false,
})
-- FORCE borders on ALL LSP hovers (cannot be bypassed)
local orig_open_floating_preview = vim.lsp.util.open_floating_preview
vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
    opts = opts or {}
    if opts.border == nil then
        opts.border = "single"
    end
    return orig_open_floating_preview(contents, syntax, opts, ...)
end

local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()
vim.lsp.config("*", {
    capabilities = capabilities,
})

-- Lua
vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT', -- Use LuaJIT for Neovim
            },
            diagnostics = {
                globals = { 'vim' }, -- Recognize `vim` as a global
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true), -- Make LSP aware of Neovim runtime
                checkThirdParty = false,                           -- Disable third-party library warnings
            },
            telemetry = {
                enable = false, -- Disable telemetry for privacy
            },
        },
    },
})
vim.lsp.enable("lua_ls")
-- C/C++
vim.lsp.config("clangd", {
    cmd = { "clangd", "--background-index", "--query-driver=/nix/store/**/*" },
})
vim.lsp.enable("clangd")
-- Python
vim.lsp.enable("pyright")
-- Nix
vim.lsp.config("nixd", {
    cmd = { "nixd" },
    filetypes = { "nix" },
    settings = {
        nixd = {
            formatting = {
                command = { "nixpkgs-fmt" },
            },
        },
    },
})
vim.lsp.enable("nixd")
-- Assembly
vim.lsp.enable("asm_lsp")
-- Rust
vim.lsp.enable("rust_analyzer")
-- Lean
require('lean').setup {
    mappings = true,
    abbreviations = {
        enable = true,
    },
}
vim.api.nvim_create_autocmd({ 'WinClosed', 'VimResized' }, {
    callback = require('lean.infoview').reposition
})
vim.lsp.config("leanls", {
    init_options = {
        editDelay = 10,
        hasWidgets = true,
    }
})
