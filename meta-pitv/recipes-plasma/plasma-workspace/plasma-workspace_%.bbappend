# Qt 6.12 changed QWaylandDisplay::setLastInputDevice() to take QWaylandSurface*
# instead of QWaylandWindow* as the third argument.
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += "file://0001-appmenu-use-waylandSurface-for-setLastInputDevice.patch"

# plasma-bigscreen's startup script calls
#   startplasma-wayland --exit-with-session=/usr/libexec/startplasma-waylandsession
# but plasma-workspace 6.6.5 doesn't ship this binary yet (added in a later
# upstream release). Provide a minimal shell script: kwin_wayland monitors this
# process and exits when it does. On a TV appliance we never log out, so
# sleeping indefinitely is the correct behaviour.
SRC_URI += "file://startplasma-waylandsession"
FILES:${PN} += "${libexecdir}/startplasma-waylandsession"

do_install:append() {
    install -D -m 0755 ${UNPACKDIR}/startplasma-waylandsession \
        ${D}${libexecdir}/startplasma-waylandsession
}
