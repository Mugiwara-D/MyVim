set nocompatible	" Disable compatibility with vi.

filetype on			" Vim will be able to try to detect the type of file in use.

filetype plugin on	" Enable plugins and load plugin for the detected file type.

" Norminette.
let g:user42 = 'maderuel'
let g:mail42 = 'maderuel@student.42.fr'

set modifiable

set number

" VIMSCRIPT -------------------------------------------------------------- {{{

" Code folding.

set viewoptions-=options " Disable options/mappings saving.
set viewoptions-=cursor " Disable cursor saving.

" Use the marker method of folding for vim file.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" Save fold (using zf) for .cpp and .hpp file.
augroup AutoSaveFolds
	autocmd!
	autocmd BufWinLeave *.{cpp,hpp} mkview
	autocmd BufWinEnter *.{cpp,hpp} silent! loadview
augroup END

" Set the color for character of the 81th.
highlight OverLength ctermfg=red guifg=red
highlight WhiteSpaceBackground ctermbg=red guibg=red

" Define a function to highlight the character at the 81st column.
function! HighlightOverLength()
    let l:col = 81
    let l:line = line(".")
    let l:char = matchstr(getline(l:line), '\%'.l:col.'c.')
	call matchadd('OverLength', '\%'.l:col.'c'.l:char)
endfunction

" }}}

" PLUGINS ---------------------------------------------------------------- {{{

call plug#begin('~/.vim/plugged')

  " Plug 'dense-analysis/ale'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'bfrg/vim-cpp-modern'
  Plug 'preservim/nerdtree' |
	\ Plug 'Xuyuanp/nerdtree-git-plugin' |
	\ Plug 'tiagofumo/vim-nerdtree-syntax-highlight' |
	\ Plug 'PhilRunninger/nerdtree-buffer-ops' |
	\ Plug 'PhilRunninger/nerdtree-visual-selection' |
	\ Plug 'ryanoasis/vim-devicons'

call plug#end()

" }}}

" PLUGINS_IMPROVE -------------------------------------------------------- {{{

" vim-cpp-modern.

" Disable function highlighting (affects both C and C++ files).
" let g:cpp_function_highlight = 0

" Enable highlighting of C++11 attributes.
let g:cpp_attributes_highlight = 1

" Highlight struct/class member variables (affects both C and C++ files).
let g:cpp_member_highlight = 1

" Put all standard C and C++ keywords under Vim's highlight group 'Statement'.
" (affects both C and C++ files).
let g:cpp_simple_highlight = 1

" NERDTree.

" Mapping.
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>?

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

set guifont=DroidSansMono\ Nerd\ Font\ 11

let g:WebDevIconsOS = 'Darwin'

" Disable line numbers.
let NERDTreeShowLineNumbers=0

" Tabline.

hi TabLine      ctermfg=LightGray  ctermbg=DarkGray     cterm=NONE
hi TabLineFill  ctermfg=NONE ctermbg=NONE     cterm=NONE
hi TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=bold

" }}}

"  HIGHLIGHT_VISUAL_SETTINGS ------------------------------------------------ {{{

" " Save the view state for all files when closing the window
" autocmd BufWinLeave *.{cpp,hpp} mkview

" " Restore the view state for all files when opening the window
" autocmd BufWinEnter *.{cpp,hpp} silent loadview

" Set the overall background color.
highlight Normal ctermbg=NONE ctermfg=NONE guibg=#0D223B guifg=NONE

" Enable line highlighting.
set cursorline

" Enable line highlighting only for the active buffer in normal mode.
augroup cursorline_settings
    autocmd!
    autocmd WinLeave,BufLeave * set nocursorline
    autocmd WinEnter,BufEnter * set cursorline
    autocmd InsertEnter,WinLeave,BufLeave * set nocursorline
    autocmd InsertLeave,WinEnter,BufEnter * set cursorline
augroup END

" Set the CursorLine highlight.
highlight CursorLine cterm=NONE ctermbg=24 guibg=#052D37

" Disable underlining for the current line number.
highlight CursorLineNr cterm=NONE ctermbg=NONE gui=NONE guibg=#0D223B

set number					" Set col number.
set numberwidth	=1			" Numbers size.	

" Disable relative number when leaving buffers/windows.
augroup relativeNumber
	autocmd!
	autocmd BufEnter * set relativenumber
	autocmd WinEnter * set relativenumber
	autocmd BufLeave * set norelativenumber
	autocmd WinLeave * set norelativenumber
augroup END

" Set different cursor depending on mode.
let &t_EI.="\e[2 q"  "t_EI = End Insert mode - usually starts NORMAL mode.
let &t_SR.="\e[4 q"  "t_SR = Start REPLACE mode.
let &t_SI.="\e[5 q"  "t_SI = Start INSERT mode.

" Reset the cursor shape on start.
augroup resetCursor
	autocmd!
	autocmd VimEnter * silent !echo -ne "\e[2 q"
	autocmd VimLeave * silent !echo -ne "\e[5 q"
augroup END

syntax enable		" Turn syntax highlighting on.

" Norminette length indicator when line extend over 80 char.
augroup normLen
	autocmd!
	autocmd FileType c,h set synmaxcol=80 | autocmd BufWinEnter * set synmaxcol=80
	autocmd FileType c,h autocmd BufWinEnter <buffer> call HighlightOverLength()
augroup END

" Set highlighting for tab.
hi TabLine      ctermfg=LightGray	ctermbg=DarkGray	cterm=NONE
hi TabLineFill  ctermfg=NONE		ctermbg=DarkGray
hi TabLineSel   ctermfg=White		ctermbg=24			cterm=bold

set ttyfast                " Faster redrawing.
set ttimeout
set ttimeoutlen=1
set lazyredraw             " Only redraw when necessary.

" Indent.
set autoindent		" Indent according to previous line.
set smartindent		" Indent according to the syntax of the code.
filetype indent on	" Enable filetype-specific indent settings.
autocmd FileType c,h,cpp,hpp setlocal cindent " Enable cindent.
set smarttab		" Replace Tab behavior.
set softtabstop	=4	" >> indents by 4 spaces.
set tabstop		=4	" Tab key indents by 4 spaces.
set shiftwidth	=4	" >> indents by 4 spaces.
set shiftround		" >> indents to next multiple of 'shiftwidth'.

" Break.
set wrap						" Do not allow long lines to extend.
set nolinebreak					" Disable auto line breaks at certain characters.
set breakindent					" Enable displaying broken lines.
set breakindentopt=shift:2		" Set the indentation for broken lines to 2 Spaces.

" }}}

" Navigation.
set scrolloff	=10	" n lines above and bellow when scrolling.
set nostartofline	" While navigate cursor do not jump at the begening of th line.

" Search.
set incsearch   " Highlight while searching with / or ?.
set hlsearch    " Keep matches highlighted.
set ignorecase  " Ignore capital letters during search.
set smartcase   " Override the ignorecase while searching capital letter.
set wrapscan    " Allow to search in all the file.

set showcmd			    " Show command you type in the last line of the screen.
set showmode			" Show the mode you are on the last line.
set wildmenu            " Enable auto completion menu after pressing TAB.
set wildmode	=list:longest   " Make wildmenu behave like similar to Bash.
set history		=100			" Number of commands stored using history.

" Status line configuration.
set laststatus=2
set statusline=%<%f\ %h%m%r%=%-14.(%l/%L,%c%V%)\ %p%%
" Customize the color of the status line.
highlight StatusLine ctermfg=23 ctermbg=White 
"Customize the status line of the inactive window
highlight StatusLineNC ctermfg=239 ctermbg=LightGray
set ruler

" Include the last line in the display.
set display+=lastline

" Split.
set splitbelow				" Open new windows below the current window.
set splitright				" Open new windows right of the current window.
set termwinsize=10*0		" Set the default :term height to 10.
set fillchars+=vert:\|		" Set the vertical char split to \|.
highlight VertSplit ctermfg=DarkGray ctermbg=DarkGray guifg=NONE guibg=NONE

" Desactivate bell sound.
set noerrorbells
set visualbell t_vb=

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

" Quickly jump to header or source file.
autocmd BufLeave *.{c,cpp} mark C
autocmd BufLeave *.{h,hpp} mark H

" Quickly add empty lines.
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" Ctags.
" Automatically run ctags -R . when entering Vim in a project directory
autocmd VimEnter,BufWinEnter *.{c,h} silent! !ctags --fields=+iaS --extras=+q --languages=c -Rf .tags
autocmd VimEnter,BufWinEnter *.{cpp,hpp} silent! !ctags --fields=+iaS --extras=+q --languages=c++ -Rf .tags

set tags=./tags;/,tags;./.tags;,.tags;
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <C-v><C-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" After a re-source, fix syntax matching issues (concealing brackets).
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif
