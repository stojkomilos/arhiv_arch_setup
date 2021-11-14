" Do ":so%" after changing the config file to reflect the changes(only works in this file)
" For help about any nvim command (anything from this file) do: ':h <command>'

" Set the leader key to " " (space)
let mapleader =  " "

" Something for Windows 10 comptability
set nocompatible

" Fold/Unfold
nnoremap , za

" Plugins
call plug#begin("~/.vim/plugged")
    Plug 'gruvbox-community/gruvbox'        " Colorscheme
    Plug 'tomasiser/vim-code-dark'          " Colorscheme

call plug#end()

syntax enable

filetype plugin on

" Theme (e.g. light or dark theme)
set background=dark

" Enables highlighting when searching with "/", to disable do // or ":nohl"
set hlsearch

" Make search canse insenitive, you can make it sensitive with \C
set ignorecase

" Highlights as you search
set incsearch

" Enable relative lines
set relativenumber

" Makes your current line show the actual line number in the file (used for "set relativenumber")
set number

" Enables autocompletion for file names
set path+=**

" Autocomplete commands, files, everything. Ctrl+n(n=next), Ctrl+p(p=previous)
set wildmode=longest,list,full

" Auto completion ignore case
set wildignorecase

" Markdown preview https://github.com/iamcco/markdown-preview.nvim =========================================================
nmap <C-s> <Plug>MarkdownPreview

" Enables you to increment (or decrement) letters with Ctrl+a (decrement - Ctrl+x)
set nrformats+=alpha


"================================================================================================================================================
" Copy/paste from and to system with Ctrl-c and Ctrl-p . Potentially better than sharing the vim copy/paste clipboard with the system. This will only put it to the system clipboard if you do Ctr+c (in visual mode) and Ctrl+p(any mode). If using this, disable the line "set clipboard=unnamedplus". (the system clipboard is in the "+ register)
"vnoremap <C-c> "+y
"noremap <C-v> "+P


" " Copy to clipboard
"vnoremap  <leader>y  "+y
"nnoremap  <leader>Y  "+yg_
"nnoremap  <leader>y  "+y
"nnoremap  <leader>yy  "+yy
"
"" " Paste from clipboard
"nnoremap <leader>p "+p
"nnoremap <leader>P "+P
"vnoremap <leader>p "+p
"vnoremap <leader>P "+P
" Makes vim share the copy paste clipboard with the system
set clipboard=unnamedplus
"==============================================================================


" Fold stuff
set foldenable
set foldmethod=marker

" tabing spacing ============
set tabstop=4
set expandtab

" Enables auto indentation. Indents the next line like the current one.
set autoindent

" vidi da li je essential, grupisati sa: set tabstop=
set softtabstop=4

set smartindent " Idk, some say you should use, some say you shouldn't

" Makes tabbing smarted and realizes you have 2 vs 4
" TODO:
set smarttab

" set the tab length in spaces
" auto indentation on new line
set shiftwidth=4

" ===========================

" Disable wrap
set nowrap

" F5 compiles currently open file based on file type
" Compile markdown (.md) files to the pdf equivalent, and open it in brave //TODO open it in $BROWSER
autocmd FileType markdown noremap <f5> <esc>:w<enter> :!pandoc %:p -o %:p:r.pdf <enter>
" Compile C++ code (TODO: open resulting program in new window or something like that?)
autocmd FileType cpp nnoremap <f5> <esc>:w<enter>:!g++ -std=c++17 -lncurses %:p -o %:p:r<enter>
autocmd FileType c nnoremap <f5> <esc>:w<enter>:!gcc %:p -o %:p:r<enter>

" Spell check (o for ortography??), staviti mozda da detektuje na kojoj sam tastaturi i da taj jezik checkuje?
nnoremap <leader>e :setlocal spell! spelllang=en_us<Enter>
nnoremap <leader>s :setlocal spell! spelllang=sr_RS<Enter>
"nnoremap <leader>l :setlocal spell! spelllang=sr_latin<Enter>



" Enables changing your cursor position with mouse (you should use this very rarely)
set mouse=a


" Enable wrap for markdown files
autocmd BufEnter *.md set wrap

" Vim-studio-dark colortheme for everything except for markdown (.md) files
autocmd BufEnter * colorscheme codedark
autocmd BufEnter *.md colorscheme gruvbox

" When you scroll up/down, it makes your screen move before your cursor hits the last/first line
set scrolloff=5

" Sets the process title to something related to the file name
set title

" Replace all globally is aliased to S (S = substitute)
nnoremap S :%s//g<left><left>

" Press "//" after searching to unhighlight
nnoremap // :noh<return>

set ruler " (default on)

" Probably useless - SECTION: - -------------------------------

" Enables a terminal (you already have a window manager and shortcuts, just use those)
nnoremap \ :te<enter> 

set encoding=utf-8
set fileencoding=utf-8

" Disable automatic commenting on new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" TODO: vidi ovo, |luke smith|, syntax check za .sh fajlove, i da je sugestije(za .sh fajlove)
map <leader>c :!clear && shellcheck -x %<Enter>

" Something for multi window stuff
set hidden

" Undo stuff, idk
set undodir=~/.vim/undodir
set undofile

" Disable backup file
set nobackup
set noswapfile
set nowritebackup

" Status line
set statusline=
set statusline+=%*\ %<%.60F%*                      " path, trunc to 80 length
set statusline+=\ [%{strlen(&ft)?&ft:'none'}]      " filetype
set statusline+=%*\ %l:%c%*                        " current line and column
set statusline+=%*\ %p%%%*                         " percentage

" Something with terminal colors
set termguicolors

" For better navigation with wrapped lines
noremap j gj
noremap k gk

" Make Y consistent with D and C (yank til end)
nnoremap Y y$

" Arhiv ============================================================

" Makes backspace behave normally
"set backspace=indent,eol,start

" Enable paste mode (disables indentation, pastes everything literally)
"set pastetoggle=<F2>

" Enables the graphical line on your current line
"set cursorline
"highlight Cursorline cterm=bold

" Enables transparency. Background becomes like the terminal one
"highlight normal guibg=none

" Redraws the screen when it needs to, usefull when using long macros, or on slow pc-s
"set lazyredraw 

" Better tabbing (when you tab a selection, it does not deselect after 1 tab)
" Pussy? Moze samo "." da se ponovi komanda
"vnoremap < <gv
"vnoremap > >gv


" TODO
"set noshowmode
"set completeopt=menuone,noinsert,noselect

" vertical line on the right
"set colorcolumn=80

" IDK ARHIV ================================================================
"set omnifunc=syntaxcomplete#Complete


" idk, i ne moram da znam vrv, dodati u neku 3. kategoriju gde stoje stvari koje ne znam sta su i jednog dana mi mozda dodju korisne
" Tab in general mode will move to text buffer
"nnoremap <TAB> :bnext<CR>
" Shift-tab will go back
"nnoremap <S-TAB> :bprevious<CR>

" <TAB>: completion
"inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Better window navigation
" TODO, idk, kad budem koristio window navigation mogu ovo da razmotrim
"nnoremap <C-h> <C-w>h
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-l> <C-w>l


" idk, the bar on the left of line numbers, useful for git integration apparently
"set signcolumn=yes

" Idk, TODO, Having longer updatetime(default is 4000ms = 4s) leads to more noticiable delays and poor user experience.
"set updatetime=50

" Idk, likely useless
"set shortmess+=c

" NEKI FAJL, EVO CELI CONTETNI OVDE

""-moze se koristiti :find <file> da bi se nasao file, moze se TAB-ovati (moze
""se koristiti wildcard-ovi)
""-kad je upaljeno vise fajlova mogu se listovati sa :ls, a da bi usao u neki
""od njih moze sa :b <substring_imena_fajla>
"
"
""-nesto za nalazenje tagova: moze Ctrl+] ili Ctrl+g (ovo drugo cesce radi iz
""nekog razloga), da bi namestio tagove odes u parent directory i napises
"""ctags -R ."
"
""autocomplete:---------------------------------------
""-autocomplete Ctrl+n (trebaju tags)(kod tih lista kad se upale, moze Ctrl+P za
""previous element)
""-Ctrl+x+(ctrl)n, samo za taj file
""-Ctrl+x+(ctrl)], za imena fajlova
""-Ctrl+x+(ctrl)j, samo za tagove
"TODO: Neki shortcut za š, itd? Da ne moram da menjam tastaturu
"TODO: mozda? ukljuciti wrap za beleske

" usefull plugins: ctags, fzf, vim-vinegar,
"random citat: I use exuberate ctags/FZF/vim-vinegar to navigate between buffers and files, vimwiki for note taking and task management, ALE for linting/code formatting, and a couple of other tpope plugins to improve the native Vim experience like vim-commentary and vim-surround.
"random citat: Anecdotally... Almost everyone where I work uses vim + YCM + vimspector. We mostly c++ with lots of java and TCL and you name it. Reasonably big multi national company.

" dobro resenje za copy paste?
"

" Better indenting, ovo vrv bolje ne koristiti, jer moze samo . command da se koristi
"vnoremap < <gv
"vnoremap > >gv

"nnoremap <Tab> %

" Apparently useful plugins: pictures in terminal: Uberzug, coc, nerdtree, fzf (ili Ctrl P), vis.vim", lightline, airline, telescope, vim-which-key(keybind helper), nvim colorizer (oboji hex boje u terminalu), treesitter, undotree, fugitive, AG(search), tpope/vim-surround, Plugin stuff, smoothscroll (da se ne izgubis kad skrolas), snipmate, nerdcommenter, vim-easymotion, vim-fugitive (git stuff), vim gitgutter, delimitMate (automaticly close quotes and brackets):

" something for having seperate .vimrc for every project(that has a .vimrc in
" it), usefull for having specific vim configs for each project
"set exrc


" Some form of this is command is probably used for making it so your cursor is different on insert mode (default: on)
"set guicursor

" TODO: idk - Always show tabs
"set showtabline=2


" ovaj section je iz (tip stvarno preteruje sa svime): https://www.youtube.com/watch?v=gZCXaF-Lmco
" Makes popup menu smaller
"set pumheight=10

" So THAT I can see `` in markdown files (TODO: isprobati sa razlicitim levelima, mozda ce auto formatirati kad editujem da vec bude formatirano???)
"set conceallevel=0

" ==================================================================

    " Plug 'dhruvasagar/vim-table-mode'       " For tables (pandoc compatible)
    " Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    " Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    " Plug 'kblin/vim-fountain'
    " Plug 'vim-pandoc/vim-pandoc'            " Markdown
    " Plug 'vim-pandoc/vim-pandoc-syntax'     " Markdown
    "Plug 'godlygeek/tabular'
    "Plug 'plasticboy/vim-markdown'
    "Plug 'glacambre/firenvim'
    "Plug 'reedes/vim-pencil'
