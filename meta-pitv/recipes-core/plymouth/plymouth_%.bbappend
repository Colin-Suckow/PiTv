# The upstream recipe only enables the DRM renderer on x86/x86-64. On the
# Raspberry Pi's full-KMS (vc4-kms-v3d) display we want it too, otherwise
# plymouth falls back to the framebuffer renderer and can flicker/miss modes.
PACKAGECONFIG:append = " drm"
