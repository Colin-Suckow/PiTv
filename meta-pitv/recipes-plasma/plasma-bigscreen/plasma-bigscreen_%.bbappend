# plasma-bigscreen CMakeLists.txt requires several components that the upstream
# recipe omits from DEPENDS.
DEPENDS += "bluez-qt qtwebengine libsdl3"

# The upstream FILES globs still use old mycroft-branded component names
# (org.kde.plasma.mycroft.bigscreen, org.kde.mycroft.bigscreen.homescreen).
# The installed files now use the rebranded names, so override FILES here.
FILES:${PN} += " \
    ${datadir}/plasma/shells/org.kde.plasma.bigscreen/* \
    ${datadir}/plasma/look-and-feel/org.kde.plasma.bigscreen/* \
    ${datadir}/plasma/plasmoids/org.kde.bigscreen.homescreen/* \
    ${libdir}/qml/org/kde/bigscreen/* \
    ${datadir}/kpackage/genericqml/org.kde.plasma.settings/* \
    ${datadir}/kpackage/kcms/kcm_mediacenter_kdeconnect/* \
    ${datadir}/kpackage/kcms/kcm_mediacenter_bigscreen_settings/* \
    ${datadir}/kpackage/kcms/kcm_mediacenter_audiodevice/* \
    ${datadir}/kpackage/kcms/kcm_mediacenter_wifi/* \
    ${datadir}/wayland-sessions/*.desktop \
    ${datadir}/xsessions/ \
"

# qdbusxml2cpp embeds the full build path in generated adaptor headers
# (biglauncheradaptor.h). This is a known limitation of the tool; skip
# the buildpaths QA check rather than patching every generated file.
INSANE_SKIP:${PN}-src += "buildpaths"
