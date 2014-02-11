          _                                 _   _                   _ _ 
   __   _(_)_ __ ___        _ __ ___  _   _| |_| |_ _ __ ___   __ _(_) |
   \ \ / / | '_ ` _ \ _____| '_ ` _ \| | | | __| __| '_ ` _ \ / _` | | |
    \ V /| | | | | | |_____| | | | | | |_| | |_| |_| | | | | | (_| | | |
     \_/ |_|_| |_| |_|     |_| |_| |_|\__,_|\__|\__|_| |_| |_|\__,_|_|_|
                                                                           


vim-muttmail
============

vim-muttmail is a vim plugin designed to support vim as being used as mutt's mail editor.

Variables
---------

g:MuttSigStripString

  The string from which the signature will be shortened (anchored beginning of line, included in stripped text)

g:MuttSigLines

  The number of lines after the "-- ", which will be kept. Defaults to 1. Ignored if g:MuttSigStripString is set.

g:MuttNoSignatureRemoval

  Can be set to 1 to prevent the last quoted signature to be removed automatically

g:MuttSigFile='~/.signature'

  Can be set to a different signature file

Functions
---------

MuttStripSig()
  Function to strip one's own signature by either deleting everything after g:MuttSigStripString or after g:MuttSigLines lines.

RemoveQuotedSig()
 Function to remove the signature of the last quoted mail, can be disabled (see variables).

RemoveMySig()
 Function to remove my signature

InsertSignature(...)
 Will insert the signature from the file in g:MuttSigFile. With the parameter set to 1, it will use the shortened signature.
 The function will replace any signature that is already present at the end of the mail.

GetRecipient()
 Function to retrieve the first Name of the first recipient in the To: header field.

Snippet support
---------------

With snipMate installed, you get a few nice text snippets. Check mail.snippets for details.

Abook support
-------------

With the QueryCommandComplete plugin, To: and Cc: lines can be filled automatically from abook.


