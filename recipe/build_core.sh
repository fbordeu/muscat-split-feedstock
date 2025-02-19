set -ex

BUILD_CONFIG=Release

mkdir cmakeBuild

cmake  -DCMAKE_VERBOSE_MAKEFILE=ON  ${CMAKE_ARG} ${Muscat_CUDA_ARGS}        \
-D CMAKE_BUILD_TYPE=${BUILD_CONFIG}            \
-D CMAKE_EXPORT_COMPILE_COMMANDS:BOOL="TRUE"   \
-D Muscat_ENABLE_Kokkos:BOOL=ON                \
-D Muscat_ENABLE_Python:BOOL=ON                \
-D Muscat_ENABLE_Documentation=OFF             \
-D mmg_DIR:PATH=${PREFIX}/lib/cmake/mmg        \
-D Python_EXECUTABLE="${PYTHON}"               \
-D CMAKE_INSTALL_PREFIX=${PREFIX}              \
-G Ninja                                       \
-B ${PWD}/cmakeBuild                           \
-S .

cmake                 \
--build cmakeBuild    \
--parallel 1

#ctest                  \
#--test-dir cmakeBuild  \
#--output-on-failure    \
#--parallel 2

cmake --install cmakeBuild
