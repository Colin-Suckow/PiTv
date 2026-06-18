SUMMARY = "PiTv boot splash video — plays a full-screen video on KMS at boot"
DESCRIPTION = "After plymouth shows the early PNG splash, this service takes \
over the DRM display and plays a splash video full-screen via mpv, then hands \
off to the graphical UI."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = " \
    file://pitv-bootsplash.sh \
    file://pitv-bootsplash.service \
    file://boot.mp4 \
"

inherit systemd

SYSTEMD_SERVICE:${PN} = "pitv-bootsplash.service"
SYSTEMD_AUTO_ENABLE = "enable"

# mpv plays the video on KMS; plymouth shows the PNG until then.
RDEPENDS:${PN} = "mpv plymouth"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${UNPACKDIR}/pitv-bootsplash.sh ${D}${bindir}/pitv-bootsplash

    install -d ${D}${datadir}/pitv/splash
    install -m 0644 ${UNPACKDIR}/boot.mp4 ${D}${datadir}/pitv/splash/boot.mp4

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${UNPACKDIR}/pitv-bootsplash.service ${D}${systemd_system_unitdir}/
}

FILES:${PN} += "${datadir}/pitv/splash"
