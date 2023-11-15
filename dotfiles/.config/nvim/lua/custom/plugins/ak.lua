-- needs commenting out default in init.lua
vim.o.hlsearch = true

vim.o.colorcolumn = "85"

vim.o.background = vim.env.TERMINAL_LIGHTNESS

vim.keymap.set('n', '<leader>sF',
    function()
        require('telescope.builtin').find_files({cwd = vim.env.HOME .. "/src"})
    end,
    { desc = '[S]earch [F]iles in src' })

-- Requires commenting out corresponding entry in init
-- https://github.com/nvim-telescope/telescope.nvim/issues/1173
vim.keymap.set('n', '<leader>sf',
    function()
        require('telescope.builtin').find_files({hidden=true})
    end,
    { desc = '[S]earch [F]iles' })

vim.cmd([[
    function! ToggleBackground()
      if &background == "light"
        set background=dark
      else
        set background=light
      endif
    endfunction
    command! Tb call ToggleBackground()

    autocmd BufReadPre,FileReadPre    *.xoj setlocal bin
    autocmd BufReadPost,FileReadPost  *.xoj  call gzip#read("gzip -S .xoj -dn")
    autocmd BufWritePost,FileWritePost    *.xoj  call gzip#write("gzip -S .xoj")
    autocmd FileAppendPre         *.xoj  call gzip#appre("gzip -S .xoj -dn")
    autocmd FileAppendPost      *.xoj  call gzip#write("gzip -S .xoj")

    autocmd BufReadPre,FileReadPre    *.xopp setlocal bin
    autocmd BufReadPost,FileReadPost  *.xopp  call gzip#read("gzip -S .xopp -dn")
    autocmd BufWritePost,FileWritePost    *.xopp  call gzip#write("gzip -S .xopp")
    autocmd FileAppendPre         *.xopp  call gzip#appre("gzip -S .xopp -dn")
    autocmd FileAppendPost      *.xopp  call gzip#write("gzip -S .xopp")

    function! FixWhitespace()
        %s/\s\+$//eg
        set expandtab
        %retab
    endfunction
    command! Fws call FixWhitespace()

    function! WebEdit()
        set nolist
        set wrap
        set linebreak
        map j gj
        map k gk
    endfunction
    command! We call WebEdit()
]])

-- Restore cursor position
-- https://stackoverflow.com/a/72939989
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    callback = function()
        vim.cmd('silent! normal! g`"zv', false)
    end,
})

return {
    {
        'nvim-orgmode/orgmode',
        dependencies = {
            { 'nvim-treesitter/nvim-treesitter', lazy = true },
        },
        event = 'VeryLazy',
        config = function()
            -- Load treesitter grammar for org
            require('orgmode').setup_ts_grammar()

            -- Setup treesitter
            require('nvim-treesitter.configs').setup({
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { 'org' },
                },
                ensure_installed = { 'org' },
            })

            -- Setup orgmode
            require('orgmode').setup({
                org_agenda_files = '~/org/**/*',
                -- org_default_notes_file = '~/orgfiles/refile.org',
            })
        end,
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        config = function ()
            require('neo-tree').setup {}
            vim.keymap.set('n', '<leader>t', "<cmd>:Neotree<CR>",
                { desc = "Show file [t]ree" })
        end,
    },
    {
        'smoka7/hop.nvim',
        version = "v2.*",
        opts = {},
        config = function()
            local hop = require('hop')

            hop.setup { keys = 'etovxqpdygfblzhckisuran' }

            local directions = require('hop.hint').HintDirection
            vim.keymap.set('n', '<leader>j', function()
                hop.hint_words({ direction = directions.AFTER_CURSOR })
            end, {remap=true, desc = "Hinted hop down"})
            vim.keymap.set('n', '<leader>k', function()
                hop.hint_words({ direction = directions.BEFORE_CURSOR })
            end, {remap=true, desc = "Hinted hop up"})
        end
    }
}

-- vim: sw=4
