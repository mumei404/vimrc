highlight NormalModeColor ctermbg=2 ctermfg=15
highlight InsertModeColor ctermbg=4 ctermfg=15
highlight VisualModeColor ctermbg=5 ctermfg=15
highlight DefaultColor ctermbg=8 ctermfg=15

highlight ErrorColor ctermbg=1 ctermfg=15
highlight WarningColor ctermbg=3 ctermfg=15
highlight InformationColor ctermbg=6 ctermfg=15
highlight HintColor ctermbg=6 ctermfg=15

function! mystatusline#start() abort	
	augroup statusline_startup
		autocmd!
		autocmd WinEnter,BufWinEnter * call mystatusline#load('active')
		autocmd WinLeave * call mystatusline#load('inactive')
	augroup END
endfunction

function! mystatusline#load(mode)
	if a:mode ==# 'active'
		setlocal statusline=%!mystatusline#getActive()
	else
		setlocal statusline=%!mystatusline#Inactive()
	endif
endfunction

function! mystatusline#getActive()
	let l:filename = ' %t '
	let l:mod = '%m'
	let l:lc = '[%l,%c]'
	let l:defaultColor = '%#DefaultColor#'

	if mode() ==# 'n'
		let w:mode = '%#NormalModeColor# %{mystatusline#getMode()} '
	elseif mode() ==# 'i'
		let w:mode = '%#InsertModeColor# %{mystatusline#getMode()} '
	elseif mode() ==# 'v' || mode() ==# 'V' || mode() ==# '^V'
		let w:mode = '%#VisualModeColor# %{mystatusline#getMode()} '
	else
		let w:mode = '%#DefaultColor# %{mystatusline#getMode()} '
	endif

	let g:gitbranchcmd = "git branch --show-current 2>/dev/null | tr -d '\n'"
	let l:git = "[%{system(g:gitbranchcmd)}]"
	let l:sep = '%='
	let l:diagnosis = mystatusline#getDiagnosis()
	let l:diag = l:diagnosis == '0' ? '' : l:diagnosis
	return w:mode.'%*'.l:defaultColor.l:filename.l:mod.l:diag.l:defaultColor.l:sep.l:lc.l:git
endfunction

function! mystatusline#Inactive()
	let l:filename = "dummy"
	return l:filename
endfunction

function! mystatusline#getMode() abort
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

function! mystatusline#getDiagnosis() abort
	if !exists('g:did_coc_loaded')
		return 0
	endif

	let l:counts = get(b:, 'coc_diagnostic_info', {})

	let l:result = ''
	if has_key(l:counts, 'error') && l:counts['error'] > 0
		let l:result .= '%*%#ErrorColor# E '
	endif
	if has_key(l:counts, 'warning') && l:counts['warning'] > 0
		let l:result .= '%*%#WarningColor# W '
	endif
	if has_key(l:counts, 'information') && l:counts['information'] > 0
		let l:result .= '%*%#InformationColor# I '
	endif
	if has_key(l:counts, 'hint') && l:counts['hint'] > 0
		let l:result .= '%*%#HintColor# H '
	endif
	return l:result == '' ? 0 : l:result
endfunction
