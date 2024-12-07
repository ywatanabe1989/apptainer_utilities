#!/bin/bash
# Time-stamp: "2024-12-08 00:32:25 (ywatanabe)"
# File: ./.dotfiles/.bash.d/all/030_apptainer/src/000_install_apptainer.sh

install_apptainer() {
    # Logging
    LOG_FILE="$0.log"
    exec 1> >(tee -a "$LOG_FILE") 2>&1

    usage() {
        echo "Usage: $0 [-h|--help]"
        echo
        echo "Installs Apptainer with its dependencies"
        echo
        echo "Options:"
        echo "  -h, --help    Display this help message"
        exit 1
    }

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help) usage ;;
            *) echo "Unknown parameter: $1"; usage ;;
        esac
    done

    # Dependencies
    sudo apt-get update
    sudo apt-get install -y \
         build-essential \
         libseccomp-dev \
         pkg-config \
         squashfs-tools \
         cryptsetup \
         git \
         golang

    # Install Go
    GOVERSION=1.21.5
    wget https://go.dev/dl/go${GOVERSION}.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go${GOVERSION}.linux-amd64.tar.gz
    rm go${GOVERSION}.linux-amd64.tar.gz

    # Set Go environment
    export PATH=$PATH:/usr/local/go/bin
    export GOPATH=${HOME}/go

    # Get Apptainer
    git clone https://github.com/apptainer/apptainer.git
    cd apptainer

    # Configure and install
    git checkout v1.2.5
    ./mconfig
    make -C builddir
    sudo make -C builddir install

    # Verify installation
    apptainer --version

    # Setup default environment
    mkdir -p $HOME/.apptainer

    echo "Installation completed"
    }

# EOF
