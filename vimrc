set encoding=utf-8
set nocompatible              " be iMproved, required
filetype off                  " required
set backspace=indent,eol,start

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/opt/fzf

call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'majutsushi/tagbar'
Plugin 'Yggdroot/indentLine'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'rbong/vim-flog'
"Plugin 'chazy/cscope_maps'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'mbbill/undotree'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'rust-lang/rust.vim'
"Plugin 'rdnetto/YCM-Generator'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Switch off all auto-indenting
set nocindent
set nosmartindent
set noautoindent
set indentexpr=
filetype indent off
filetype plugin indent off
"

set hlsearch
hi Search ctermbg=LightYellow
hi Search ctermfg=Red

set cursorline
hi CursorLine cterm=none ctermbg=0x444444 ctermfg=none

set cursorcolumn
hi CursorColumn cterm=none ctermbg=0x444444 ctermfg=none

nnoremap <C-K> :call HighlightNearCursor()<CR>
function! HighlightNearCursor()
  if !exists("s:highlightcursor")
    match Todo /\k*\%#\k*/
    let s:highlightcursor=1
  else
    match None
    unlet s:highlightcursor
  endif
endfunction

" the normal keybinding setting
" go to the file explore mode
nnoremap <Space>pv :Ex<CR>
" the F1 for the stupid touchbar
nnoremap <Space>f1 <F1><CR>
" switch bwtween the recent two files
nnoremap <Space>nn :b#<CR>
" clear the search string
nnoremap <Space>sd /a@#$%<CR>
" join several lines together while keeping track of where you started
nnoremap J mzJ`z<CR>
" page up and down and make the cursor in the middle of the screen
nnoremap <C-d> <C-d>zz<CR>
nnoremap <C-u> <C-u>zz<CR>
" search and stay at the middle (the k is used for shift a line back ... I
" don't know why)
nnoremap n jnkzz<CR>
nnoremap N Nkzz<CR>
" move the sellected line up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" able to paste the first yanked itmes again
xnoremap <Leader>p "_dp<CR>
" yank to the clipboard
" yap is to yank whole paragraph
nnoremap <Leader>o o<Esc>0"_Dk<CR>
nnoremap <Leader>O O<Esc>0"_D<CR>
nnoremap <Leader>cp "+p<CR>
nnoremap <Leader>cP "+P<CR>
nnoremap <Leader>y "+y<CR>
nnoremap <Leader>yap "+yap<CR>
vnoremap <Leader>cp "+p<CR>
vnoremap <Leader>cP "+P<CR>
vnoremap <Leader>y "+y<CR>
nnoremap <Leader>Y "+Y<CR>
nnoremap <Leader>% :let @" = expand('%')<CR>
" delete the line and no affecting yank register
nnoremap <Leader>d "_d<CR>
vnoremap <Leader>d "_d<CR>

nnoremap <C-k> <cmd>cnext<CR>zzk<CR>
nnoremap <C-j> <cmd>cprev<CR>zzk<CR>
nnoremap <Space>k <cmd>lnext<CR>zzk<CR>
nnoremap <Space>j <cmd>lprev<CR>zzk<CR>


" for fzf
nnoremap <Space>pf :Files<CR>
nnoremap <Space>pb :Buffers<CR>
nnoremap <Space>pt :Tags<CR>
nnoremap <Space>pg :Commits<CR>
function! FuzzyGrepLocal()
  call inputsave()
  let _string = input("Grep < ")
  call inputrestore()
  execute 'Rg ' . _string
endfunction
nnoremap <Space>ps :call FuzzyGrepLocal()<CR>
nnoremap <C-p> :GFiles<CR>

" for undotree
nnoremap <Space>u :UndotreeToggle<CR>

" for you complete me
nnoremap <Space>gdf :YcmCompleter GoToDefinition<CR>
nnoremap <Space>gdc :YcmCompleter GoToDeclaration<CR>
nnoremap <Space>gg :YcmCompleter GoTo<CR>
nnoremap <Space>dd :YcmShowDetailedDiagnostic<CR>
"nnoremap <Space>gt :YcmCompleter GoToType<CR>
set splitbelow
nmap <Space>gv <plug>(YCMHover)
"let g:ycm_enable_semantic_highlighting=1
let g:ycm_max_num_candidates_to_detail = 0
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_auto_hover = 0
let g:ycm_show_detailed_diag_in_popup = 1
" Use homebrew's clangd
"let g:ycm_clangd_binary_path = trim(system('brew --prefix llvm')).'/bin/clangd'
let g:ycm_clangd_binary_path = exepath("clangd")
let g:ycm_clangd_uses_ycmd_caching = 0
" let g:ycm_global_ycm_extra_conf="~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py"
" highlight YcmWarningSection guibg=Black

set number relativenumber

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
set tags=tags;/
set mouse=a

nmap <Leader>tb :TagbarToggle<CR>      "快捷鍵設定
let g:tagbar_ctags_bin='ctags'          "ctags程式的路徑
let g:tagbar_width=79                  "視窗寬度的設定
let g:tagbar_wrap=1
map <F11> :Tagbar<CR>
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen() "如果是c語言的程式的話，tagbar自動開啟

let g:airline_powerline_fonts = 1
" enable tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
" show tab number in tab line
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#vimtex#left = ""
let g:airline#extensions#vimtex#right = ""
"
set laststatus=2 " Show the statusline
set noshowmode " Hide the default mode text
"  airline symbols dictionary
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
if has("gui_running")
  set guifont=MesloLGSDZForPowerline-Regular:h16
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

set laststatus=2

set colorcolumn=80

syntax on

map <F5> :!cscope -Rbqk<CR>:cs reset<CR><CR>
map <F6> :set csre<CR>

noremap <leader>cs :cs find s
noremap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
noremap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
noremap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
noremap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
noremap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
noremap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
noremap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
noremap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
