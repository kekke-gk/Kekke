augroup MyAutoCmd
	autocmd!
augroup END

runtime! debian.vim

if has("syntax")
  syntax on
endif

set ignorecase
set smartcase
set incsearch
set hlsearch

set number
set shiftwidth=4
set tabstop=4
set noexpandtab
set softtabstop=0
set shiftround
set infercase
set virtualedit=all
set showmatch
set matchpairs& matchpairs+=<:>
set backspace=indent,eol,start
set paste

"set list
set textwidth=0

set t_vb=
set novisualbell

set clipboard+=unnamed

set encoding=utf-8
set fileencodings=iso-2022-jp,sjis,euc-jp,utf-8

""
"" Vim-LaTeX
""
filetype plugin on
filetype indent on
set shellslash
let g:tex_flavor='latex'
let g:Imap_UsePlaceHolders = 1
let g:Imap_DeleteEmptyPlaceHolders = 1
let g:Imap_StickyPlaceHolders = 0
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='dvi,pdf'
"let g:Tex_FormatDependency_pdf = 'pdf'
let g:Tex_FormatDependency_pdf = 'dvi,pdf'
"let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf'
let g:Tex_FormatDependency_ps = 'dvi,ps'
let g:Tex_CompileRule_pdf = 'ptex2pdf -u -l -ot "-synctex=1 -interaction=nonstopmode -file-line-error-style" $*'
"let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = 'luajitlatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = 'xelatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = 'ps2pdf $*.ps'
let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
let g:Tex_CompileRule_dvi = 'uplatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
let g:Tex_BibtexFlavor = 'upbibtex'
let g:Tex_MakeIndexFlavor = 'upmendex $*.idx'
let g:Tex_UseEditorSettingInDVIViewer = 1
let g:Tex_ViewRule_pdf = 'xdg-open'
"let g:Tex_ViewRule_pdf = 'evince'
"let g:Tex_ViewRule_pdf = 'okular --unique'
"let g:Tex_ViewRule_pdf = 'zathura -s -x "vim --servername synctex -n --remote-silent +\%{line} \%{input}"'
"let g:Tex_ViewRule_pdf = 'qpdfview --unique'
"let g:Tex_ViewRule_pdf = 'texworks'
"let g:Tex_ViewRule_pdf = 'mupdf'
"let g:Tex_ViewRule_pdf = 'firefox -new-window'
"let g:Tex_ViewRule_pdf = 'chromium --new-window'

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
nnoremap j gj
nnoremap k gk

cnoremap mlt MultipleCursorsFind

nnoremap <Tab> %
vnoremap <Tab> %

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

noremap <C-c> <esc>
noremap! <C-c> <esc>

vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

cmap w!! w !sudo tee > /dev/null %

" NeoBundle
if !1 | finish | endif

if has('vim_starting')
	set nocompatible  
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

filetype plugin indent on
NeoBundleCheck

NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'vim-latex/vim-latex'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'

" Color Scheme
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'tomasr/molokai'
NeoBundle 'nanotech/jellybeans.vim'

call neobundle#end()


" ColorScheme
syntax on
set background=dark
colorscheme hybrid
colorscheme molokai
colorscheme jellybeans
