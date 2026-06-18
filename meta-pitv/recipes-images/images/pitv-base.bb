SUMMARY = "Base image for pitv video player"
LICENSE = "MIT"

IMAGE_LINGUAS = "en-us"

export IMAGE_BASENAME = "pitv"
inherit core-image extrausers

IMAGE_INSTALL += " \
    vim \
    sudo \
    plasma-bigscreen \
    pitv-bootsplash \
"

EXTRA_IMAGE_FEATURES += " \
    ssh-server-dropbear \
    splash \
"

# Use plymouth (not the default psplash) for the boot splash. plymouth
# PROVIDES virtual/psplash, so the "splash" image feature installs these.
SPLASH = "plymouth plymouth-theme-pitv"

EXTRA_USERS_PARAMS = "\
    groupadd pitv; \
    useradd -m -g pitv -d /home/pitv pitv; \
    usermod -P pitv pitv; \
    groupadd wheel; \
    usermod -aG wheel pitv; \
"

# Allow members of the wheel group to run sudo
sudoers_setup() {
    install -d ${IMAGE_ROOTFS}${sysconfdir}/sudoers.d
    echo "%wheel ALL=(ALL) ALL" > ${IMAGE_ROOTFS}${sysconfdir}/sudoers.d/wheel
    chmod 0440 ${IMAGE_ROOTFS}${sysconfdir}/sudoers.d/wheel
}
ROOTFS_POSTPROCESS_COMMAND += "sudoers_setup;"
 
RPI_EXTRA_CONFIG = '\ndtoverlay=vc4-kms-dsi-7inch\ndisable_splash=1\n'

# Hide the kernel's framebuffer raspberry logos for a clean plymouth handoff.
DISABLE_RPI_BOOT_LOGO = "1"