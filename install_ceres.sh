#!/bin/bash
set -e  # exit on first error
UBUNTU_VERSION=`lsb_release --release | cut -f2`
SRC_PATH="/tmp"
CERES_VERSION=1.12.0

main(){
    if [ $UBUNTU_VERSION == "16.04" ]; then
        install_dependencies
        install_ceres_solver
    fi
}

install_dependencies() {
    sudo apt-get update -qq
    sudo apt-get install -qq -y cmake \
                           libgoogle-glog-dev \
                           libatlas-base-dev \
                           libeigen3-dev \
                           libsuitesparse-dev
}


install_ceres_solver() {
    cd $SRC_PATH
    # clone ceres-solver if directory does not already exist, or pull
    if [ ! -d ceres-solver ]; then
        git clone https://github.com/ceres-solver/ceres-solver.git
    else
    	cd ceres-solver
    	git checkout master
    	git pull
    	cd ..
    fi

    # go into ceres-solver repo and prepare for build
    cd ceres-solver
    git checkout tags/${CERES_VERSION}
    mkdir -p build
    cd build
    cmake -DBUILD_SHARED_LIBS=ON ..

    # compile and install
    make -j$(nproc) 2>&1 | grep ...
    sudo make install
}


# MAIN
main
