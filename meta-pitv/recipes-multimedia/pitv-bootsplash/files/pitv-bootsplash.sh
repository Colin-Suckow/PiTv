#!/bin/sh
# PiTv boot splash: once the system is up, take the display from plymouth and
# play the splash video full-screen on KMS/DRM, then let the UI take over.
set -eu

VIDEO=/usr/share/pitv/splash/boot.mp4

# No (real) video yet? Leave plymouth showing the PNG and let the normal
# plymouth-quit chain dismiss it when the UI starts. -s == exists & non-empty.
[ -s "$VIDEO" ] || exit 0

# Hand the DRM device over from plymouth, keeping the last frame on screen so
# there's no black flash before mpv draws its first frame.
plymouth quit --retain-splash 2>/dev/null || true

# --vo=gpu/--gpu-context=drm renders straight to KMS with no compositor and
# auto-detects the connected display's mode, so the same file fits both the
# 800x480 touchscreen and a 4K TV (letterboxed, aspect preserved).
exec mpv \
    --no-config \
    --really-quiet \
    --fs \
    --no-osc \
    --no-input-default-bindings \
    --input-conf=/dev/null \
    --vo=gpu \
    --gpu-context=drm \
    --hwdec=auto \
    --keep-open=no \
    "$VIDEO"
