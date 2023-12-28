set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set smarttab
set cindent

" if .py file open
augroup PythonIndent
  autocmd!
  autocmd FileType python set tabstop=4 softtabstop=4 shiftwidth=4
augroup END

set hlsearch
set cursorline
set cursorcolumn
set foldmethod=marker
set backspace=indent,eol,start
set helplang=ja,en
set ruler
set noerrorbells
set laststatus=0
set number
set nocompatible

noremap <silent> <ESC><ESC> :noh<CR>

let mapleader = "\<Space>"
let g:denops#script#typecheck = 1

noremap j gj
noremap k gk

const s:dpp_base = '$HOME/.cache/dpp'

const s:dpp_src = '~/.cache/dpp/repos/github.com/Shougo/dpp.vim'
const s:denops_src = '~/.cache/dpp/repos/github.com/vim-denops/denops.vim'
const s:ext_installer = '~/.cache/dpp/repos/github.com/Shougo/dpp-ext-installer'
const s:ext_lazy = '~/.cache/dpp/repos/github.com/Shougo/dpp-ext-lazy'
const s:ext_toml = '~/.cache/dpp/repos/github.com/Shougo/dpp-ext-toml'
const s:protocol_git = '~/.cache/dpp/repos/github.com/Shougo/dpp-protocol-git'

execute 'set runtimepath^=' .. s:dpp_src
execute 'set runtimepath^=' .. s:ext_installer
execute 'set runtimepath^=' .. s:ext_lazy
execute 'set runtimepath^=' .. s:ext_toml
execute 'set runtimepath^=' .. s:protocol_git

if dpp#min#load_state(expand(s:dpp_base))
  execute 'set runtimepath^=' .. s:denops_src

  autocmd User DenopsReady
  \ call dpp#make_state(s:dpp_base, '$HOME/dotfiles/dpp_config.ts')
endif

autocmd User Dpp:makeStatePost
  \ echo 'dpp make state ready'
	
filetype indent plugin on

if has('syntax')
  syntax on
endif

" :押す手間が省ける
noremap ; :

set clipboard^=unnamedplus

noremap <silent><C-x> :bdelete<CR>
noremap <silent><C-h> :bprevious<CR>
noremap <silent><C-l> :bnext<CR>

call ddc#custom#patch_global('ui', 'native')
call ddc#custom#patch_global('sources', ['vim-lsp', 'file', 'around'])

call ddc#custom#patch_global('sourceOptions', {
      \ '_': {
      \ 'matchers': ['matcher_head'],
      \ 'sorters': ['sorter_rank'],
      \ },
      \ 'ddc-vim-lsp': {
      \ 'matchers': ['matcher_head'],
      \ 'mark': 'L',
      \ 'isVolatile': v:true,
      \ 'minAutoCompleteLength': 0,
      \ },
      \ 'file': {
      \   'mark': 'F',
      \   'isVolatile': v:true,
      \   'forceCompletionPattern': '\S/\S*',
      \ },
      \ 'around': {
      \ 'mark': 'A',
      \ 'isVolatile': v:true,
      \ },
      \ })


call ddc#custom#patch_filetype(
      \ ['ps1', 'dosbatch', 'autohotkey', 'registry'], {
      \ 'sourceOptions': {
      \   'file': {
      \     'forceCompletionPattern': '\S\\\S*',
      \   },
      \ },
      \ 'sourceParams': {
      \   'file': {
      \     'mode': 'win32',
      \   },
      \ }})


call ddc#enable()

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR>
        \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> c
        \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> p
        \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> l
        \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> v
        \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> t
        \ defx#do_action('open_tree', 'toggle')
  nnoremap <silent><buffer><expr> P
        \ defx#do_action('preview')
  nnoremap <silent><buffer><expr> ND
        \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> NF
        \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> C
        \ defx#do_action('toggle_columns',
        \                'mark:indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> S
        \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> d
        \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
        \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
        \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
        \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
        \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
        \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
        \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h
        \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~
        \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
        \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
        \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
        \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
        \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
        \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l>
        \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
        \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
        \ defx#do_action('change_vim_cwd')
endfunction
noremap <silent> <C-n> :Defx<CR>

call defx#custom#option('_', {
      \ 'winwidth': 40,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 0,
      \ 'toggle': 1,
      \ 'columns': 'indent:icons:filename:mark',
      \ })

nnoremap <silent> <Leader>d :LspDefinition<CR>
nnoremap <silent> <Leader>f :LspDocumentFormat<CR>
nnoremap <silent> <Leader>h :LspHover<CR>
nnoremap <silent> <Leader>r :LspRename<CR>
nnoremap <silent> <Leader>a :LspCodeAction<CR>
nnoremap <silent> <Leader>ne :LspNextError<CR>
nnoremap <silent> <Leader>pe :LspPreviousError<CR>
nnoremap <silent> <Leader>td :LspTypeDefinition<CR>

vmap ( <Plug>(dps_kakkonan_surround_parenthesis)
vmap { <Plug>(dps_kakkonan_surround_curly)
vmap [ <Plug>(dps_kakkonan_surround_square)
vmap " <Plug>(dps_kakkonan_surround_doublequote)
vmap ' <Plug>(dps_kakkonan_surround_singlequote)
vmap ` <Plug>(dps_kakkonan_surround_backquote)

let g:kakkonan_custom_brackets = {
      \ "h1": {
      \ "start": "<h1>",
      \ "finish": "</h1>"
      \ },
      \ "script": {
      \ "start": "<script>",
      \ "finish": "</script>"
      \ },
      \ "<": {
      \ "start": "<",
      \ "finish": ">"
      \ },
      \ }

map rp( <Plug>(dps_kakkonan_replace_parenthesis)
map rp{ <Plug>(dps_kakkonan_replace_curly)
map rp[ <Plug>(dps_kakkonan_replace_square)
map rp" <Plug>(dps_kakkonan_replace_doublequote)
map rp' <Plug>(dps_kakkonan_replace_singlequote)
map rp` <Plug>(dps_kakkonan_replace_backquote)
map <Leader>dk <Plug>(dps_kakkonan_delete_brackets)

autocmd BufWritePost *.toml call dpp#make_state(s:dpp_base, '$HOME/dotfiles/dpp_config.ts')

call setcellwidths([
      \ [0xe5ff, 0xe5ff, 2],
      \ [0xe628, 0xe628, 2],
      \ [0xe62b, 0xe62b, 2],
      \ [0xe609, 0xe609, 2],
      \ [0xe795, 0xe795, 2],
      \ [0xe615, 0xe615, 2],
      \ [0xe755, 0xe755, 2],
      \ [0xe627, 0xe627, 2],
      \ [0xe612, 0xe612, 2],
      \ [0xe60e, 0xe60e, 2],
      \ [0xe614, 0xe614, 2],
      \ ])
