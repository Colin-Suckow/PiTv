#!/bin/bash

# Define the virtual environment directory
VENV_DIR=".venv"

# Check if the virtual environment directory exists
if [ ! -d "$VENV_DIR" ]; then
    echo "Virtual environment not found. Creating a new one..."
    # Create a new virtual environment
    python3 -m venv "$VENV_DIR"
    echo "Virtual environment created successfully."
else
    echo "Virtual environment already exists."
fi

source "$VENV_DIR/bin/activate"

echo "Installing KAS..."
python -m ensurepip --upgrade --default-pip
python -m pip install kas newt

mkdir -p build

# Generate a unique pitv user password for this installation.
# The hash is stored in build/pitv_password.conf and included into
# BitBake's local.conf at build time. build/ is gitignored so this
# password never ends up in version control.
PITV_CONF="build/pitv_password.conf"
if [ ! -f "$PITV_CONF" ]; then
    PITV_PASSWORD=$(openssl rand -base64 18 | tr -d '+/=\n' | head -c 16)
    echo "PITV_USER_PASSWORD = \"$PITV_PASSWORD\"" > "$PITV_CONF"
    echo ""
    echo "============================================================"
    echo "  PiTv: generated pitv user password: $PITV_PASSWORD"
    echo "  Saved to $PITV_CONF — do not share this file."
    echo "============================================================"
    echo ""
else
    echo "PiTv: using existing pitv user password from $PITV_CONF"
fi