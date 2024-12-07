#!/bin/bash
# Time-stamp: "2024-12-08 00:32:56 (ywatanabe)"
# File: ./.dotfiles/.bash.d/all/030_apptainer/src/000_enable_fakeroot.sh

apptainer_enable_fakeroot() {
    LOG_FILE="$0.log"
    exec 1> >(tee -a "$LOG_FILE") 2>&1

    usage() {
        echo "Usage: $0 [-h|--help]"
        echo
        echo "Configures fakeroot feature for current user"
        echo
        echo "Options:"
        echo "  -h, --help    Display this help message"
        exit 1
    }

    check_command() {
        if ! command -v $1 &> /dev/null; then
            echo "Error: $1 is not installed"
            exit 1
        fi
    }

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help) usage ;;
            *) echo "Unknown parameter: $1"; usage ;;
        esac
    done

    check_command apptainer

    # Install uidmap
    sudo apt-get update
    sudo apt-get install -y uidmap

    # Configure subuid and subgid
    sudo usermod --add-subuids 100000-165536 $USER
    sudo usermod --add-subgids 100000-165536 $USER

    # Verify mappings
    echo "Verifying subuid/subgid mappings..."
    if ! grep -q $USER /etc/subuid || ! grep -q $USER /etc/subgid; then
        echo "Error: Failed to configure subuid/subgid"
        exit 1
    fi

    # Enable fakeroot
    sudo apptainer config fakeroot --add $USER

    # Verify configuration
    echo "Verifying fakeroot configuration..."
    if ! apptainer config fakeroot --list | grep -q $USER; then
        echo "Error: Failed to enable fakeroot"
        exit 1
    fi

    echo "Fakeroot successfully configured for $USER"
    }

# EOF
