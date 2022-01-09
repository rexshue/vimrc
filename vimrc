syntax on

set nocompatible
set smartindent
set shiftwidth=4
set backspace=indent,eol,start
set ruler
set number
set relativenumber
set showcmd
set showmatch                " Cursor shows matching ) and }
set showmode                 " Show current mode
set incsearch
set hlsearch
set hls
set ic
set pastetoggle=<F12>
set fileencodings=utf8,big5
set encoding=utf8
set mouse=a
filetype off

" vim-plug -----------
call plug#begin()
Plug 'junegunn/vim-plug'
Plug 'junegunn/vim-easy-align'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'easymotion/vim-easymotion'
"Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
"Plug 'dstein64/vim-startuptime'
Plug 'terryma/vim-multiple-cursors'
call plug#end()

" vim-easymotion ------
nmap ss <Plug>(easymotion-s2)

" coc setting ----------
let g:coc_global_extensions = [
\ 'coc-json',
\ 'coc-tsserver',
\ 'coc-marketplace',
"\ 'coc-snippets',
\ ]

set hidden
"set nobackup
"set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') -1
    return !col || getline('.')[col-1]
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use '[g' and ']g' to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID> show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'],&filetype) >= 0)
	execute 'h '.expand('<cword>')
    else
	call CocAction('doHover')
    endif
endfunction

" Highlights symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: '<leader>aap' for current
" paragraph
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Remap for codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf <Plug>(coc-fix-current)

" Create mappings for function text object, require document symbols feature
" of lang
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like:
" coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use ':Format' to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use ':Fold' to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Use ':OR' for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout ':h
" coc-status'
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a :<C-u>CocList diagnostics<CR>
" Manager extensions
nnoremap <silent> <space>e :<C-u>CocList extensions<CR>
" Show commands
nnoremap <silent> <space>c :<C-u>CocList commands<CR>
" Find symbol of current document
nnoremap <silent> <space>o :<C-u>CocList outline<CR>
" Search workspace symbols
nnoremap <silent> <space>s :<C-u>CocList -I symbols<CR>
" Do default action for next item
nnoremap <silent> <space>j :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent> <space>k :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p :<C-u>CocListResume<CR>

" coc-snipppets ------
" use <C-l> for trigger snippet expand
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeolder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeolder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x <Plug>(coc-convert-snippet)

" coc-marketplace -----------
" :CocList marketplace - list all available extensions
" :CocList marketplace python - to search extension that name contains
" 'python'
"
" vim-startuptime -----------
" :StartupTime
" <K> on events to get additional information
" <gf> on sourcing events to load the corresponding file in new split

" 基于缩进或语法进行代码折叠
"set foldmethod=indent
set foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable

" multip cursor
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

"for clippboard paste
set clipboard=unnamed

"for 游標行標註
set cursorline


