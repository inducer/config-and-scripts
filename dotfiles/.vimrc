" {{{ vim-plug

set nocompatible               " be iMproved

call plug#begin('~/.vim/plugged')

" file type stuff
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'jceb/vim-orgmode'
"Plug 'plasticboy/vim-markdown'
" Plug 'nelstrom/vim-markdown-folding'
Plug 'lark-parser/vim-lark-syntax'

Plug 'editorconfig/editorconfig-vim'

" General usefulness
if $AK_IS_TERMUX != "1"
  " Plug 'w0rp/ale'
  " Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

  Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarnpkg install --frozen-lockfile'}
endif
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-speeddating'

" if !has('nvim')
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif
" Plug 'Shougo/deoplete.nvim'

Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/Mark'
" Plug 'simnalamburt/vim-mundo'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'

" Plug 'pandysong/ghost-text.vim'

" color schemes
Plug 'junegunn/seoul256.vim'
Plug 'jonathanfilip/vim-lucius'
Plug 'altercation/vim-colors-solarized'

" Plug 'tpope/vim-speeddating'

if isdirectory(expand("$HOME/shared/pack/fzf"))
  Plug '~/shared/pack/fzf'
else
  Plug '~/pack/fzf'
endif

Plug 'junegunn/fzf.vim'

Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'easymotion/vim-easymotion'

" Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'matze/vim-tex-fold'
Plug 'kevinoid/vim-jsonc'

Plug 'Yggdroot/indentLine'

" Plug 'majutsushi/tagbar'

call plug#end()

" }}}

" {{{ autocmds

au BufRead,BufNewFile SConscript set filetype=python
au BufRead,BufNewFile SConstruct set filetype=python
au BufRead,BufNewFile *.mac set filetype=maxima
au BufRead,BufNewFile *.cpy set filetype=python
au BufRead,BufNewFile *.cu set filetype=c
au BufRead,BufNewFile *.cl set filetype=c
au BufRead,BufNewFile *.ocl set filetype=c
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.pyf set filetype=fortran
au BufRead,BufNewFile *.tikz set filetype=tex
au BufRead,BufNewFile *.floopy set filetype=floopy
au BufRead,BufNewFile *.occa set filetype=c
au FileType python setlocal shiftwidth=4
au FileType pyrex setlocal shiftwidth=4
au FileType pyopencl setlocal shiftwidth=4
au FileType lua setlocal shiftwidth=4
au FileType rst setlocal shiftwidth=4
au FileType yaml setlocal shiftwidth=4
au FileType markdown setlocal shiftwidth=4
au FileType yaml setlocal indentexpr=
au FileType yaml setlocal indentkeys=
au FileType tex setlocal indentexpr=
au FileType tex setlocal indentkeys=
au FileType mail setlocal spell
au FileType javascript setlocal shiftwidth=2
au FileType html setlocal shiftwidth=2
au FileType jinja.html setlocal shiftwidth=2
au BufRead,BufNewFile *.tex setlocal textwidth=70
au BufRead,BufNewFile *.tex setlocal formatoptions+=tcql
au BufRead,BufNewFile *.tex setlocal spell

au BufRead,BufNewFile *.py highlight jediFat ctermbg=Grey guibg=Grey ctermfg=Black guifg=Black
au BufRead,BufNewFile *.py highlight jediFunction ctermbg=Grey guibg=Grey ctermfg=Black guifg=Black

" go back to last position
autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal g'\"" |
      \ endif

" au QuickFixCmdPre * wa

" }}}

" {{{ custom commands

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
command De set spelllang=de

function! UnspaceParentheses()
  :0,$s/( /(/g
  :0,$s/ )/)/g
endfunction

function! FillWith(ch)
  let s:line_no = line(".")
  let s:current_line = getline(s:line_no)
  while strlen(s:current_line) < 79
    let s:current_line = s:current_line . a:ch
  endwhile
  call setline(s:line_no,s:current_line)
endfunction

map __ :call FillWith("-")<enter>
map ## :call FillWith("#")<enter>

" }}}

" {{{ options

syntax enable
syntax sync minlines=1000

try
  set list listchars=tab:»\ ,trail:·,nbsp:·
catch /.*/
  set nolist
endtry

set number
set guifont=Iosevka\ Term\ Regular\ 13
set nowrap
set softtabstop=4
set backspace=indent,eol,start
set scrolljump=6
set autoindent
set showcmd
set incsearch
set showmode
set ruler
set showmatch
set hlsearch
set ignorecase
set smartcase
set title
set pastetoggle=<F2>
set laststatus=2
set cursorline
set nostartofline
set confirm
set mouse=a
set encoding=utf-8

set expandtab
set smarttab
set linebreak
set showbreak=>\

set selection=exclusive
set scrolloff=5
set colorcolumn=85

set mps+=<:>

set backup
set hidden
set confirm
set winaltkeys=no
set guioptions=aeimgT
let &guicursor = &guicursor . ",a:blinkon0"
set wildmode=longest:list,full
set wildmenu
set wildignore+=*.so,*.swp,*.zip,*.pyc,.git
" remember 100 files, /tmp and /mnt are removable media
set viminfo='100,\"50,r/tmp,r/mnt

"set path+=/home/andreas/dam/research/software/**
"set path+=/home/andreas/src/**
"set runtimepath+=/usr/share/vim/addons
let $PYTHONWARNINGS=''

if has("nvim")
  set termguicolors
else
  set t_Co=256
endif

" https://github.com/kovidgoyal/kitty#using-a-color-theme-with-a-background-color-does-not-work-well-in-vim
let &t_ut=''

if has("persistent_undo") && isdirectory(expand("$HOME/.vim-undodir"))
  set undodir=~/.vim-undodir
  set undofile
  set undoreload=10000 "maximum number lines to save for undo on a buffer reload
else
  echo "~/.vim-undodir not present; maybe create it?"
endif

set grepprg=git\ grep\ -n
set foldtext=getline(v:foldstart)
set formatoptions+=j

let g:markdown_folding = 1

" suggested by coc.nvim
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" suggested by coc.nvim
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set signcolumn=number

" }}}

" {{{ package options

let g:NERDTreeWinSize=45

let python_highlight_all = 1

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
"nmap s <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-s2)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

hi link EasyMotionTarget ErrorMsg
hi EasyMotionShade ctermfg=gray
"hi Number ctermfg=blue
"hi String ctermfg=blue
hi link EasyMotionTarget2First ErrorMsg
hi link EasyMotionTarget2Second ErrorMsg

" JK motions: Line motions
map <C-j> <Plug>(easymotion-j)
map <C-k> <Plug>(easymotion-k)

"autoclose last nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeIgnore=['\.egg-info$', '^__pycache__$', '^dist$', '^build$', '\.pyc$', '\~$']

let g:netrw_list_hide='.*\.pyc$,.*\~$,^\.'
" let g:pyflakes_use_quickfix = 0
let g:c_no_bracket_error = 1
let g:tex_nospell = 0

let g:deoplete#enable_at_startup = 1

let g:ycm_add_preview_to_completeopt = 1
" let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_filetype_blacklist = {
  \ 'tex' : 1,
  \ 'yaml' : 1,
  \ 'markdown' : 1
  \ }
let g:ycm_filetype_specific_completion_to_disable = {
  \ 'python' : 1,
  \ 'tex' : 1,
  \ }
let g:ycm_complete_in_comments = 1
" let g:ycm_server_keep_logfiles = 1
let g:ycm_min_num_of_chars_for_completion = 3
" let g:ycm_server_log_level = 'debug'

let g:syntastic_rst_checkers = []
"let g:syntastic_python_checkers = ['flake8', 'pylint']
let g:syntastic_filetype_map = {'pyopencl': 'python'}

let g:ale_linter_aliases = {'pyopencl': 'python'}
let g:ale_linters = {'python': ['flake8'], 'pyopencl': ['flake8']}
"let g:ale_linters = {'python': ['flake8', 'pylint'], 'pyopencl': ['flake8']}
let g:ale_lint_on_text_changed = 'never'
"let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"let g:ale_python_pylint_executable = expand("$HOME/bin/pylint-dev")

let g:syntastic_always_populate_loc_list=1
let g:syntastic_check_on_open=1
" let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' , 'cocstatus'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'cocstatus': 'coc#status'
      \ },
      \ }

let g:LatexBox_quickfix=2
"let g:LatexBox_latexmk_preview_continuously=1
"let g:LatexBox_latexmk_async=1
let g:LatexBox_build_dir='./out'

let g:limelight_conceal_ctermfg = 'gray'
"let g:limelight_conceal_ctermfg = 240

let g:limelight_conceal_guifg = 'DarkGray'
"let g:limelight_conceal_guifg = '#777777'
"
if exists('$TMUX') && (stridx($TMUX, 'tmate') == -1)
  let g:fzf_layout = { 'tmux': '-p90%,60%' }
else
  " let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
  let g:fzf_layout = { 'down': '40%' }
endif

let g:goyo_width = 120

function! s:goyo_enter()
  silent !tmux set status off
  " silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  " set scrolloff=999
  Limelight 0.7
  "call deoplete#disable()
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  " silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  Limelight!
  "call deoplete#enable()
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" {{{ airline symbols

" let g:airline_powerline_fonts=1
"

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if $AK_IS_TERMUX != "1"
  " unicode symbols
  let g:airline_left_sep = '»'
  let g:airline_left_sep = '▶'
  let g:airline_right_sep = '«'
  let g:airline_right_sep = '◀'
  let g:airline_symbols.crypt = '🔒'
  let g:airline_symbols.linenr = '␊'
  let g:airline_symbols.linenr = '␤'
  let g:airline_symbols.linenr = '¶'
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'ρ'
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.paste = '∥'
  let g:airline_symbols.spell = 'Ꞩ'
  let g:airline_symbols.notexists = '∄'
  let g:airline_symbols.whitespace = 'Ξ'
endif

" }}}

" let g:solarized_degrade=1
" let g:solarized_termtrans=1
" let g:solarized_termcolors=256

syntax enable

" colorscheme solarized
" colorscheme seoul256
colorscheme lucius

if $TERMINAL_LIGHTNESS == "light"
  set background=light
else
  set background=dark
endif

" }}}

" {{{ keyboard mappings

nnoremap <C-L> :nohl<CR><C-L>
map /  <Plug>(incsearch-stay)

map ?  <Plug>(incsearch-backward)
map <leader>/ <Plug>(incsearch-forward)

map z/  <Plug>(incsearch-fuzzy-stay)
map z?  <Plug>(incsearch-fuzzy-?)
map <leader>z/ <Plug>(incsearch-fuzzy-/)

map g/ <Plug>(incsearch-easymotion-stay)
map g? <Plug>(incsearch-easymotion-?)
map <leader>g/ <Plug>(incsearch-easymotion-/)

map <leader>w <Plug>(easymotion-bd-w)

function! ToggleBackground()
  if &background == "light"
    set background=dark
  else
    set background=light
  endif
endfunction

map Q @q
map gf :e <cfile><CR>
nnoremap * *``
map <f9> :make<enter>
map <f5> :cprevious<enter>
map <f6> :cnext<enter>

map <leader>Q :lrewind<enter>
map <leader>B :call ToggleBackground()<enter>
map <leader>q :lnext<enter>
map <leader>s :ALEToggle<enter>
map <leader>id :read !date +"\%Y-\%m-\%d \%H:\%M"<enter>
map <leader>t :NERDTreeToggle<CR>
map <leader>g :Goyo<CR>
map <leader>T :GhostTextStart<CR>

au BufRead *.tex execute "nmap ZE :! synctex-katarakt-vim " . v:servername . " 2>/dev/null >/dev/null  &<LEFT><LEFT>"

" fzf

nnoremap <leader>f :GFiles<cr>
nnoremap <leader>F :Files ~/src<cr>
nnoremap <leader>H :Files ~/<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>A :Ag<cr>

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

nnoremap <leader>G :GGrep<cr>

nnoremap <Leader>c :set cursorline!<CR>

nnoremap <BS> {
onoremap <BS> {
vnoremap <BS> {

nnoremap <expr> <CR> empty(&buftype) ? '}' : '<CR>'
onoremap <expr> <CR> empty(&buftype) ? '}' : '<CR>'
vnoremap <CR> }

" {{{ coc

function! s:check_back_space() abort
          let col = col('.') - 1
            return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" 
" inoremap <silent><expr> <c-@> coc#refresh()

" Do default action for next item.
nnoremap <silent><nowait> <S-f6>  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <S-f5>  :<C-u>CocPrev<CR>

" }}}

" }}}

" {{{ highlighting

"highlight IncSearch guibg=yellow
"highlight SpellBad ctermbg=Red gui=undercurl guisp=Red
hi link rstEmphasis Normal

"highlight FoldColumn guibg=gray90 guifg=black
"highlight clear SpellBad
"highlight NonText guibg=Gray

hi link SyntasticErrorSign ErrorMsg

autocmd ColorScheme * hi SignColumn ctermbg=darkgray guibg='Gray'

" {{{ https://stsievert.com/blog/2016/01/06/vim-jekyll-mathjax/

function! MathAndLiquid()
    "" Define certain regions
    " Block math. Look for "$$[anything]$$"
    syn region math start=/\$\$/ end=/\$\$/
    " inline math. Look for "$[not $][anything]$"
    syn match math_block '\$[^$].\{-}\$'

    " Liquid single line. Look for "{%[anything]%}"
    syn match liquid '{%.*%}'
    " Liquid multiline. Look for "{%[anything]%}[anything]{%[anything]%}"
    syn region highlight_block start='{% highlight .*%}' end='{%.*%}'
    " Fenced code blocks, used in GitHub Flavored Markdown (GFM)
    syn region highlight_block start='```' end='```'

    "" Actually highlight those regions.
    hi link math Statement
    hi link liquid Statement
    hi link highlight_block Function
    hi link math_block Function
endfunction

" Call everytime we open a Markdown file
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call MathAndLiquid()

" }}}

" }}}

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

" {{{ coc

" :CocInstall coc-pyright
" :CocInstall coc-tsserver
" :CocInstall coc-json
" :CocInstall coc-diagnostic
" :CocInstall coc-eslint

" Some servers have issues with backup files, see #649.
" set nobackup
" set nowritebackup

" Give more space for displaying messages.
" set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" " Always show the signcolumn, otherwise it would shift the text each time
" " diagnostics appear/become resolved.
" if has("nvim-0.5.0") || has("patch-8.1.1564")
"   " Recently vim can merge signcolumn and number column into one
"   set signcolumn=number
" else
"   set signcolumn=yes
" endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"
"

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" }}}

" vim: foldmethod=marker
