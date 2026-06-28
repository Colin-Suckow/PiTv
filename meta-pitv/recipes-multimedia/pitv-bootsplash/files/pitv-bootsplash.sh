#!/bin/sh
# PiTv boot splash: after Plymouth releases the display, play a full-screen
# splash video via KMS/DRM, then let SDDM take over.
set -eu

VIDEO=/usr/share/pitv/splash/boot.mp4

# No video? Exit immediately so SDDM starts without delay.
[ -s "$VIDEO" ] || exit 0

# --vo=drm renders directly to the KMS framebuffer (no GPU/EGL needed).
# Plymouth has already quit by the time we run (After=plymouth-quit-wait),
# so we can acquire the DRM device cleanly.
exec mpv \
    --no-config \
    --really-quiet \
    --fs \
    --no-osc \
    --no-input-default-bindings \
    --input-conf=/dev/null \
    --vo=drm \
    --keep-open=no \
    "$VIDEO"
