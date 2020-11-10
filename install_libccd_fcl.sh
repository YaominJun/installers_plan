#!/bin/bash
set -e  # exit on first error
DIR=/tmp

main() {
  install_apt_pkgs
  install_libccd
  sudo ldconfig # load the installd library
  install_fcl
}


install_apt_pkgs() {
  sudo apt-get update
  sudo apt-get -y install liboctomap-dev cmake build-essential gcc g++ libboost-all-dev libeigen3-dev
}

install_libccd() {
  if (ldconfig -p | grep libccd); then
    echo "libccd has been installed."
  else
    echo "Install libccd......"
    cd $DIR && rm -rf libccd
    git clone --branch v2.0 https://github.com/danfis/libccd.git
    cd libccd
    mkdir -p build && cd build
    cmake -G "Unix Makefiles" -DBUILD_SHARED_LIBS=ON -DENABLE_DOUBLE_PRECISION=ON .. > /dev/null
    make && sudo make install
    echo "libccd is installed succesfully."
  fi
}

install_fcl() {
  if (ldconfig -p | grep libfcl); then
    echo "fcl has been installed."
  else
    echo "Install fcl......."
    cd $DIR && rm -rf fcl
    git clone --depth 1 --branch 0.5.0 https://github.com/flexible-collision-library/fcl.git
    cd fcl
    mkdir -p build && cd build
    cmake ..
    make -j4
    sudo -E make install
    echo "fcl is installed successfully."
  fi
}

main
