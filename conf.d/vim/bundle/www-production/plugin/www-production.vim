"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/sass-compile.vim
"VERSION:  0.9
"LICENSE:  MIT

"if !executable('sass') || !executable('uglifyjs')
"    echohl ErrorMsg
"    echo 'requires sass and uglify-js.'
"    echo 'sudo apt install npm nodejs-legacy -y && sudo npm install -g sass uglify-js'
"    echohl None
"    finish
"endif

if exists("g:loaded_www_production")
    finish
endif

let g:loaded_www_production = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists("g:www_production_sass_file")
    let g:www_production_sass_file = ['scss', 'sass']
endif
if !exists("g:www_production_js_file")
    let g:www_production_js_file = ['js']
endif
if !exists("g:www_production_auto")
    let g:www_production_auto = 0
endif

command! SassCompile call wwwproduction#SassCompile()
command! JsCompile call wwwproduction#JsCompile()

" sass auto compile
function! s:SetAutoCmd()
    if g:www_production_auto == 1
        for e in g:www_production_sass_file
            exec 'au BufWritePost *.'.e.' call wwwproduction#SassCompile()'
        endfor
        for e in g:www_production_js_file
            exec 'au BufWritePost *.'.e.' call wwwproduction#JsCompile()'
        endfor
    endif
endfunction
au VimEnter * call s:SetAutoCmd()

let &cpo = s:save_cpo
