set -ex

BUILD_CONFIG=Release

mkdir cmakeBuild

if [[ $target_platform != $build_platform ]]; then
    Python_INCLUDE_DIR="$(python -c 'import sysconfig; print(sysconfig.get_path("include"))')"
    Python_NumPy_INCLUDE_DIR="$(python -c 'import numpy;print(numpy.get_include())')"
    CMAKE_ARGS="${CMAKE_ARGS} -DPython_EXECUTABLE:PATH=${PYTHON}"
    CMAKE_ARGS="${CMAKE_ARGS} -DPython_INCLUDE_DIR:PATH=${Python_INCLUDE_DIR}"
    CMAKE_ARGS="${CMAKE_ARGS} -DPython_NumPy_INCLUDE_DIR=${Python_NumPy_INCLUDE_DIR}"
else
    CMAKE_ARGS="${CMAKE_ARGS} -D Python_EXECUTABLE=${PYTHON}"
fi


cmake  ${CMAKE_ARG}                            \
-D CMAKE_BUILD_TYPE=${BUILD_CONFIG}            \
-D CMAKE_EXPORT_COMPILE_COMMANDS:BOOL="TRUE"   \
-D Muscat_ENABLE_Kokkos:BOOL=ON                \
-D Muscat_ENABLE_Python:BOOL=ON                \
-D Muscat_ENABLE_Documentation=OFF             \
-D mmg_DIR:PATH=${PREFIX}/lib/cmake/mmg        \

-D CMAKE_INSTALL_PREFIX=${PREFIX}              \
-G Ninja                                       \
-B ${PWD}/cmakeBuild                           \
-S .

cmake                 \
--build cmakeBuild    \
--parallel 16

ctest                  \
--test-dir cmakeBuild  \
--output-on-failure    \
--parallel 16

cmake --install cmakeBuild
