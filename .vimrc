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
Plug 'pacha/vem-tabline'
Plug 'roxma/vim-paste-easy'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'takac/vim-hardtime'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-ruby/vim-ruby'
Plug 'yggdroot/indentline'

" https://github.com/ycm-core/YouCompleteMe#linux-64-bit
Plug 'valloric/youcompleteme'
call plug#end()

syntax on
colorscheme dracula

set autoindent
set background=dark
set clipboard=unnamedplus
set colorcolumn=80
set cursorline
set encoding=utf-8
set fileencoding=utf-8
set ignorecase
set incsearch
set list
set listchars=tab:→·,trail:~
set mouse=a
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

autocmd InsertEnter *.{markdown,md} set conceallevel=0
autocmd InsertLeave *.{markdown,md} set conceallevel=2

" Custom colors
highlight Pmenu        ctermbg=0     ctermfg=15     guibg=#000000    guifg=#ffffff
highlight TabLineSel   ctermbg=0     ctermfg=15     guibg=#000000    guifg=#ffffff
highlight VM_Extend    ctermbg=24    ctermfg=237    guibg=#5f8787    guifg=#ffffff
highlight VM_Cursor    ctermbg=31    ctermfg=237    guibg=#00af87    guifg=#ffffff
highlight VM_Insert    ctermbg=239   ctermfg=237    guibg=#5f0087    guifg=#ffffff
highlight VM_Mono      ctermbg=180   ctermfg=235    guibg=#e05f51    guifg=#ffffff

" Cursor width
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Search highlight
augroup vimrc-incsearch-highlight
  autocmd!
  autocmd CmdlineEnter [/\?] :set hlsearch
  autocmd CmdlineLeave [/\?] :set nohlsearch
  autocmd CmdlineEnter [:]   :set hlsearch
  autocmd CmdlineLeave [:]   :set nohlsearch
augroup end

" Mapping
imap <c-space>    <end><%= %><left><left><left>
imap <c-b>        debugger
nmap <c-p>        :Files<cr>
nmap <c-n>        :NERDTreeToggle<cr>
imap <f5>         <esc>mmgg=G'm
nmap <f5>         mmgg=G'm
nmap <f9>         :set relativenumber!<cr>
nmap <f10>        :call CloseAllBuffersButCurrent()<cr>
nmap <f12>        :call LeftMarginToggle()<cr>
nmap <leader>m    :call MouseToggle()<cr>
nmap <leader>s    :,$s/<c-r><c-w>//gc<left><left><left>
nmap <leader>/    /<c-r><c-w>
nmap <s-pagedown> :bnext<cr>
nmap <s-pageup>   :bprevious<cr>

" Disabling keys
nmap <del> <nop>
vmap <del> <nop>

" Airline
let ggairline#extensions#tabline#enabled = 1

" Closetag
let g:closetag_filenames = '*.html,*.erb'

" Hardtime
let g:hardtime_default_on = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_ignore_buffer_patterns = [ "NERD.*" ]
let g:hardtime_maxcount = 5

" IndentLine_char
let g:indentLine_char = '¦'

" Move
let g:move_key_modifier = 'C'

" NERDTree
let g:NERDTreeWinSize = winwidth(0) / 3

" Rainbow
let g:rainbow_active = 1

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

" Visual-multi
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<c-d>'
let g:VM_maps['Find Subword Under'] = '<c-d>'
let g:VM_show_warnings = 0
let g:VM_theme_set_by_colorscheme = 1

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
  augroup WSLYank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
  augroup END
endif



" -----------------------------------------------------------------------------
" FUNCTIONS
" -----------------------------------------------------------------------------
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
