# vim-scripts
vim scripts and .vimrc config file
How to use it.
1. Install vim on your linux machine. 
2. Install plug-in manager Vundle for vim.
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim


3.  Configure Plugins:(Skip it, because here .vimrc included it)

Put this at the top of your .vimrc to use Vundle. Remove plugins you don't need, they are for illustration purposes.
```vim
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
```

4. Install Plugins:

Launch vim and run :PluginInstall

To install from command line: vim +PluginInstall +qall

5. Install theme onedark
```Bash
$ git clone https://github.com/joshdick/onedark.vim.git
$ cd onedark.vim/
$ [ ! -d ~/.vim/colors/ ] && mkdir -p ~/.vim/colors/
$ [ ! -d ~/.vim/autoload/ ] && mkdir -p ~/.vim/autoload/
$ cp colors/onedark.vim  ~/.vim/colors/
$ cp autoload/onedark.vim  ~/.vim/autoload/
```

6. Install YouCompleteMe need to compile with python. 
If you hit the following error,
```Bash
$ cd ~/.vim/bundle/YouCompleteMe
$ ./install.sh 
WARNING: this script is deprecated. Use the install.py script instead.
Searching Python 3.7 libraries...
ERROR: Python headers are missing in /usr/include/python3.7m.
```

On CentOS7.x if occurred the below errors,
CMake Error: your CXX compiler: "CMAKE_CXX_COMPILER-NOTFOUND" was not found. 
...

Solution:
```Bash
$ sudo yum install gcc-c++
```

On fedora, Install python3-devel package.
```Bash
$ sudo dnf install python3-devel
$ ./install.sh
```

If you hit the following error, when you open vi,
```Bash
YCM core library compiled for... Python 3. Set the 'g:ycm_server_python_interpreter' option to a Python 2 interpreter path
```

On Arch/Manjaro,
```Bash
sudo pacman -S clang # Compiled and get /usr/lib/libclang.so

cmake -G "Unix Makefiles" -DEXTERNAL_LIBCLANG_PATH=/usr/lib/libclang.so. ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
```
