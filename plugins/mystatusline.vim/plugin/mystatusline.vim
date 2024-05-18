if exists('g:loaded_mystatusline')
	finish
endif
let g:loaded_mystatusline = 1

set laststatus=2
call mystatusline#start()
