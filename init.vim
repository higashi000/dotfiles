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

nnoremap <silent> <Leader>d :LspDefinition<CR>
nnoremap <silent> <Leader>f :LspDocumentFormat<CR>
nnoremap <silent> <Leader>h :LspHover<CR>
nnoremap <silent> <Leader>r :LspRename<CR>
nnoremap <silent> <Leader>a :LspCodeAction<CR>
nnoremap <silent> <Leader>ne :LspNextError<CR>
nnoremap <silent> <Leader>pe :LspPreviousError<CR>
nnoremap <silent> <Leader>td :LspTypeDefinition<CR>

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
      \ [0xe60d, 0xe60d, 2],
      \ [0xe60b, 0xe60b, 2],
      \ [0xe7b0, 0xe7b0, 2],
      \ ])
