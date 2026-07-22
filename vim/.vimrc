call plug#begin()
Plug 'alvan/vim-closetag'
Plug 'bbatsov/rubocop'
Plug 'dracula/vim'
Plug 'houtsnip/vim-emacscommandline'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'lilydjwg/colorizer'
Plug 'luochen1990/rainbow'
Plug 'mattn/vim-lsp-settings'
Plug 'matze/vim-move'
Plug 'mg979/vim-visual-multi'
Plug 'ngmy/vim-rubocop'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'roxma/vim-paste-easy'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'takac/vim-hardtime'
Plug 'thanhkhoait/git-message.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-ruby/vim-ruby'
Plug 'yggdroot/indentline'
call plug#end()

syntax on
colorscheme dracula

set autoindent
set autoread
set background=dark
set clipboard=unnamed
set colorcolumn=80
set cursorline
set encoding=utf-8
set fileencoding=utf-8
set ignorecase
set incsearch
set list
set listchars=tab:→·,trail:~
set nobackup
set noswapfile
set number
set pastetoggle=<F2>
set relativenumber
set shiftwidth=2
set signcolumn=no
set smartcase
set smartindent
set smarttab
set softtabstop=2
set splitright
set termguicolors
set updatetime=1000
set wildmenu

filetype on
filetype indent on
filetype plugin indent on

autocmd FileType help  wincmd L
autocmd FileType ruby  setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType eruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType eruby let b:AutoPairs = AutoPairsDefine({'<%' : '%>', '<%=' : '%>'})

autocmd InsertEnter *.{markdown,md} set conceallevel=0
autocmd InsertLeave *.{markdown,md} set conceallevel=2

" Auto update
autocmd FocusGained,BufEnter * checktime
autocmd VimEnter * call timer_start(1000, {-> execute('checktime')}, {'repeat': -1})

" Cursor width
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Custom colors
highlight Normal     ctermbg=NONE         guibg=NONE
highlight Pmenu      ctermbg=0 ctermfg=15 guibg=#000000 guifg=#ffffff
highlight TabLineSel ctermbg=0 ctermfg=15 guibg=#000000 guifg=#ffffff

" Search highlight
augroup vimrc-incsearch-highlight
  autocmd!
  autocmd CmdlineEnter [/\?] :set hlsearch
  autocmd CmdlineLeave [/\?] :set nohlsearch
  autocmd CmdlineEnter [:]   :set hlsearch
  autocmd CmdlineLeave [:]   :set nohlsearch
augroup end

" Mapping
autocmd User Rails nmap <buffer> gf :tab sfind <Plug><cfile><cr>
inoremap <c-b>     debugger<esc><esc>:w<cr>
inoremap <c-f>     # frozen_string_literal: true<cr>
nnoremap <c-f>     :Rrg<space>
nnoremap <c-n>     :NERDTreeToggle<cr>
nnoremap <c-p>     :Files<cr>
nnoremap <f10>     :call CloseAllBuffersButCurrent()<cr>
nnoremap <f12>     :call LeftMarginToggle()<cr>
nnoremap <f5>      mmgg=G'm
nnoremap <leader>/ /<c-r><c-w>
nnoremap <leader>S :cfdo ,$s/<c-r><c-w>//g \| update<left><left><left><left><left><left><left><left><left><left><left>
nnoremap <leader>[ :bprevious<cr>
nnoremap <leader>] :bnext<cr>
nnoremap <leader>s :,$s/<c-r><c-w>//gc<left><left><left>
vnoremap <s-y>     :w !xclip -selection clipboard<cr><cr> \| :echohl WarningMsg \| :echo 'Visual selection copied to system clipboard' \| :echohl NoneMsg<cr>

" Disabling keys
nnoremap <del> <nop>
vnoremap <del> <nop>

" Repeat remaps .
silent! call repeat#set('\<Plug>MyWonderfulMap', v:count)

" Airline
let g:airline_symbols = {}
let g:airline_symbols.branch    = '⎇ '
let g:airline_symbols.colnr     = '℅ :'
let g:airline_symbols.maxlinenr = ' '

" Asyncomplete
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_min_chars  = 1

call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
\ 'name': 'buffer',
\ 'whitelist': ['*'],
\ 'completor': function('asyncomplete#sources#buffer#completor'),
\ }))

" Confirm the highlighted completion with <CR>. Chains onto whatever <CR>
" already does (auto-pairs, endwise) when the popup isn't visible, since
" those set their own buffer-local <CR> mapping on FileType.
"
" maparg() on an <expr> mapping returns the *expression text*, not its
" evaluated result, so it can't just be returned from our own <expr>
" mapping (that inserts the text itself, literally, as typed characters).
" Re-declare it through :execute instead, so <> notation and <expr> get
" parsed by :map like auto-pairs/endwise already do for the same reason.
function! s:AsyncompleteMapCR() abort
  let info = maparg('<CR>', 'i', 0, 1)
  if !empty(info) && get(info, 'rhs', '') =~# 'asyncomplete_cr_fallback'
    return
  endif
  if empty(info)
    let fallback = '<CR>'
  else
    let rhs = substitute(info.rhs, '<SID>', '<SNR>' . info.sid . '_', 'g')
    execute 'inoremap <buffer><script>' . (info.expr ? '<expr>' : '')
          \ . ' <SID>(asyncomplete_cr_fallback) ' . rhs
    let fallback = '<SID>(asyncomplete_cr_fallback)'
  endif
  execute 'inoremap <buffer><script><expr> <CR>'
        \ . ' pumvisible() ? asyncomplete#close_popup() : "\' . fallback . '"'
endfunction

augroup asyncomplete_confirm
  autocmd!
  autocmd FileType * call s:AsyncompleteMapCR()
augroup END

" Navigate the completion popup with <C-j>/<C-k> (no arrow keys on a 60% keyboard)
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Closetag
let g:closetag_filenames = '*.html,*.erb'

" Git-message
let g:gmi#prefix = '➤ '
let g:gmi#time_icon = '•'
let g:gmi#message_icon = '•'

" Hardtime
let g:hardtime_default_on               = 1
let g:hardtime_allow_different_key      = 1
let g:hardtime_motion_with_count_resets = 1
let g:hardtime_ignore_buffer_patterns   = [ 'NERD.*' ]

" IndentLine_char
let g:indentLine_char = '¦'

" LSP
let g:lsp_log_file = ''

" Move
let g:move_key_modifier            = 'S'
let g:move_key_modifier_visualmode = 'S'

" NERDTree
let g:NERDTreeWinSize = winwidth(0) / 3
let g:NERDTreeDirArrowExpandable  = '+'
let g:NERDTreeDirArrowCollapsible = '-'

" Visual-multi
let g:VM_highlight_matches          = 'red'
let g:VM_maps                       = {}
let g:VM_maps['Add Cursor Down']    = '<C-j>'
let g:VM_maps['Add Cursor Up']      = '<C-k>'
let g:VM_maps['Find Subword Under'] = '<C-d>'
let g:VM_maps['Find Under']         = '<C-d>'
let g:VM_show_warnings              = 0
let g:VM_theme                      = 'paper'

" Rainbow
let g:rainbow_active = 1

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list            = 1

" Rrg
command! -bang -nargs=+ -complete=dir Rrg call fzf#vim#grep(
  \ 'rg --column --line-number --no-heading --color=always --smart-case -- '.<q-args>,
  \ 1,
  \ fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}),
  \ <bang>0
  \ )

" Functions
function! LeftMarginToggle()
  let l:name = 'left_magin'
  if bufwinnr(l:name) > 0
    wincmd o
  else
    let l:width = winwidth(0) / 3
    execute 'topleft' l:width . 'vsplit +setlocal\ nobuflisted' l:name | wincmd p
  endif
endfunction

function! CloseAllBuffersButCurrent()
  let curr = bufnr('%')
  let last = bufnr('$')

  if curr > 1    | silent! execute '1,' . (curr-1) . 'bd'       | endif
  if curr < last | silent! execute (curr+1) . ',' . last . 'bd' | endif
endfunction

" Rails projections
let g:rails_projections = {
      \ "app/decorators/*.rb": {
      \   "command": "decorator",
      \   "affinity": "model",
      \   "template": "# frozen_string_literal: true\n\nclass {camelcase|capitalize|colons}Decorator < SimpleDelegator\nend"
      \ },
      \ "app/enumerations/*.rb": {
      \   "command": "enumeration",
      \   "affinity": "model",
      \   "template": "# frozen_string_literal: true\n\nclass {camelcase|capitalize|colons} < EnumerateIt::Base\n\  associate_values(\n  )\nend"
      \ },
      \ "app/inputs/*.rb": {
      \   "command": "input"
      \ },
      \ "app/javascript/*.js": {
      \   "command": "javascript"
      \ },
      \ "app/options/*.rb": {
      \   "command": "option",
      \   "template": "# frozen_string_literal: true\n\nclass {camelcase|capitalize|colons}Option\nend"
      \ },
      \ "app/presenters/*.rb": {
      \   "command": "presenter",
      \   "affinity": "model",
      \   "template": "# frozen_string_literal: true\n\nclass {camelcase|capitalize|colons} < ApplicationPresenter\n  def content\n  end\nend"
      \ },
      \ "app/queries/*.rb": {
      \   "command": "query",
      \   "affinity": "model",
      \   "template": "# frozen_string_literal: true\n\nclass {camelcase|capitalize|colons}Query < ApplicationQuery\n  def call\n  end\nend"
      \ },
      \ "app/services/*.rb": {
      \   "command": "service",
      \   "template": "# frozen_string_literal: true\n\nclass {camelcase|capitalize|colons}Service\nend"
      \ },
      \ "app/validators/*.rb": {
      \   "command": "validator",
      \   "affinity": "model",
      \   "template": "# frozen_string_literal: true\n\nclass {camelcase|capitalize|colons}Validator < ActiveModel::EachValidator\n  def validate_each(record, attribute, value)\n  end\nend"
      \ },
      \ "config/routes.rb": {
      \   "command": "routes"
      \ },
      \ "config/routes/*.rb": {
      \   "command": "routes"
      \ },
      \ "db/seeds.rb": {
      \   "command": "seeds"
      \ },
      \ "spec/factories/*.rb": {
      \   "command": "factory",
      \   "affinity": "collection",
      \   "related": "db/schema.rb#%s"
      \ },
      \ "Gemfile": {
      \   "command": "gemfile"
      \ },
      \ "README.md": {
      \   "command": "readme"
      \ }}
