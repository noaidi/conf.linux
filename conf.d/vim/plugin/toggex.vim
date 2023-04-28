function! ToggEx_FitWindow()
	let l:columns = winwidth(winnr())
	if !exists('g:ToggEx_WindowWidth')
		let g:ToggEx_WindowWidth = 90
	endif
	if l:columns != g:ToggEx_WindowWidth
		let &columns = g:ToggEx_WindowWidth
	else
		let &columns = g:ToggEx_WindowWidth * 2
	endif
endfunction

function! ToggEx_Explore()
	if !exists('w:ToggEx_Explore_active')
		let w:ToggEx_Explore_active = 0
	endif
	if w:ToggEx_Explore_active == 1
	if w:ToggEx_Explore_expl_buf == bufnr('%')
		if exists('w:ToggEx_Explore_cur_buf')
			exec ":buffer " w:ToggEx_Explore_cur_buf
		else
			close
		endif
		let w:ToggEx_Explore_active = 0
		return
	endif
	endif

	let w:ToggEx_Explore_cur_buf = bufnr('%')
	Explore
	let w:ToggEx_Explore_expl_buf = bufnr('%')
	let w:ToggEx_Explore_active = 1
	return
endfunction

function! ToggEx_Explore_s()
	let l:columns = winwidth(winnr())
	let l:max_columns = l:columns * 2 
	let l:fit_columns = 200
	
	if !exists('w:ToggEx_Explore_active')
		let w:ToggEx_Explore_active = 0
	endif
	if w:ToggEx_Explore_active == 1
	if w:ToggEx_Explore_expl_buf == bufnr("%")
		if g:ToggEx_Explore_winadj
			let &columns = &columns - l:columns
		endif
		close
		let w:ToggEx_Explore_active = 0
		return
	endif
	endif

	if &columns < l:max_columns && (&columns + l:columns) < l:fit_columns
		let &columns = &columns + l:columns
		let g:ToggEx_Explore_winadj = 1
	else
		let g:ToggEx_Explore_winadj = 0
	endif
	silent! vnew
	Explore
	let w:ToggEx_Explore_expl_buf = bufnr("%")
	let w:ToggEx_Explore_active = 1
	return
endfunction

function! ToggEx_BufList_s()
	let l:columns = winwidth(winnr())
	let l:max_columns = l:columns * 2 
	let l:fit_columns = 200
	
	if !exists('w:ToggEx_BufList_active')
		let w:ToggEx_BufList_active = 0
	endif
	if w:ToggEx_BufList_active == 1
		if bufexists(bufnr("__BUFFERLIST__"))
			exec ':' . bufnr("__BUFFERLIST__") . 'bwipeout'
		endif
		if g:ToggEx_BufList_winadj == 1
			let l:columns = winwidth(winnr())
			let &columns = &columns - l:columns
		endif
		close
		let w:ToggEx_BufList_active = 0
		return
	endif

	if &columns < l:max_columns && (&columns + l:columns) < l:fit_columns
		let &columns = &columns + l:columns
		let g:ToggEx_BufList_winadj = 1
	else
		let g:ToggEx_BufList_winadj = 0
	endif
	silent! vnew
	call BufferList()
	let w:ToggEx_BufList_active = 1
	return
endfunction

function! ToggEx_BufDel()
	wincmd v
	bprevious
	wincmd p
	bdelete
	wincmd p
endfunction

function! ToggEx_Tabstop()
	let g:ToggEx_Tabstop_type += 1
	if g:ToggEx_Tabstop_type > 2
		let g:ToggEx_Tabstop_type = 0
	endif
	if g:ToggEx_Tabstop_type == 0
		set ts=4 sw=4 sts=0 noet
		echo "normal"
	elseif g:ToggEx_Tabstop_type == 1
		set ts=8 sw=8 sts=0 noet
		echo "linux kernel"
	else
		set ts=8 sw=4 sts=4 et
		echo "java"
	endif
	set ts sw sts
endfunction
