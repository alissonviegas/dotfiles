execute pathogen#infect()
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

autocmd FileType ruby  setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType eruby setlocal expandtab shiftwidth=2 tabstop=2

" Custom colors
highlight Pmenu     ctermbg=0     ctermfg=15     guibg=#000000    guifg=#ffffff
highlight VM_Extend ctermbg=24    ctermfg=237    guibg=#5f8787    guifg=#ffffff
highlight VM_Cursor ctermbg=31    ctermfg=237    guibg=#00af87    guifg=#ffffff
highlight VM_Insert ctermbg=239   ctermfg=237    guibg=#5f0087    guifg=#ffffff
highlight VM_Mono   ctermbg=180   ctermfg=235    guibg=#e05f51    guifg=#ffffff

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
imap <c-b>        <end>byebug<esc>
nmap <c-p>        :Files<cr>
nmap <c-n>        :NERDTreeToggle<cr>
imap <f5>         <esc>gg=G <bar> ``
nmap <f5>         <esc>gg=G <bar> ``
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

" Don't work
nmap <leader>p "+p
nmap <leader>y "+y

" Airline
let ggairline#extensions#tabline#enabled = 1

" Closetag
let g:closetag_filenames = '*.html,*.erb'

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



" -----------------------------------------------------------------------------
" PLUGINS
" -----------------------------------------------------------------------------
" mkdir -p ~/.vim/autoload ~/.vim/bundle && \
" curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
" cd ~/.vim/bundle

" git clone https://github.com/jiangmiao/auto-pairs
" git clone https://github.com/lilydjwg/colorizer
" git clone https://github.com/junegunn/fzf
" git clone https://github.com/junegunn/fzf.vim
" git clone https://github.com/yggdroot/indentline
" git clone https://github.com/tmhedberg/matchit
" git clone https://github.com/scrooloose/nerdtree
" git clone https://github.com/luochen1990/rainbow
" git clone https://github.com/bbatsov/rubocop
" git clone https://github.com/scrooloose/syntastic
" git clone https://github.com/zxqfl/tabnine-vim
" git clone https://github.com/dracula/vim
" git clone https://github.com/vim-airline/vim-airline
" git clone https://github.com/alvan/vim-closetag
" git clone https://github.com/tpope/vim-commentary
" git clone https://github.com/tpope/vim-endwise
" git clone https://github.com/tpope/vim-fugitive
" git clone https://github.com/matze/vim-move
" git clone https://github.com/roxma/vim-paste-easy
" git clone https://github.com/tpope/vim-rails
" git clone https://github.com/ngmy/vim-rubocop
" git clone https://github.com/vim-ruby/vim-ruby
" git clone https://github.com/tpope/vim-surround
" git clone https://github.com/mg979/vim-visual-multi
" git clone https://github.com/valloric/youcompleteme
