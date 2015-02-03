au BufNewFile,BufRead /tmp/mutt* set filetype=mail fo+=n
au BufRead,BufNewFile .followup,.article,.letter,/tmp/pico*,nn.*,snd.*,/tmp/mutt* set filetype=mail
