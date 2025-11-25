" basic
set encoding=utf-8
scriptencoding utf-8
syntax enable
set re=0
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


call plug#begin()

" lsp
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

" autocomplete
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" colorscheme
Plug 'NLKNguyen/papercolor-theme'

" denops
Plug 'vim-denops/denops.vim'

call plug#end()

" NLKNguyen/papercolor-theme
set background=dark
colorscheme PaperColor

" vim-lsp
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    "nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    "nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    "nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" asyncomplete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" copilot
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
