#!/bin/bash
set -e  # exit on first error
UBUNTU_VERSION=`lsb_release --release | cut -f2`
SRC_PATH="/tmp"
OPENCV_BENCHMARK_VERSION=v2.4.13

main(){
    if [ $UBUNTU_VERSION == "16.04" ]; then
        install_opencv_2_4
    fi
}

install_opencv_2_4() {
    cp opencv-2.4.13-gcc6.tar.gz $SRC_PATH
    cd $SRC_PATH
    if [! -d opencv-2.4.13]; then
    	tar -xf opencv-2.4.13-gcc6.tar.gz
    else
	sudo rm -r opencv-2.4.13
	tar -xf opencv-2.4.13-gcc6.tar.gz
    
    # go into opencv-2.4.13 folder and prepare for build
    cd opencv-2.4.13
    
    # compile and install
    mkdir build
    cd build
    cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local .. -DENABLE_PRECOMPILED_HEADERS=OFF
    sudo make install
    
    #test if it's successfully
    #cmake -E chdir "build" ctest --build-config Release

    echo "opencv-2.4.13 has been installed successfully if there's no error"
}


# MAIN
main
