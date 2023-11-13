-- needs commenting out default in init.lua
vim.o.hlsearch = true

vim.o.colorcolumn = "85"

vim.o.background = vim.env.TERMINAL_LIGHTNESS

vim.keymap.set('n', '<leader>sF',
    function()
        require('telescope.builtin').find_files({cwd = vim.env.HOME .. "/src"})
    end,
    { desc = '[S]earch [F]iles in src' })

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

    function FixWhitespace()
        %s/\s\+$//eg
        set expandtab
        %retab
    endfunction
    command Fws call FixWhitespace()

    function WebEdit()
        set nolist
        set wrap
        set linebreak
        map j gj
        map k gk
    endfunction
    command We call WebEdit()
]])

return {}

-- vim: sw=4
