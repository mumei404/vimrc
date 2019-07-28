set encoding=utf-8
scriptencoding utf-8

autocmd BufNewFile,BufRead *.{html,htm,vue*} set filetype=html

set background=dark
colorscheme solarized
syntax enable

set incsearch
set ignorecase
set smartcase
set hlsearch
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

set cursorline

set showmatch
source $VIMRUNTIME/macros/matchit.vim

set wildmenu
set history=5000

autocmd QuickFixCmdPost *grep* cwindow

set number
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set nocompatible
set suffixesadd+=.php
set suffixesadd+=.ctp
filetype plugin on
nnoremap j gj
nnoremap k gk
inoremap <?<Enter> <?php  ?><Left><Left><Left>
inoremap <?=<Enter> <?=  ?><Left><Left><Left>
inoremap <%<Enter> <%  %><Left><Left><Left>
inoremap <%=<Enter> <%=  %><Left><Left><Left>
inoremap {!!<Enter> {!!  !!}<Left><Left><Left><Left>
inoremap {<Enter> {}<Left><CR><Esc>==<S-o>
inoremap (<Enter> ()<Left><CR><Esc>==<S-o>
inoremap [<Enter> []<Left><CR><Esc>==<S-o>
inoremap { {}<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap < <><Left>
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap {{ {{<Space><Space>}}<Left><Left><Left>
inoremap <C-l> <Esc><S-i><<Esc><Right>vey<S-a>><Esc>o</<Esc>p<S-a>><Esc><S-o>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

vnoremap " c"<C-r>""<Esc>
vnoremap ' c'<C-r>"'<Esc>
vnoremap ( c(<C-r>")<Esc>
vnoremap { c{<C-r>"}<Esc>
vnoremap [ c[<C-r>"]<Esc>

set rtp+=~/vimPlugin/tabnine-vim


if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim/
	if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
		echo "install NeoBundle..."
		:call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
	endif
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'itchyny/lightline.vim'
set laststatus=2
set showmode
set showcmd
set ruler

NeoBundle 'bronson/vim-trailing-whitespace'

NeoBundle 'Yggdroot/indentLine'

"NeoBundle 'Shougo/neocomplcache.vim'
"NeoBundle 'Shougo/neosnippet'
"NeoBundle 'Shougo/neosnippet-snippets'
"if neobundle#is_installed('neocomplcache.vim')
";let g:neocomplcache_enable_at_startup = 1
";let g:neocomplcache_enable_smart_case = 1
";let g:neocomplcache_min_keyword_length = 3
";let g:neocomplcache_auto_completion_start_length = 1
";let g:neocomplcache_enable_auto_delimiter = 1
";inoremap <expr><BS> neocomplcache#smart_close_popup()."<C-h>"
";imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
";imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
"endif

NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'tacahiroy/ctrlp-funky'
NeoBundle 'suy/vim-ctrlp-commandline'
let g:ctrlp_match_window = 'order:ttb,min:20,max:20,results:100'
let g:ctrlp_show_hidden = 1
let g:ctrlp_types = ['fil']
let g:ctrlp_extensions = ['funky', 'commandline']
command! CtrlPCommandLine call ctrlp#init(ctrlp#commandline#id())
let g:ctrlp_funky_matchtype = 'path'


call neobundle#end()

filetype plugin indent on

NeoBundleCheck
