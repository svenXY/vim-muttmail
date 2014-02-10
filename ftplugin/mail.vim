" mutt stuff
" Only do this when not done yet for this buffer
if exists("b:loaded_MuttMail_plugin")
   finish
endif
let b:loaded_MuttMail_plugin = 1

" Function to strip one's own signature by either
"   - a string (at the beginning of the first stripped line)
"   - a number (for the lines (after "-- ") to keep
if ! exists('g:MuttSigStripLines')
  let g:MuttSigLines=2
else 
  let g:MuttSigLines=g:MuttSigLines+1
endif

nnoremap <buffer> <leader>S :call MuttStripSig()<cr>
function! MuttStripSig()
    normal mx
    if exists('g:MuttSigStripString')
        execute "silent g/^" . g:MuttSigStripString . "/,$d"
        echom "Removed Signature tail after ^" . g:MuttSigStripString . "/,$d"
    elseif exists('g:MuttSigStripLines')
        execute "silent g/^-- $/+" . g:MuttSigLines . ",$d"
        echom "Removed Signature tail after " . g:MuttSigLines . " lines"
    endif
    normal `x
endfu

" Function to remove the signature of the last quoted mail
function! RemoveQuotedSig()
    silent g/^> --\s\=$/,/^$/-1d
endfu

if ! exists('spelllang')
    set spelllang=de_de
endif
    

set nonumber
set background=light spell

if exists(':QueryCommandComplete')
  setlocal omnifunc=QueryCommandComplete
endif

" Remove quoted signature from my mail
" to disable let g:MuttNoSignatureRemoval=1 in ~/.vimrc
if ! exists('g:MuttNoSignatureRemoval')
    call RemoveQuotedSig()
endif

