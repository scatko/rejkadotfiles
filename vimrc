" Installing Plug for vim
if empty(glob('~/.vim/autoload/plug.vim'))
  echo "installing Plug for vim"
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Installing Plug for neovim
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  echo "installing Plug for neovim"
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Plug itself
Plug 'junegunn/vim-plug'

" vim start screen
Plug 'mhinz/vim-startify'

" Editor config
Plug 'editorconfig/editorconfig-vim'

" nerdtree - file tree viewer
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }

" nerdcommenter - comminting
Plug 'scrooloose/nerdcommenter'

" Indents
Plug 'nathanaelkane/vim-indent-guides'
Plug 'Yggdroot/indentLine'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'cohama/agit.vim'

" colors
" Plug 'arcticicestudio/nord-vim'
" Plug 'NLKNguyen/papercolor-theme'
" Plug 'w0ng/vim-hybrid'
" Plug 'morhetz/gruvbox'
" Plug 'rakr/vim-one'
" Plug 'ayu-theme/ayu-vim'
Plug 'chriskempson/base16-vim'

" Syntax highlights for many languages
Plug 'sheerun/vim-polyglot'

" CSS
Plug 'ap/vim-css-color', { 'for': ['css', 'scss', 'javascript'] }

" JavaScript
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'othree/es.next.syntax.vim', { 'for': 'javascript' }

" Ruby
Plug 'dermusikman/sonicpi.vim', { 'for': 'ruby' }

" Clojure
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-classpath', { 'for': 'clojure' }
Plug 'kien/rainbow_parentheses.vim', { 'for': 'clojure' }

" Processing
Plug 'sophacles/vim-processing', { 'for': 'processing' }

" csound
Plug 'luisjure/csound', { 'for': 'csound' }

" SuperCollider
Plug 'sbl/scvim', { 'for': 'scd' }
Plug 'munshkr/vim-tidal', { 'for': 'haskell' }

" vim-halo
Plug 'mhinz/vim-halo'

" Airline - status bar
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" ctrlp - search
Plug 'kien/ctrlp.vim'

" Prettier - file formatting
Plug 'w0rp/ale'

" Markdown preview for macos
if has('mac')
  Plug 'junegunn/vim-xmark'
endif

" Initialize plugin system
call plug#end()

set re=1

" Encoding
set encoding=utf-8
set fileencodings=utf-8,cp-1251

set ttm=100
set ttyfast

" colors
syntax on
set t_Co=256
" colorscheme one
set background=dark
colorscheme base16-default-dark
" colorscheme PaperColor
set termguicolors     " enable true colors support
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
" colorscheme ayu

" UI
set number
set ruler
set colorcolumn=80
set textwidth=80
set linebreak
set autoindent
set smartindent
set cursorline
set tabstop=2
set shiftwidth=2
set expandtab
" let g:indent_guides_enable_on_vim_startup = 1

" Unprintable characters
" set list
set listchars=tab:▸\ ,eol:⏎,trail:␠,extends:❯,precedes:❮,nbsp:·,space:·
" F3: Toggle list (display unprintable characters).
" https://stackoverflow.com/questions/12534313/vim-set-list-as-a-toggle-in-vimrc
nnoremap <F3> :set list!<CR>

" search
set showmatch
set hlsearch
set incsearch
set ignorecase

" syntax complete
filetype plugin indent on     " required!
filetype plugin on
set omnifunc=syntaxcomplete#Complete
"Use TAB to complete when typing words, else inserts TABs as usual.
"Uses dictionary and source files to find matching words to complete.

"See help completion for source,
"Note: usual completion is on <C-n> but more trouble to press all the time.
"Never type the same word twice and maybe learn a new spellings!
"Use the Linux dictionary when spelling is in doubt.
"Window users can copy the file to their machine.
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
:set dictionary="/usr/dict/words"

" macos clipboard
set clipboard=unnamed

" mouse scroll
set mouse=a
if has("mouse_sgr")
  set ttymouse=sgr
elseif !has('nvim')
  set ttymouse=xterm2
endif

" NERDTree
nmap <Bs> :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=2
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=0
let NERDTreeMinimalUI=1 " Disables display of the 'Bookmarks' label and 'Press ? for help' text.
let NERDTreeDirArrows=1 " Tells the NERD tree to use arrows instead of + ~ chars when displaying directories.
let NERDTreeBookmarksFile= $HOME . '/.vim/.NERDTreeBookmarks'

" ctrlp
let g:ctrlp_custom_ignore = '\v[\/](node_modules)|(\.(swp|git))'

" ale (prettier) config
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['html'] = ['tidy']
let g:ale_fixers['vue'] = ['prettier']
let g:ale_fixers['css'] = ['prettier']
let g:ale_fixers['scss'] = ['prettier']
let g:ale_fix_on_save = 1
"let g:ale_javascript_prettier_options = '--print-width 120 --no-semi --single-quote --parser babylon'
let g:ale_javascript_prettier_use_local_config = 1

let g:airline#extensions#ale#enabled = 1
let g:airline_theme = 'base16_default'

" vim-jsx (react installed via polyglot)
let g:jsx_ext_required = 0

" vim-vue (installed via polyglot)
let g:vue_disable_pre_processors=1

" sonic-pi
let g:sonicpi_command = 'sonic-pi-tool'
let g:sonicpi_send = 'eval-stdin'
let g:sonicpi_stop = 'stop'
let g:vim_redraw = 1

noremap <leader>r :silent w !sonic-pi-tool eval<CR>

map <F8> :Ggrep <cword><CR>
