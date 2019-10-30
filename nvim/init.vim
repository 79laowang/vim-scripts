
call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'  "to highlight files in nerdtree

Plug 'Vimjas/vim-python-pep8-indent'  "better indenting for python
Plug 'Yggdroot/indentLine'
map <C-l> :IndentLinesToggle<CR>

Plug 'davidhalter/jedi-vim'
Plug 'roxma/nvim-yarp'  " dependency of ncm2
Plug 'ncm2/ncm2'  " awesome autocomplete plugin
Plug 'HansPinckaers/ncm2-jedi'  " fast python completion (use ncm2 if you want type info or snippet support)
Plug 'ncm2/ncm2-bufword'  " buffer keyword completion
Plug 'ncm2/ncm2-path'  " filepath completion<Paste>

Plug 'majutsushi/tagbar'  " show tags in a bar (functions etc) for easy browsing

Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'KeitaNakamura/neodark.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/vim-easy-align'

Plug 'mattn/emmet-vim'

Plug 'jiangmiao/auto-pairs'

Plug 'scrooloose/nerdcommenter'

Plug 'sbdchd/neoformat'

Plug 'neomake/neomake'

Plug 'tmhedberg/SimpylFold'

Plug 'kien/ctrlp.vim'  " fuzzy search files


call plug#end()

" ----------------------- Common setting --------------------
" path to your python 
let g:python3_host_prog = '/home/kkewang/.pyenv/versions/3.8.0/bin/python3'
let g:python_host_prog = '/usr/bin/python2'
set nocompatible
filetype plugin on
" 设置空白字符的视觉提示
set list listchars=extends:❯,precedes:❮,tab:▸\ ,trail:˽
" 高亮当前行
set cursorline
" 显示行号
set t_Co=256
set number
syntax enable
set smartindent              " 智能缩进
set autoindent               " 自动缩进

" Set color scheme
set background=dark
"colorscheme solarized
"colorscheme neodark
colorscheme gruvbox

" Enable alignment
let g:neoformat_basic_format_align = 1
" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1
" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

let g:neomake_python_enabled_makers = ['pylint']

" highlight python and self function
autocmd BufEnter * syntax match Type /\v\.[a-zA-Z0-9_]+\ze(\[|\s|$|,|\]|\)|\.|:)/hs=s+1
autocmd BufEnter * syntax match pythonFunction /\v[[:alnum:]_]+\ze(\s?\()/
hi def link pythonFunction Function
autocmd BufEnter * syntax match Self "\(\W\|^\)\@<=self\(\.\)\@="
highlight self ctermfg=239

" jedi options
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "1"
let g:jedi#show_call_signatures_delay = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#show_call_signatures_modes = 'i'  " ni = also in normal mode
let g:jedi#enable_speed_debugging=0

autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=menuone,noselect,noinsert
" make it FAST
let ncm2#popup_delay = 5
let ncm2#complete_length = [[1,1]]
let g:ncm2#matcher = 'substrfuzzy'

" Impsort option
hi pythonImportedObject ctermfg=127
hi pythonImportedFuncDef ctermfg=127
hi pythonImportedClassDef ctermfg=127

" Ctrl+N 打开/关闭
map <C-n> :NERDTreeToggle<CR>
" 当不带参数打开Vim时自动加载项目树
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" 当所有文件关闭时关闭项目树窗格
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" 不显示这些文件
let NERDTreeIgnore=['\.pyc$', '\~$', 'node_modules'] "ignore files in NERDTree
" 不显示项目树上额外的信息，例如帮助、提示什么的
let NERDTreeMinimalUI=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

let g:NERDSpaceDelims=1       " Add one blank space
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv
set number
noremap <F3> :set invnumber<CR>
inoremap <F3> <C-O>:set invnumber<CR>

" Enable folding
set foldmethod=indent
set foldlevel=99
" 代码折叠要手动输入za来折叠和取消，下面使用空格键映射
" Enable folding with the spacebar
nnoremap <space> za
" 希望看到折叠代码的文档字符串 
let g:SimpylFold_docstring_preview=1

set tabstop=4
set softtabstop=4
set shiftwidth=4

" 支持PEP8风格的缩进
au BufNewFile,BufRead *.py
	\ set tabstop=4 | 
	\ set softtabstop=4 |
	\ set shiftwidth=4 |
	\ set textwidth=79 |
	\ set expandtab |
	\ set autoindent |
	\ set fileformat=unix
" Keep indentation level from previous line:
"autocmd FileType python set autoindent
let g:pymode_indent = 0

" 支持UTF-8编码
set encoding=utf-8

" 快速保存,退出,add 'stty -ixon' to .bashrc
imap   <C-S>   <ESC>:w<CR>
map    <C-S>   :w<CR>
imap   <C-Q>   <ESC>:q<CR>
map    <C-Q>   :q<CR>

" Turn on/off paste mode
set pastetoggle=<F2>

" Turn on/off Tagbar
map <C-t> :set nosplitright<CR>:TagbarToggle<CR>:set splitright<CR>

" Enter F5 to compile and run programs
map <F5> :call CompileRun()<CR>
func! CompileRun()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -Wall -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -Wall -o %<"
        exec "! ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!java %<"
    elseif &filetype == 'sh'
        :!time bash ./%
    elseif &filetype == 'python'
        exec '!time python' shellescape(@%, 1)
    endif
endfunc

"C,C++的调试
map <F6> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc


augroup program_lang
autocmd BufNewFile *.py,*.cpp,*.[ch],*.sh,*.java exec ":call SetLangTitle()"
   function! SetLangTitle()
       " Define default annotation symbol
       if (&filetype == 'python') || (&filetype == 'sh')
           let lineas = "#"
           if &filetype == 'sh'
               call setline(1, lineas."!/usr/bin/env bash")
           else
               call setline(1, lineas."!/usr/bin/env python")
           endif
           call append(line("."), lineas." -*- coding:utf-8 -*-")
           call append(line(".")+1, lineas."-------------------------------------------------------------------------------")
       elseif (&filetype == 'c') || (&filetype == 'cpp') || (&filetype == 'java')
           let lineas = "*"
           call setline(1, "/*------------------------------------------------------------------------------")
           call append(line("."), lineas)
           call append(line(".")+1, lineas)
       endif
       call append(line(".")+2, lineas." File Name:   ".expand("%"))
       call append(line(".")+3, lineas." Purpose:    ")
       call append(line(".")+4, lineas)
       call append(line(".")+5, lineas." Author:      Ke Wang")
       call append(line(".")+6, lineas)
       call append(line(".")+7, lineas." Created:     ".strftime("%Y-%m-%d",localtime()))
       call append(line(".")+8, lineas." Copyright:   (c) Ke Wang ".strftime("%Y"))
       call append(line(".")+9, lineas." Licence:     <your licence>")
       if (&filetype == 'python') || (&filetype == 'sh')
           call append(line(".")+10, lineas."-------------------------------------------------------------------------------")
       endif
       if (&filetype == 'c') || (&filetype == 'cpp') || (&filetype == 'java')
           call append(line(".")+10, lineas."-----------------------------------------------------------------------------*/")
       endif
       call append(line(".")+11, "")
       if &filetype == 'python'
           call append(line(".")+12, "def main():")
           call append(line(".")+13, "    pass")
           call append(line(".")+14, "")
           call append(line(".")+15, "if __name__ == '__main__':")
           call append(line(".")+16, "    main()")
       elseif &filetype == 'sh'
           call append(line(".")+12, "main(){")
           call append(line(".")+13, "    :")
           call append(line(".")+14, "}")
           call append(line(".")+15, "")
           call append(line(".")+16, "#---------------- Main Program --------------")
           call append(line(".")+17, "main \"\$\@\"")
       elseif &filetype == 'c'
           call append(line(".")+12, "#include <stdio.h>")
           call append(line(".")+13, "int main()")
           call append(line(".")+14, "{")
           call append(line(".")+15, "    printf(\"Hello, World!\\n\");")
           call append(line(".")+16, "    return (0);")
           call append(line(".")+17, "}")
           " Delete the blank lines 2 and 3 of created file
           2,3d
       elseif &filetype == 'cpp'
           call append(line(".")+12, "#include <iostream>")
           call append(line(".")+13, "using namespace std;")
           call append(line(".")+14, "int main()")
           call append(line(".")+15, "{")
           call append(line(".")+16, "    std::cout << \"What's up!\\n\";")
           call append(line(".")+17, "    return (0);")
           call append(line(".")+18, "}")
           " Delete the blank lines 2 and 3 of created file
           2,3d
       elseif &filetype == 'java'
           call append(line(".")+12, "public class ".expand("%:r")." {")
           call append(line(".")+13, "    /**")
           call append(line(".")+14, "     * @param args the command line arguments")
           call append(line(".")+15, "     */")
           call append(line(".")+16, "")
           call append(line(".")+17, "    public static void main(String[] args) {")
           call append(line(".")+18, "        System.out.println(\"Hello World!\");")
           call append(line(".")+19, "    }")
           call append(line(".")+20, "}")
           " Delete the blank lines 2 and 3 of created file
           2,3d
       endif
       " file created，go to the bottom of file
       autocmd BufNewFile * normal G
   endfunc
augroup END
