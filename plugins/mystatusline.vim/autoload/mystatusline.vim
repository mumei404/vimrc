function! mystatusline#start() abort	
	augroup statusline_startup
		autocmd!
		autocmd WinEnter,BufWinEnter * call StatuslineLoad('active')
		" autocmd WinLeave * call StatuslineInactive('inactive')
	augroup END
endfunction

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
