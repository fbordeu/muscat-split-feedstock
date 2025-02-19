set -ex

BUILD_CONFIG=Release
BUILD_DIR=cmakeBuild${PY_VER}

mkdir -p ${BUILD_DIR}

cmake  -DCMAKE_VERBOSE_MAKEFILE=ON  ${CMAKE_ARG} ${Muscat_CUDA_ARGS}        \
-D CMAKE_BUILD_TYPE=${BUILD_CONFIG}            \
-D CMAKE_EXPORT_COMPILE_COMMANDS:BOOL="TRUE"   \
-D Muscat_ENABLE_Mumps=ON                      \
-D Muscat_ENABLE_Python:BOOL=ON                \
-D Muscat_ENABLE_Documentation=OFF             \
-D mmg_DIR:PATH=${PREFIX}/lib/cmake/mmg        \
-D Python_EXECUTABLE="${PYTHON}"               \
-D CMAKE_INSTALL_PREFIX=${PREFIX}              \
-G Ninja                                       \
-B ${PWD}/${BUILD_DIR}                         \
-S .

cmake                   \
--build ${BUILD_DIR}    \
--parallel 16

#ctest                   \
#--test-dir ${BUILD_DIR} \
#--output-on-failure     \
#--parallel 16

cmake --install ${BUILD_DIR}
