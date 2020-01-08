" 基本设置----------------{{{
" 不兼容vi模式 必须放在第一行
set nocompatible
syntax on                   " 开启语法高亮
set cursorline              " 高亮当前行
set incsearch               " 开启搜索高亮
set history =500            " 设定历史记录数
set clipboard=unnamedplus   " 设定为系统剪贴板
set nobackup                " 消除~后缀备份文件
set noundofile              " 消除un后缀备份文件
set number                  " 显示行号
set hlsearch                " 高亮搜索项
"------------------------------- tab 相关设置 ---------------------
set tabstop=4                " 设置tab的宽度
set shiftwidth=4             " 每一次缩进对应的空格数
set softtabstop=4            " 按退格键是可以一次删除4个空格
set smarttab                 
set expandtab                " 将tab自动转化为空格
set shiftround               " 缩进时，取整

set smartindent              " 智能缩进
set autoindent               " 自动缩进
set textwidth=79
let mapleader=","            " 设置mapleader为逗号
set fileformat=unix          " Set保存文件格式
" 设置编码
set encoding=utf-8
language messages zh_CN.utf-8
set t_Co=256

" Tab Set -------------------
augroup tab_set
    autocmd!
    autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp,javascript set ai
    autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp,javascript set sw=4
    autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp,javascript set ts=4
    autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp,javascript set sts=4
    autocmd FileType coffee,html,css,xml set ai
    autocmd FileType coffee,html,css,xml set sw=2
    autocmd FileType coffee,html,css,xml set ts=2
    autocmd FileType coffee,html,css,xml set sts=2
    autocmd FileType yaml setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2
augroup END
"}}}

" 映射-------------------{{{
" CTRL-A 是全选  
map <C-A> ggVGY
map! <C-A> <Esc>ggVGY
map <F12> gg=G
set number
noremap <F3> :set invnumber<CR>
inoremap <F3> <C-O>:set invnumber<CR>
" Turn on/off Tagbar
map <C-t> :set nosplitright<CR>:TagbarToggle<CR>:set splitright<CR>
" 选中状态下 Ctrl+c 复制
vmap <C-c> "+y
set pastetoggle=<F2>
" 定义快速打开加载.vimrc和.vimrc.vundle文件
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ep :split $HOME/.vimrc.vundle<cr>

" c-j/k映射成翻页键
nnoremap <c-j> <c-f>
nnoremap <c-k> <c-b>

" C-W +j/k/l/h可以窗口切换光标，不用按多次w
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L> 
nnoremap <C-H> <C-W><C-H> 
" 快速保存,退出,add 'stty -ixon' to .bashrc
imap   <C-S>   <ESC>:w<CR>
map    <C-S>   :w<CR>
imap   <C-Q>   <ESC>:q<CR>
map    <C-Q>   :q<CR>

" Enter F5 to compile and run programs
map <F5> :call CompileRun()<CR>
func! CompileRun()
    exec "W"
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
    elseif &filetype == 'ruby'
        :!time ruby ./%
    elseif &filetype == 'go'
        exec "!go build %<"
        exec "!time go run %"
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

"}}}

" Vundle ------------------{{{
filetype off " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Directory tree and related plugins
Plugin 'scrooloose/nerdtree' 
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ryanoasis/vim-devicons'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'majutsushi/tagbar'  " show tags in a bar (functions etc) for easy browsing
"open short-cut
map <C-n> :NERDTreeToggle<CR>
"打开vim时如果没有文件自动打开NERDTree
autocmd vimenter * if !argc()|NERDTree|endif
"let g:NERDTreeWinSize = 25 "设定 NERDTree 视窗大小
" ignore file types
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let g:NERDTreeHidden=0     "不显示隐藏文件
let g:NERDTreeShowLineNumbers=1  " 是否显示行号
"当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"设置树的显示图标,required vim should support multi-byte, putty using Consolas font
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
"Making it prettier
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
set guifont=DroidSansMono_Nerd_Font:h11
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" Code automatic completion 
Plugin 'Valloric/YouCompleteMe'
let g:ycm_server_python_interpreter = '/home/ke/.pyenv/versions/2.7.16/bin/python'
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone
noremap <c-z> <NOP>

" Python code automatic completion 
Plugin 'davidhalter/jedi-vim'
Plugin 'roxma/nvim-yarp' " dependency of ncm2
Plugin 'ncm2/ncm2'       " awesome autocomplete plugin
Plugin 'HansPinckaers/ncm2-jedi' " fast python completion (use ncm2 if you want type info or snippet support)
Plugin 'ncm2/ncm2-bufword'     " buffer keyword completion
Plugin 'ncm2/ncm2-path'        " filepath completion<Paste>
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
let g:jedi#enable_speed_debugging=0"

" Status bar setting  --------------------
Plugin 'Lokaltog/vim-powerline'
let g:minBufExplForceSyntaxEnable = 1

if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

set laststatus=2 " Always display the statusline in all windows
set guifont=Inconsolata\ for\ Powerline:h14
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

Plugin 'Yggdroot/indentLine'
map <C-l> :IndentLinesToggle<CR>
Plugin 'tell-k/vim-autopep8'
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>

" Code comments 
Plugin 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims=1       " Add one blank space
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv

Plugin 'scrooloose/syntastic'
let g:syntastic_error_symbol='X'
let g:syntastic_warning_symbol='▸'
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_enable_highlighting=1
let g:syntastic_python_checkers=['pyflakes'] " 使用pyflakes,速度比pylint快
let g:syntastic_html_checkers=['tidy']
" 修改高亮的背景色, 适应主题
highlight SyntasticErrorSign guifg=white guibg=black
" to see error location list
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_loc_list_height = 5
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction
nnoremap <Leader>s :call ToggleErrors()<cr>

Plugin 'jiangmiao/auto-pairs'


" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" All of your Plugins must be added before the following line
call vundle#end()            " required
"}}}

filetype plugin indent on    " required

" Editor color scheme setting  --------------------
colorscheme onedark
" colorscheme gruvbox
if has('gui_running')
    set background=light
else
    set background=dark
endif
"colorscheme solarized

" Program languages file title setting  --------------------
augroup program_lang
    "   autocmd!
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
            call append(line(".")+13, "")
            call append(line(".")+14, "int main()")
            call append(line(".")+15, "{")
            call append(line(".")+16, "    printf(\"Hello, World!\\n\");")
            call append(line(".")+17, "    return (0);")
            call append(line(".")+18, "}")
            " Delete the blank lines 2 and 3 of created file
            2,3d
        elseif &filetype == 'cpp'
            call append(line(".")+12, "#include <iostream>")
            call append(line(".")+13, "using namespace std;")
            call append(line(".")+14, "")
            call append(line(".")+15, "int main()")
            call append(line(".")+16, "{")
            call append(line(".")+17, "    std::cout << \"What's up!\\n\";")
            call append(line(".")+18, "    return (0);")
            call append(line(".")+19, "}")
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
" END program languages file title setting --------------------
" -------------------End Python
