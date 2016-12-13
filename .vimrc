let mapleader = ","
let g:mapleader = ","
let g:solarized_termtrans = 1
let g:solarized_bold=0
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
let g:indentLine_char = '┆'
let g:indentLine_color_term = 235
let g:gitgutter_map_keys = 0
let g:ag_working_path_mode="r"
let g:ctrlp_use_caching = 0
let g:CommandTMaxHeight = 0


execute pathogen#infect()
syntax enable
set background=dark
colorscheme solarized
:set relativenumber
:set number
:set cursorline
:set tabstop=2 shiftwidth=2 expandtab softtabstop=2
:set path=$PWD/**
:imap jj <Esc>
:filetype plugin on
:set backspace=2
:set cindent
:set smartindent
:set laststatus=2
:set splitright
:set hlsearch
:set incsearch
:set timeout timeoutlen=1000 ttimeoutlen=100
:set ignorecase smartcase
:set nojoinspaces
:set autoread
:set noswapfile
:set ignorecase
:set smartcase
:set colorcolumn=100
:set lazyredraw
:set clipboard=unnamed

let g:dbext_default_profile_mySQL = 'type=MYSQL:user=root'

au BufReadPost *.hbs set syntax=mustache

" :set statusline+=Filename:\ %F\ Current:\ %4l\ Total:\ %4L
set rtp+=$HOME/Library/Python/2.7/lib/python/site-packages/powerline/bindings/vim

set wildignore=*.swp,*.bak,*.pyc,*.class,*.jar,*.gif,*.png,*.jpg,public/**,vendor/**,tmp/**,node_modules/**,bower_components/**,dist/**,.gitkeep,target/**

nmap <silent> <leader>/ :nohlsearch<CR>

nmap <leader>f :CommandT <CR>
nmap <leader>a :A <CR>

nmap sj :SplitjoinSplit<cr>
nmap sk :SplitjoinJoin<cr>

nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-j> <c-w>j

nnoremap K :Ag! "\b<C-R><C-W>\b"<CR>
vnoremap K y :Ag! '<C-R>"'<CR>
nnoremap \ :Ag!<SPACE>

nmap <leader>c :let @+ = expand("%")<CR>

nnoremap gr :!git grep

function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction

autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()
autocmd filetype crontab setlocal nobackup nowritebackup

autocmd BufRead *.sql set filetype=mysql
autocmd BufRead *.test set filetype=mysql

autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap <expr> %% expand('%:h').'/'
map <leader>e :edit %%
map <leader>v :vs %%

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>n :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '^app/') != -1
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.e\?rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  endif
  return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>

function! FocusOnFile()
  only
  vs %
  normal! v
  normal! l
  call OpenTestAlternate()
  normal! h
endfunction
nnoremap <leader>s :call FocusOnFile()<cr>

function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

set runtimepath^=~/.vim/bundle/ag

if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif
