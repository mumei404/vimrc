syntax enable
set background=dark
colorscheme solarized

set number
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set nocompatible
set suffixesadd+=.php
set suffixesadd+=.ctp
filetype plugin on
"set rtp+=~/vimPlugins/tabnine-vim
inoremap <?<Enter> <?php  ?><Left><Left><Left>
inoremap <%<Enter> <%  %><Left><Left><Left>
inoremap <%=<Enter> <%=  %><Left><Left><Left>
inoremap {<Enter> {}<Left><CR><Esc>==<S-o>
inoremap (<Enter> ()<Left><CR><Esc>==<S-o>
inoremap [<Enter> []<Left><CR><Esc>==<S-o>
inoremap { {}<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap < <><Left>
inoremap " ""<Left>
inoremap ' ''<Left>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

vnoremap " c"<C-r>""<Esc>
vnoremap ' c'<C-r>"'<Esc>
vnoremap ( c(<C-r>")<Esc>
vnoremap { c{<C-r>"}<Esc>
vnoremap [ c[<C-r>"]<Esc>
