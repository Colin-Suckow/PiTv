# Enable the DRM/KMS video output + GPU context so mpv can play full-screen at
# boot with no compositor. Upstream only enables these on opengl+x11 builds.
PACKAGECONFIG:append = " drm gbm egl opengl"
