" Vim syntax file
" Language:     x86/x64 GNU Disassembler
" Maintainer:   @posix <posix.lee@gmail.com>
" Last Change:  2022 Nov 02

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case ignore

syn region disFunction start="^" end="\n\n" contains=disFunctionAddr,disFunctionName,disFunctionNumber,disBytes,disComment

syn match disFunctionAddr "^0[0-9a-f]\+" contained containedin=disFunction nextgroup=disFunctionName skipempty skipwhite
syn match disFunctionName "\v\<\zs.*\ze\>:$" contained containedin=disFunction

hi link disFunctionAddr Number
hi link disFunctionName DraculaPink

syn match disFunctionNumber "\v^\zs[a-f0-9 ]+\ze:" contained nextgroup=disBytes skipempty skipwhite
syn match disBytes "\v\t\zs([a-f0-9]{2} )+\ze" contained nextgroup=disInstruction,disCallInstruction,disFunctionNumber skipempty skipwhite

hi link disFunctionNumber Number
hi link disBytes SignColumn

syn match disInstruction "[a-z][a-z0-9]\+" contained nextgroup=disOperand
syn match disCallInstruction "\<\(call\|j[a-z]\+\)\>" contained nextgroup=disOperand

hi link disInstruction Function
hi link disCallInstruction Search

syn match disOperand "\v.*($|#)" contained contains=disNumber,disOperandFunctionName
"syn match disX64RegisterFormat "\<[re][sdbaic][a-z]\>" contained
"syn match disX64RegisterFormat "\<r\(8\|9\|10\|11\|12\|13\|14\|15\)d\?\>" contained

syn match disNumber "\<\(0x\)\?[a-f0-9]\+\>" contained
syn match disOperandFunctionName "\v\<\zs.*\ze\>" contained

"hi link disX64RegisterFormat Tag
hi link disNumber Number
hi link disOperandFunctionName DraculaPink

syn match disSectionBanner "\v^Disassembly of section .*" contains=disSectionBannerSectionName
syn match disSectionBannerSectionName "\v\zs\..*\ze:" contained

hi link disSectionBannerSectionName WildMenu

syn match disComment ";.*$"
hi link disComment DraculaYellow

let b:current_syntax = "dis"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=8 sts=4 sw=2
