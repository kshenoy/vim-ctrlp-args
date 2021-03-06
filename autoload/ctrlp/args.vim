" vim: fdm=marker:et:ts=4:sw=2:sts=2
" Description: ctrlp-args is a plugin to display the arglist in CtrlP
" Maintainer: Kartik Shenoy
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if (  &cp
 \ || (v:version < 700)
 \ || (  exists('g:loaded_ctrlp_args')
 \    && g:loaded_ctrlp_args
 \    )
 \ )
  finish
endif
let g:loaded_ctrlp_args = 1

" Add this extension's settings to g:ctrlp_ext_vars                                                               " {{{1
"
" Required:
" init          : the name of the input function including the brackets and any arguments
" accept        : the name of the action function (only the name)
" lname & sname : the long and short names to use for the statusline
" type          : the matching type
"   - line      :   - full line
"   - path      :   - full line like a file or a directory path
"   - tabs      :   - until first tab character
"   - tabe      :   - until last tab character
"
" Optional:
" enter         : the name of the function to be called before starting ctrlp
" exit          : the name of the function to be called after closing ctrlp
" opts          : the name of the option handling function called when initialize
" sort          : disable sorting (enabled by default when omitted)
" specinput     : enable special inputs '..' and '@cd' (disabled by default)
"
call add(g:ctrlp_ext_vars, {
  \ 'init'      : 'ctrlp#args#init()',
  \ 'accept'    : 'ctrlp#args#accept',
  \ 'lname'     : 'Args',
  \ 'sname'     : 'Args',
  \ 'type'      : 'path',
  \ 'sort'      : 0
  \ })

" ID for the extension                                                                                            " {{{1
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#args#id()
  return s:id
endfunction

function! s:get_args()                                                                                            " {{{1
  return argv()
endfunction

function! ctrlp#args#init()                                                                                       " {{{1
  return s:get_args()
endfunction

function! ctrlp#args#accept(mode, str)                                                                            " {{{1
  " Description: The action to perform on the selected string
  " Arguments:
  "  a:mode : The mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
  "         : The values are 'e', 'v', 't' and 'h', respectively
  "  a:str  : The selected string

  " echom "mode: " . a:mode . ", str: " . a:str

  call ctrlp#acceptfile(a:mode, a:str)

  call ctrlp#exit()
endfunction
