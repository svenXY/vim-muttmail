" mutt stuff
" Only do this when not done yet for this buffer
if exists("b:loaded_MuttMail_plugin")
   finish
endif
let b:loaded_MuttMail_plugin = 1

" Function to strip one's own signature by either
"   - a string (at the beginning of the first stripped line)
"   - a number (for the lines (after "-- ") to keep
if ! exists('g:MuttSigLines')
  let g:MuttSigLines=2
else 
  let g:MuttSigLines=g:MuttSigLines+1
endif

" Insert long or short signature
nnoremap <buffer> <localleader>ss :call InsertSignature(1)<cr>
nnoremap <buffer> <localleader>sl :call InsertSignature()<cr>

nnoremap <buffer> <localleader>S :call MuttStripSig()<cr>
nnoremap <buffer> <localleader>sr :call RemoveMySig()<cr>
nnoremap <buffer> <localleader>sq :call RemoveQuotedSig()<cr>


function! MuttStripSig()
    normal mx
    if exists('g:MuttSigStripString')
        execute "silent g/^" . g:MuttSigStripString . "/,$d"
        redraw | echom "Removed Signature tail after ^" . g:MuttSigStripString . "/,$d"
    elseif exists('g:MuttSigLines')
        execute "silent g/^-- $/+" . g:MuttSigLines . ",$d"
        redraw | echom "Removed Signature tail after " . g:MuttSigLines . " lines"
    endif
    normal `x
endfu

" Function to remove the signature of the last quoted mail
function! RemoveQuotedSig()
    silent g/^> --\s\=$/,/^$/-1d
    redraw | echom "Removed quoted signature"
endfu

" Function to remove the signature
function! RemoveMySig()
    silent g/^--\s\=$/,$d
    redraw | echom "Removed my signature"
endfu

if ! exists('spelllang')
    set spelllang=de_de
endif
    

set nonumber
set nofoldenable
set background=dark spell
"highlight! SpellBad term=underline cterm=underline ctermbg=10 gui=undercurl

"if exists(':QueryCommandComplete')
  let g:qcc_query_command='abook --mutt-query'
  setlocal omnifunc=QueryCommandComplete
"endif

" Remove quoted signature from my mail
" to disable let g:MuttNoSignatureRemoval=1 in ~/.vimrc
if ! exists('g:MuttNoSignatureRemoval')
    call RemoveQuotedSig()
endif

if ! exists('g:MuttSigFile')
  let g:MuttSigFile='~/.signature'
endif
function! InsertSignature(...)
    normal! mx
    call RemoveMySig()
    normal! Go-- 
    execute "read " . g:MuttSigFile
    normal! 'x
    if a:0 == 1
        call MuttStripSig()
        redraw | echom "Inserted short signature"
    else
        redraw | echom "Inserted long signature"
    endif
endfunction

function GetRecipient()
    let toline = search("^To:")
    let line = getline(toline)
    let stuff = split(line)
    if len(stuff) > 1
        redraw | echom "Found " . stuff[1] . " as recipient"
        return stuff[1]
    else
        redraw | echom "No recipient found"
        return 'RCPT'
    endif
endfu

