" https://github.com/AtsushiM/sass-compile.vim

let s:save_cpo = &cpo
set cpo&vim

function! wwwproduction#SassCompile()
	if @% !~ '\.min\.css'
		let input = expand('%')
		let output = expand('%:r').'.min.css'
		let cmd = 'sass --no-source-map --style="compressed" '.input.':'.output
		let result = system(cmd)
		if v:shell_error == 0
			cclose
		else
			if result != ''
				cgetexpr result
				copen
			endif
		endif
	endif
endfunction

function! wwwproduction#JsCompile()
	if @% !~ '\.min\.js'
		let input = expand('%')
		let output = expand('%:r').'.min.js'
		let cmd = 'uglifyjs --compress --mangle --output '.output.' -- '.input
		let result = system(cmd)
		if v:shell_error == 0
			cclose
		else
			if result != ''
				cgetexpr result
				copen
			endif
		endif
	endif
endfunction

let &cpo = s:save_cpo
