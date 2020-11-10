#!/bin/bash
set -e

main()
{
  install_apt_pkgs
  install_cppad
}

install_apt_pkgs() {
  sudo apt-get update
  sudo apt-get -y install cmake g++
}

install_cppad()
{
    echo "Prepare to install CppAD ..."
    CppAD="cppad"
    VERSION="20180000.0"
    CppAD_URL="http://www.coin-or.org/download/source/CppAD/$CppAD-$VERSION.gpl.tgz"
    TEMP_DIR=$(mktemp -d)
    CPPADDIR="$TEMP_DIR/$CppAD-$VERSION"
    #sudo apt-get -qq install cmake
    if ( ls /usr/include | grep cppad );then
        echo "cppad is already installed......"
    else
        cd $TEMP_DIR
        wget $CppAD_URL
        tar -xf $CppAD-$VERSION.gpl.tgz
        rm -f $CppAD-$VERSION.gpl.tgz
        mkdir -p $CppAD-$VERSION/build
        cd $CppAD-$VERSION/build
        cmake \
            -D cppad_cxx_flags="-Wall -ansi -pedantic-errors -std=c++11 -Wshadow" \
            ..
        sudo make install
        echo "CppAD installed successfully"
        cd $TEMP_DIR
        rm -rf $CppAD-$VERSION
    fi
}

main
