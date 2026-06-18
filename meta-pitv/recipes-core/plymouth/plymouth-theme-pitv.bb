SUMMARY = "PiTv plymouth boot splash theme (single centered PNG)"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = " \
    file://pitv.plymouth \
    file://pitv.script \
    file://splash.png \
"

# The script theme renderer lives in the main plymouth package.
RDEPENDS:${PN} = "plymouth"

THEME_DIR = "${datadir}/plymouth/themes/pitv"

do_install() {
    install -d ${D}${THEME_DIR}
    install -m 0644 ${UNPACKDIR}/pitv.plymouth ${D}${THEME_DIR}/
    install -m 0644 ${UNPACKDIR}/pitv.script   ${D}${THEME_DIR}/
    install -m 0644 ${UNPACKDIR}/splash.png    ${D}${THEME_DIR}/

    # Make this the active theme. Plymouth selects the theme that
    # default.plymouth points at; the base plymouth package ships no
    # default, so we own this symlink without conflict.
    install -d ${D}${datadir}/plymouth/themes
    ln -sf pitv/pitv.plymouth ${D}${datadir}/plymouth/themes/default.plymouth
}

FILES:${PN} = " \
    ${THEME_DIR} \
    ${datadir}/plymouth/themes/default.plymouth \
"
