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

