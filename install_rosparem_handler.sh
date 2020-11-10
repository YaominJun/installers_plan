#!/bin/bash
set -e  # exit on first error
UBUNTU_VERSION=`lsb_release --release | cut -f2`
SRC_PATH="../ivrc_ws/src/"
PARAMHANDLER_VERSION=0.1.3

main(){
    if [ $UBUNTU_VERSION == "16.04" ]; then
        install_rosparam_handler
    fi
}

install_rosparam_handler() {
    cd $SRC_PATH
    # clone ceres-solver if directory does not already exist, or pull
    if [ ! -d rosparam_handler ]; then
        git clone https://github.com/cbandera/rosparam_handler.git
    else
    	cd rosparam_handler
    	git checkout master
    	git pull
    	cd ..
    fi

    # go into ceres-solver repo and prepare for build
    cd rosparam_handler/
    git checkout master
    git checkout tags/${PARAMHANDLER_VERSION}
    mkdir -p build
    cd build
    
    cmake -DBUILD_SHARED_LIBS=ON ..

    
    # compile and install
    make -j$(nproc) 2>&1 | grep ...
    sudo make install

}


# MAIN
main
