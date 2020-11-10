#!/bin/bash
set -e  # exit on first error
UBUNTU_VERSION=`lsb_release --release | cut -f2`
SRC_PATH="/tmp"

main(){
    if [ $UBUNTU_VERSION == "16.04" ]; then
        install_osqp
        install_osqp_eigen
    fi
}

install_osqp() {
    cp Osqp.zip $SRC_PATH
    cd $SRC_PATH
    unzip Osqp.zip
    
    # go into Osqp folder and prepare for build
    cd $SRC_PATH
    cd Osqp/osqp
    
    # compile and install
    mkdir -p build
    cd build
    cmake ../
    sudo make install
    
    echo "Osqp has been installed successfully if there's no error"
}

install_osqp_eigen() {
    cd $SRC_PATH
    cd Osqp/osqp-eigen
    
    # compile and install
    mkdir -p build
    cd build
    cmake ../
    sudo make install
    
    echo "osqp_eigen has been installed successfully if there's no error"
}


# MAIN
main
