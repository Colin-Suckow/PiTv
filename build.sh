#!/bin/bash

VENV_DIR=".venv"

# Check if the virtual environment directory exists
if [ ! -d "$VENV_DIR" ]; then
    echo "Virtual environment not found. Run setup.sh to create a new one..."
    exit 1
fi

# Activate the virtual environment
source "$VENV_DIR/bin/activate"

cd build

kas-container build ../kas-project.yaml || exit 1

# IMAGE_BASENAME in pitv-base.bb is "pitv", and meta-raspberrypi names images
# pitv-<machine>.rootfs.wic.bz2 with a companion .wic.bmap for bmaptool.
WIC=$(ls -t build/tmp/deploy/images/*/pitv-*.wic.bz2 2>/dev/null | head -n1)
BMAP=$(ls -t build/tmp/deploy/images/*/pitv-*.wic.bmap 2>/dev/null | head -n1)
if [ -n "$WIC" ]; then
    cp -f "$WIC"  ./pitv.wic.bz2
    cp -f "$BMAP" ./pitv.wic.bmap
    echo "Image available at: build/pitv.wic.bz2"
    echo "Flash with:  sudo bmaptool copy build/pitv.wic.bz2 /dev/sdX"
    echo "         or: bzcat build/pitv.wic.bz2 | sudo dd of=/dev/sdX bs=4M status=progress"
else
    echo "Warning: no .wic.bz2 image found under build/tmp/deploy/images/" >&2
fi
