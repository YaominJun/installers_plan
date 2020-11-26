#!bin/bash
set -e

# this script only installs the vrep simulator and import `VREP_ROOT` env
# variable to the ~/.bashrc file.

VREP_VERSION="V-REP_PRO_EDU_V3_6_2_Ubuntu16_04"
VREP_DIR_DEFAULT="/home/luyaomin/0Disk/ros_dep/vrep" #the DIR that you download the VREP tar.xz file

main()
{
    install_vrep "$VREP_DIR_DEFAULT" "$VREP_VERSION"
}

# Install
install_vrep()
{
    VREP_INSTALL_DIR="$1"
    INSTALL_VERSION="$2"
    INSTALL_ROOT="$VREP_INSTALL_DIR/$INSTALL_VERSION"
    # Install
    tar -xf V-REP_PRO_EDU_V3_6_2_Ubuntu16_04.tar.xz

    # Link to user's bin
    mkdir -p "$HOME/bin"
    ln -sfn "$INSTALL_ROOT/vrep.sh" "$HOME/bin/vrep"

    # Add VREP_ROOT entry to bashrc
    if(grep -q "VREP_ROOT" ~/.bashrc); then
        echo "Found bashrc entry: VREP_ROOT=$VREP_ROOT"
    else
        echo "export VREP_ROOT=$INSTALL_ROOT" >> ~/.bashrc
    fi

    export VREP_ROOT="$INSTALL_ROOT"
    source ~/.bashrc
}

main
