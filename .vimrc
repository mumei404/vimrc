set encoding=utf-8                                                                                                                                                                                                                                                                                                                                                                            
scriptencoding utf-8                                                                                                                                                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                                                                                                                                                              
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'                                                                                                                                                                                                                                                                                                                             
                                                                                                                                                                                                                                                                                                                                                                                              
call plug#begin()                                                                                                                                                                                                                                                                                                                                                                             
                                                                                                                                                                                                                                                                                                                                                                                              
Plug 'neoclide/coc.nvim', {'branch': 'release'}                                                                                                                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                                                                                                                                                              
Plug 'tomasiser/vim-code-dark'                                                                                                                                                                                                                                                                                                                                                                
                                                                                                                                                                                                                                                                                                                                                                                              
call plug#end()                                                                                                                                                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                                                                                                                                                              
colorscheme codedark                                                                                                                                                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                                                                                                                                                              
" use <tab> to trigger completion and navigate to the next complete item                                                                                                                                                                                                                                                                                                                      
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
                                                                                                                                                                                                                                                                                                                                                                                              
" Make <CR> to accept selected completion item or notify coc.nvim to format                                                                                                                                                                                                                                                                                                                   
" <C-g>u breaks current undo, please make your own choice                                                                                                                                                                                                                                                                                                                                     
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()                                                                                                                                                                                                                                                                                                                            
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"                                                                                                                                                                                                                                                                                                                     
                                                                                                                                                                                                                                                                                                                                                                                              
" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable                                                                                                                                                                                                                                                                                                                      
" delays and poor user experience                                                                                                                                                                                                                                                                                                                                                             
set updatetime=300                                                                                                                                                                                                                                                                                                                                                                            
                                                                                                                                                                                                                                                                                                                                                                                              
" Use `[g` and `]g` to navigate diagnostics                                                                                                                                                                                                                                                                                                                                                   
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list                                                                                                                                                                                                                                                                                                             
nmap <silent> [g <Plug>(coc-diagnostic-prev)                                                                                                                                                                                                                                                                                                                                                  
nmap <silent> ]g <Plug>(coc-diagnostic-next)                                                                                                                                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                                                                                                                                                              
" GoTo code navigation                                                                                                                                                                                                                                                                                                                                                                        
nmap <silent> <C-]> <Plug>(coc-definition)                                                                                                                                                                                                                                                                                                                                                    
" nmap <silent> gy <Plug>(coc-type-definition)                                                                                                                                                                                                                                                                                                                                                
" nmap <silent> gi <Plug>(coc-implementation)                                                                                                                                                                                                                                                                                                                                                 
nmap <silent> <C-[> <Plug>(coc-references)                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                                              
" Use K to show documentation in preview window                                                                                                                                                                                                                                                                                                                                               
nnoremap <silent> K :call ShowDocumentation()<CR>                                                                                                                                                                                                                                                                                                                                             
                                                                                                                                                                                                                                                                                                                                                                                              
function! ShowDocumentation()                                                                                                                                                                                                                                                                                                                                                                 
  if CocAction('hasProvider', 'hover')                                                                                                                                                                                                                                                                                                                                                        
      call CocActionAsync('doHover')                                                                                                                                                                                                                                                                                                                                                          
        else                                                                                                                                                                                                                                                                                                                                                                                  
            call feedkeys('K', 'in')                                                                                                                                                                                                                                                                                                                                                          
              endif                                                                                                                                                                                                                                                                                                                                                                           
              endfunction                                                                                                                                                                                                                                                                                                                                                                     
                                                                                                                                                                                                                                                                                                                                                                                              
" Highlight the symbol and its references when holding the cursor                                                                                                                                                                                                                                                                                                                             
autocmd CursorHold * silent call CocActionAsync('highlight')                                                                                                                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                                                                                                                                                              
" highlight CocErrorSign ctermfg=15 ctermbg=196                                                                                                                                                                                                                                                                                                                                               
" highlight CocWarningSign ctermfg=0 ctermbg=172                                                                                                                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                                                                                                                                                              
" Mappings for CoCList                                                                                                                                                                                                                                                                                                                                                                        
" Show all diagnostics                                                                                                                                                                                                                                                                                                                                                                        
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>                                                                                                                                                                                                                                                                                                                             
" Manage extensions                                                                                                                                                                                                                                                                                                                                                                           
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>                                                                                                                                                                                                                                                                                                                              
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
                                                                                                                                                                                                                                                                                                                                                                                              
" Add `:Format` command to format current buffer                                                                                                                                                                                                                                                                                                                                              
command! -nargs=0 Format :call CocActionAsync('format')                                                                                                                                                                                                                                                                                                                                       
