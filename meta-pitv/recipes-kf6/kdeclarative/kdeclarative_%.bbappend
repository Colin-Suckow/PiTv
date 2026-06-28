# kdeclarative's graphicaleffects component uses qt_add_shaders(). The
# versionless qt_add_shaders alias is only registered when
# QT_NO_CREATE_VERSIONLESS_FUNCTIONS is unset. However, ECMQmlModule6.cmake
# sets that flag before calling find_package(Qt6 COMPONENTS Core Qml), and the
# Qml plugin dependency chain pulls in Qt6ShaderToolsTools at that point.  A
# subsequent find_package(Qt6 COMPONENTS ShaderTools) is a no-op because the
# package is already found, so the alias is never registered and cmake fails
# with 'Unknown CMake command "qt_add_shaders"'.
#
# Fix: add the missing sysroot dependencies so cmake can find Qt6ShaderTools,
# and patch the source to use the always-available qt6_add_shaders instead.
DEPENDS += "qtshadertools qtshadertools-native"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += "file://0001-use-qt6-add-shaders-instead-of-versionless-alias.patch"
