#!/bin/bash
set -e  # exit on first error
UBUNTU_VERSION=`lsb_release --release | cut -f2`
SRC_PATH="/tmp"
PROTOBUF_BENCHMARK_VERSION=3.13.0.0

main(){
    if [ $UBUNTU_VERSION == "16.04" ]; then
	install_dependencies
        install_google_protobuf
    fi
}

install_dependencies(){
    sudo apt-get install autoconf automake libtool curl make g++ unzip
}

install_google_protobuf() {
    cp protobuf-all-3.13.0.tar.gz $SRC_PATH
    cd $SRC_PATH
    tar -xf protobuf-all-3.13.0.tar.gz   
    cd protobuf-3.13.0
    
    # go into protobuf folder and prepare for build
    ./autogen.sh
    
    # compile and install
    ./configure
    make
    make check
    sudo make install
    sudo ldconfig # refresh shared library cache.
    
    #test if it's successfully
    #cmake -E chdir "build" ctest --build-config Release

    echo "protobuf-3.13.0 has been installed successfully if there's no error"
}


# MAIN
main
