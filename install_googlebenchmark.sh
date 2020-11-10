#!/bin/bash
set -e  # exit on first error
UBUNTU_VERSION=`lsb_release --release | cut -f2`
SRC_PATH="/tmp"
GOOGLE_BENCHMARK_VERSION=v1.5.2

main(){
    if [ $UBUNTU_VERSION == "16.04" ]; then
        install_google_benchmark
    fi
}

install_google_benchmark() {
    cd $SRC_PATH
    # clone google-benchmark if directory does not already exist, or pull
    if [ ! -d benchmark ]; then
        git clone https://github.com/google/benchmark.git
	git clone https://github.com/google/googletest.git benchmark/googletest
    else
    	cd benchmark
    	git checkout master
    	git pull
    	cd ..
    fi

    # go into benchmark repo and prepare for build
    cd benchmark
    git checkout tags/${GOOGLE_BENCHMARK_VERSION}
    
    # compile and install
    cmake -E make_directory "build"
    cmake -E chdir "build" cmake -DCMAKE_BUILD_TYPE=Release ../
    cmake --build "build" --config Release

    #test if it's successfully
    #cmake -E chdir "build" ctest --build-config Release

    echo "benchmark has been installed successfully if there's no error"
}


# MAIN
main
