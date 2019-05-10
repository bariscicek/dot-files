#!/bin/sh

install_icdiff() {
    echo "Installing icdiff..."
    sudo pip install git+https://github.com/jeffkaufman/icdiff.git
}

replace_config() {
    echo "Copying .gitconfig..."
    mv -f ~/.gitconfig ~/.gitconfig.save
    cp ./.gitconfig ~/.gitconfig
}

install_icdiff
replace_config
