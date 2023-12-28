" hook_add {{{
call ddu#custom#patch_global({
      \   'ui': 'ff',
      \   'uiParams': {
      \     'ff': {
      \       'split': 'floating',
      \       'startFilter': v:true,
      \     },
      \   },
      \ })

call ddu#custom#patch_global({
      \   'kindOptions': {
      \     'file': {
      \       'defaultAction': 'open',
      \     },
      \   }
      \ })

call ddu#custom#patch_global({
      \   'sourceOptions': {
      \     '_': {
      \       'matchers': ['matcher_substring'],
      \     }
      \   }
      \ })

call ddu#custom#patch_global('sourceParams', {
      \ 'file': {'path': expand("~")},
      \ })

call ddu#custom#patch_global('sourceParams', {
     \   'file_rec': {
     \     'path': expand(execute('pwd')),
     \     'ignoredDirectories': ['.git', 'node_modules']
     \   },
     \ })

call ddu#custom#patch_global({
      \   'filterParams': {
      \     'matcher_substring': {
      \       'highlightMatched': 'Search',
      \     },
      \   }
      \ })

autocmd FileType ddu-ff call s:ddu_my_settings()
function! s:ddu_my_settings() abort
  nnoremap <buffer><silent> <CR>
        \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  nnoremap <buffer><silent> <Space>
        \ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
  nnoremap <buffer><silent> i
        \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
  nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction

autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
function! s:ddu_filter_my_settings() abort
  inoremap <buffer><silent> <CR>
        \ <Esc><Cmd>close<CR>
  nnoremap <buffer><silent> <CR>
        \ <Cmd>close<CR>
endfunction

nnoremap <silent> <Leader>fl :Ddu file_rec<CR>
" }}}
