# ECMQmlModule6.cmake sets QT_NO_CREATE_VERSIONLESS_FUNCTIONS=ON around its
# internal find_package(Qt6 COMPONENTS Core Qml) call. In a cross-compilation
# build the Qml plugin dependency chain loads Qt6ShaderTools, Qt6DBus, and
# other modules at that point, so cmake marks them as already-found without
# ever registering their versionless aliases (qt_add_shaders,
# qt_add_dbus_interface, ...). Downstream recipes then fail with
# "Unknown CMake command". Remove the guard — it is not needed for correctness.
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += "file://0001-ECMQmlModule6-drop-QT_NO_CREATE_VERSIONLESS_FUNCTIONS.patch"
