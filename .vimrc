call plug#begin()
Plug 'alvan/vim-closetag'
Plug 'bbatsov/rubocop'
Plug 'dracula/vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'lilydjwg/colorizer'
Plug 'luochen1990/rainbow'
Plug 'matze/vim-move'
Plug 'mg979/vim-visual-multi'
Plug 'ngmy/vim-rubocop'
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
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/ruby-matchit'
Plug 'yggdroot/indentline'
Plug 'zxqfl/tabnine-vim'

" https://github.com/ycm-core/YouCompleteMe#linux-64-bit
Plug 'valloric/youcompleteme'
call plug#end()

syntax on
colorscheme dracula

set autoindent
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
set relativenumber
set number
set pastetoggle=<F2>
set shiftwidth=2
set smartcase
set smartindent
set smarttab
set softtabstop=2
set splitright
set termguicolors
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
autocmd User Rails nmap <buffer> gf :tab sfind <Plug><cfile><CR>
imap <c-b>        debugger<esc><esc>:w<cr>
imap <c-f>        # frozen_string_literal: true<cr>
nmap <c-n>        :NERDTreeToggle<cr>
nmap <c-p>        :Files<cr>
nmap <f10>        :call CloseAllBuffersButCurrent()<cr>
nmap <f12>        :call LeftMarginToggle()<cr>
nmap <f3>         :Rag<space>
nmap <f5>         mmgg=G'm
nmap <f9>         :set relativenumber!<cr>
nmap <leader>/    /<c-r><c-w>
nmap <leader>S    :cfdo ,$s/<c-r><c-w>//g \| update<left><left><left><left><left><left><left><left><left><left><left>
nmap <leader>m    :call MouseToggle()<cr>
nmap <leader>s    :,$s/<c-r><c-w>//gc<left><left><left>
nmap <s-pagedown> :bnext<cr>
nmap <s-pageup>   :bprevious<cr>
vmap <s-y>        :w !xclip -selection clipboard<cr><cr> \| :echohl WarningMsg \| :echo 'Visual selection copied to system clipboard' \| :echohl NoneMsg<cr>

" Disabling keys
nmap <del> <nop>
vmap <del> <nop>

" Repeat remaps .
silent! call repeat#set('\<Plug>MyWonderfulMap', v:count)

" Airline
let g:airline_symbols = {}
let g:airline_symbols.branch    = '⎇ '
let g:airline_symbols.colnr     = '℅ :'
let g:airline_symbols.maxlinenr = ' '

" Closetag
let g:closetag_filenames = '*.html,*.erb'

" Hardtime
let g:hardtime_default_on = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_motion_with_count_resets = 1
let g:hardtime_ignore_buffer_patterns = [ 'NERD.*' ]

" IndentLine_char
let g:indentLine_char = '¦'

" Move
let g:move_key_modifier = 'C'
let g:move_key_modifier_visualmode = 'C'

" NERDTree
let g:NERDTreeWinSize = winwidth(0) / 3
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

" Visual-multi
let g:VM_highlight_matches = 'red'
let g:VM_maps = {}
let g:VM_maps['Find Subword Under'] = '<c-d>'
let g:VM_maps['Find Under']         = '<c-d>'
let g:VM_show_warnings = 0
let g:VM_theme = 'paper'

" Rainbow
let g:rainbow_active = 1

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

" " WSL yank support
" let s:clip = '/mnt/c/Windows/System32/clip.exe'
" if executable(s:clip)
"   augroup WSLYank
"     autocmd!
"     autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
"   augroup END
" endif

" Activate ag_raw
command! -bang -nargs=+ -complete=dir Rag call fzf#vim#ag_raw(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

" Functions
function! MouseToggle()
  echohl WarningMsg
  if &mouse == 'a'
    set mouse=
    echo 'Mouse disabled'
  else
    set mouse=a
    echo 'Mouse enabled'
  endif
  echohl NoneMsg
endfunc

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
      \ "app/decorators/*_decorator.rb": {
      \   "command": "decorator",
      \   "affinity": "model",
      \   "template": "# frozen_string_literal: true\n\nclass {camelcase|capitalize|colons}Decorator < SimpleDelegator\nend"
      \ },
      \ "app/enumerations/*.rb": {
      \   "command": "enumeration",
      \   "affinity": "model",
      \   "template": "# frozen_string_literal: true\n\nclass {camelcase|capitalize|colons} < EnumerateIt::Base\n\  associate_values(\n  )\nend"
      \ },
      \ "app/inputs/*_input.rb": {
      \   "command": "input"
      \ },
      \ "app/javascript/*.js": {
      \   "command": "javascript"
      \ },
      \ "app/options/*_option.rb": {
      \   "command": "option",
      \   "template": "# frozen_string_literal: true\n\nclass {camelcase|capitalize|colons}Option\nend"
      \ },
      \ "app/presenters/*_presenter.rb": {
      \   "command": "presenter",
      \   "affinity": "model",
      \   "template": "# frozen_string_literal: true\n\nclass {camelcase|capitalize|colons}Presenter < ApplicationPresenter\n  def content\n  end\nend"
      \ },
      \ "app/queries/*_query.rb": {
      \   "command": "query",
      \   "affinity": "model",
      \   "template": "# frozen_string_literal: true\n\nclass {camelcase|capitalize|colons}Query < ApplicationQuery\n  def query\n  end\nend"
      \ },
      \ "app/services/*_service.rb": {
      \   "command": "service",
      \   "template": "# frozen_string_literal: true\n\nclass {camelcase|capitalize|colons}Service\nend"
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
