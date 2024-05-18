" いつもの
set encoding=utf-8
scriptencoding utf-8
syntax enable
set autoread
set number
set noswapfile
set tabstop=2
set shiftwidth=2
set ignorecase
set clipboard=unnamed
set laststatus=2
autocmd QuickFixCmdPost *grep* cwindow

nnoremap j gj
nnoremap k gk
inoremap (*<Enter> (*  *)<Left><Left><Left>
inoremap {<Enter> {}<Left><CR><Esc>==<S-o>
inoremap (<Enter> ()<Left><CR><Esc>==<S-o>
inoremap [<Enter> []<Left><CR><Esc>==<S-o>
inoremap { {}<Left>
inoremap {} {}<Left>
inoremap ( ()<Left>
inoremap () ()<Left>
inoremap [ []<Left>
inoremap [] []<Left>
inoremap < <><Left>
inoremap <> <><Left>
inoremap " ""<Left>
inoremap "" ""<Left>
inoremap ' ''<Left>
inoremap '' ''<Left>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" プラグイン
call plug#begin()
" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" syntaxハイライト
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

" colorscheme
Plug 'NLKNguyen/papercolor-theme'

" statusline
" Plug 'itchyny/lightline.vim'
call plug#end()

" NLKNguyen/papercolor-theme
set background=dark
colorscheme PaperColor

" neoclide/coc.nvim
" tabキーで補完をトリガーし、次の補完アイテムに移動する
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) : 
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" enterキーで選択した補完を適用する
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" デフォルトは4000ms = 4s
set updatetime=300

" エラーに移動
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" エラー解消
nmap <silent> <C-@> <Plug>(coc-codeaction)

" 定義ジャンプ
nmap <silent> <C-]> <Plug>(coc-definition)
" 参照ジャンプ
nmap <silent> <C-[> <Plug>(coc-references)

" ドキュメント表示
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
        else
            call feedkeys('K', 'in')
              endif
              endfunction

" シンボルのハイライト
autocmd CursorHold * silent call CocActionAsync('highlight')

" エラーや警告のハイライト
highlight CocErrorSign ctermfg=15 ctermbg=196
highlight CocWarningSign ctermfg=0 ctermbg=172

" stylelint実行
nnoremap <silent><nowait> <space>l  :!node prepareScssEnv && npx stylelint --cache % --fix<cr>

" coc-lists
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" files
nnoremap <silent><nowait> <C-p> :<C-u>CocList files<CR>

function! StatuslineMode() abort
	let l:currentmode={
				\ 'n': 'NORMAL',
				\ 'v': 'VISUAL',
				\ 'V': 'VISUAL-L',
				\ '^V': 'VISUAL-B',
				\ 's': 'S',
				\ 'S': 'SL',
				\ '^S': 'SB',
				\ 'i': 'INSERT',
				\ 'R': 'REPLACE',
				\ 'c': 'COMMAND',
				\ 't': 'T'}
	let l:modecurrent = mode()
	let l:modelist = toupper(get(l:currentmode, l:modecurrent, 'VB'))
	let l:current_status_mode = l:modelist
	return l:current_status_mode
endfunction

highlight NormalModeColor ctermbg=2 ctermfg=15
highlight InsertModeColor ctermbg=4 ctermfg=15
highlight VisualModeColor ctermbg=5 ctermfg=15
highlight DefaultColor ctermbg=8 ctermfg=15
function! StatuslineActive()
	let l:filename = '%t'
	let l:mod = '%m'
	let l:lc = '[%l,%c]'
	let l:color = '%#DefaultColor#'

	if mode() ==# 'n'
		let w:mode = '%#NormalModeColor# %{StatuslineMode()} '
	elseif mode() ==# 'i'
		let w:mode = '%#InsertModeColor# %{StatuslineMode()} '
	elseif mode() ==# 'v' || mode() ==# 'V' || mode() ==# '^V'
		let w:mode = '%#VisualModeColor# %{StatuslineMode()} '
	else
		let w:mode = '%#DefaultColor# %{StatuslineMode()} '
	endif

	let g:gitbranchcmd = "git branch --show-current 2>/dev/null | tr -d '\n'"
	let l:git = "[%{system(g:gitbranchcmd)}]"
	let l:sep = '%='
	return w:mode.'%*'.l:color.l:filename.l:mod.l:sep.l:lc.l:git
endfunction

function! StatuslineInactive()
	let l:filename "dummy"
	return l:filename
endfunction

function! StatuslineLoad(mode)
	if a:mode ==# 'active'
		setlocal statusline=%!StatuslineActive()
	else
		setlocal statusline=%!StatuslineInactive()
	endif
endfunction

augroup statusline_startup
	autocmd!
	autocmd WinEnter,BufWinEnter * call StatuslineLoad('active')
	" autocmd WinLeave * call StatuslineInactive('inactive')
augroup END
