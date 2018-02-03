" vim:foldmethod=marker:fen:
scriptencoding utf-8

" Load Once {{{
if get(g:, 'loaded_openbrowser_unicode', 0) || &cp
    finish
endif
let g:loaded_openbrowser_unicode = 1
" }}}
" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}


function! s:error(msg)
    echohl ErrorMsg
    echomsg a:msg
    echohl None
endfunction

if globpath(&rtp, 'plugin/openbrowser.vim') ==# ''
    call s:error('open-browser-unicode.vim depends on open-browser.vim. Please install open-browser.vim')
    finish
endif


function! s:get_current_char() abort
  let save_reg = getreg('z', 1)
  let save_regtype = getregtype('z')
  try
    normal! "zyl
    return @z
  finally
    call setreg('z', save_reg, save_regtype)
  endtry
endfunction

function! s:cmd_open(...) abort
  if a:0
    if a:1 =~# '^U+\x\+$'
      let c = nr2char(+('0x' . a:1[2:]))
    else
      let c = matchstr(a:1, '^.')
    endif
  else
    let c = s:get_current_char()
  endif
  execute 'OpenBrowserSearch -fileformat' printf('%x', char2nr(c))
endfunction

command! -bar -nargs=?
\   OpenBrowserUnicode
\   call s:cmd_open(<f-args>)

" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
" }}}
