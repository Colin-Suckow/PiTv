FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://kwin-socket-notify"

do_install:append() {
    install -D -m 0755 ${UNPACKDIR}/kwin-socket-notify \
        ${D}${libexecdir}/kwin-socket-notify

    # Drop-in that:
    #   - Adds After=dbus.socket so dbus-send in kwin-socket-notify can connect
    #   - Uses Type=notify so systemd waits for READY=1 from kwin-socket-notify
    #   - Clears WAYLAND_DISPLAY/EGL_PLATFORM so kwin starts as DRM compositor
    #     (not nested under SDDM's Wayland socket, which lives in sddm's runtime dir)
    #   - Replaces ExecStart with kwin-socket-notify, which waits for org.kde.KWin
    #     on the session bus before sending READY=1 — that name is registered in
    #     DBusInterface::DBusInterface() (workspace.cpp:170) after the compositor
    #     backend fully initializes, ensuring Plasma services don't start until
    #     Wayland globals (zwp_linux_dmabuf_v1, xdg_wm_base) are advertised
    install -d ${D}${sysconfdir}/systemd/user/plasma-kwin_wayland.service.d
    printf '[Unit]\nAfter=dbus.socket\n\n[Service]\nType=notify\nNotifyAccess=all\nUnsetEnvironment=WAYLAND_DISPLAY EGL_PLATFORM\nEnvironment=XDG_RUNTIME_DIR=/run/user/1000\nEnvironment=QT_LOGGING_TO_CONSOLE=1\nEnvironment=LC_ALL=C.UTF-8\nExecStart=\nExecStart=${libexecdir}/kwin-socket-notify\n' \
        > ${D}${sysconfdir}/systemd/user/plasma-kwin_wayland.service.d/drm-override.conf
}

FILES:${PN} += " \
    ${libexecdir}/kwin-socket-notify \
    ${sysconfdir}/systemd/user/plasma-kwin_wayland.service.d/drm-override.conf \
"
