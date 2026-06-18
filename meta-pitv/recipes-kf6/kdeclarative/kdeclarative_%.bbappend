# kdeclarative's graphicaleffects component calls qt_add_shaders() (the
# "qtaddshaders" CMake command), which is provided by Qt6 Shader Tools. The
# upstream meta-kf6 recipe depends on qtdeclarative but not qtshadertools, so
# find_package can't locate the macro and do_configure fails with
# 'Unknown CMake command "qtaddshaders"'. Add the missing dependency:
#   qtshadertools        -> Qt6ShaderTools CMake package in the target sysroot
#   qtshadertools-native -> the qsb shader compiler that runs at build time
# Drop this once meta-kf6 adds the dependency upstream.
DEPENDS += "qtshadertools qtshadertools-native"
