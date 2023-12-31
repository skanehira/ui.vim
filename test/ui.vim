let s:suite = themis#suite('ui')
let s:assert = themis#helper('assert')

let s:rows = [
      \ {
      \   "text": "hello\nmy name is godzilla",
      \   "user": {
      \     "name": "godzilla",
      \     "screen_name": "ゴジラ",
      \     "url": "https://example.com/godzilla",
      \   },
      \   "metadata": {
      \     "created_at_str": "2024-01-01 01:00:00",
      \   },
      \   "reactions": [
      \     {
      \       "action": "👍",
      \       "count": 1,
      \     },
      \     {
      \       "action": "😂",
      \       "count": 4,
      \     },
      \   ]
      \ },
      \ {
      \   "text": "this is my first message",
      \   "user": {
      \     "name": "godzilla",
      \     "screen_name": "ゴジラ",
      \     "url": "https://example.com/godzilla",
      \   },
      \   "metadata": {
      \     "created_at_str": "2024-01-02 01:00:00",
      \   },
      \   "reactions": [
      \     {
      \       "action": "👍",
      \       "count": 1,
      \     },
      \   ]
      \ }
      \ ]

function s:suite.before_each()
  call ui#chat#open(s:rows)
endfunction

function s:suite.chat_ui()
  " workaround(skanehira)
  " Cannot set window size before draw UI.
  " So we should remove '─'
  let line = filter(getbufline(bufname(), 1, '$'), { _, line -> line !~? "^─" })
  let actual = join(line, "\n")
  let expected = join(readfile("test/snapshots/ui_chat.txt"), "\n")
  call s:assert.equals(actual, expected)
endfunction

function s:suite.chat_move_message()
  call ui#chat#message_next()
  let current = ui#chat#row()
  call s:assert.equals(current, s:rows[1])

  call ui#chat#message_prev()
  let current = ui#chat#row()
  call s:assert.equals(current, s:rows[0])
endfunction
