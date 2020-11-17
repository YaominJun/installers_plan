#!/bin/bash
set -e  # exit on first error
UBUNTU_VERSION=`lsb_release --release | cut -f2`
SRC_PATH="/tmp"
#CASADI_VERSION

main(){
    if [ $UBUNTU_VERSION == "16.04" ]; then
        install_cadadi
    fi
}

install_cadadi() {
    cp casadi.tar.gz $SRC_PATH
    cd $SRC_PATH
    tar -xf casadi.tar.gz
    
    # go into benchmark folder and prepare for build
    cd casadi
    
    # compile and install
    mkdir -p build
    cd build
    cmake ../
    sudo make install
    
    #test if it's successfully
    #cmake -E chdir "build" ctest --build-config Release

    echo "casadi has been installed successfully if there's no error"
}


# MAIN
main
