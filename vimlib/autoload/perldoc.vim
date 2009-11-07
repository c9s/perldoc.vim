" &&&& Perldoc Window &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
"=VERSION 1.0
"
let perldoc#window = { 'width':50 , 'height': 82 }

fun! perldoc#window.open(name,param)
  " XXX: save size for each window
  " save window size
  let self.previous_height = winheight('%')
  let self.previous_width  = winwidth('%')

  vnew
  setlocal modifiable noswapfile nobuflisted
  setlocal buftype=nofile bufhidden=hide fdc=0
  setlocal nowrap cursorline nonumber

  setfiletype perldoc
  silent file Perldoc

  exec 'r !perldoc -tT ' . a:param . ' ' . a:name

  syn match HEADER +^\w.*$+
  syn match STRING +".\{-}"+
  syn match STRING2 +'.\{-}'+
  hi link HEADER Identifier
  hi link STRING Comment
  hi link STRING2 Comment

  setlocal nomodifiable
  call cursor(1,1)
  exec 'resize ' . self.width
  exec 'vertical resize ' . self.height
  autocmd BufWinLeave <buffer> call perldoc#window.close()
  nmap <buffer> <ESC> <C-W>q
endf

fun! perldoc#window.close()
  bw
  exec 'vertical resize ' . self.previous_width
  exec 'resize ' . self.previous_height
  redraw
endf
