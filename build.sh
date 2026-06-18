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

# Pin kas-container to a version that works with dunfell
export KAS_IMAGE_VERSION="${KAS_IMAGE_VERSION:-4.6}"

kas-container build ../kas-project.yaml || exit 1

# Images built by kas-project.yaml. Each produces its own .wic.xz.
IMAGES="pitv-base"

# Copy the freshly built wic images to the root of the build dir
for IMAGE in $IMAGES; do
    WIC=$(ls -t build/tmp/deploy/images/*/"$IMAGE"-*.wic.xz 2>/dev/null | head -n1)
    if [ -n "$WIC" ]; then
        cp -f "$WIC" "./$IMAGE.wic.xz"
        echo "Image available at: build/$IMAGE.wic.xz"
    else
        echo "Warning: no .wic.xz image found for $IMAGE under tmp/deploy/images/" >&2
    fi
done
