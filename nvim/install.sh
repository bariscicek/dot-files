#!/bin/sh

VIM_RUNTIME=~/.vim_runtime

install_vimawesome() {
    echo "Installing vim awesome..."
    git clone --depth=1 https://github.com/amix/vimrc.git $VIM_RUNTIME
    sh $VIM_RUNTIME/install_awesome_vimrc.sh
}

install_myplugins() {
    echo "Installing my plugings..."
    CURRENT_DIR=`pwd`
    PLUGIN_HOSTS=`cat ./my_plugins.hosts`
    for i in $PLUGIN_HOSTS; do
        cd $VIM_RUNTIME/my_plugins
        git clone $i
    done
    cd $CURRENT_DIR
}

copy_myconfig() {
    echo "Copying my_configs.vim..."
    cp ./my_configs.vim $VIM_RUNTIME/my_configs.vim
}

copy_initvm() {
    echo "Copying init.vim"
    mkdir -p ~/.config/nvim/
    cp ./init.vim ~/.config/nvim/init.vim
}


install_vimawesome
install_myplugins
copy_myconfig
copy_initvm
