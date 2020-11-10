#!/bin/bash
set -e  # exit on first error
UBUNTU_VERSION=`lsb_release --release | cut -f2`
SRC_PATH="/tmp"
GOOGLE_BENCHMARK_VERSION=v1.5.0

main(){
    if [ $UBUNTU_VERSION == "16.04" ]; then
        install_google_benchmark
    fi
}

install_google_benchmark() {
    cp benchmark.zip $SRC_PATH
    cd $SRC_PATH
    unzip benchmark.zip
    
    # go into benchmark folder and prepare for build
    cd benchmark
    
    # compile and install
    mkdir -p build
    cd build
    cmake ../
    sudo make install
    
    #test if it's successfully
    #cmake -E chdir "build" ctest --build-config Release

    echo "benchmark has been installed successfully if there's no error"
}


# MAIN
main
