set -ex

BUILD_CONFIG=Release

mkdir cmakeBuild

cmake  ${CMAKE_ARG}                            \
-D CMAKE_BUILD_TYPE=${BUILD_CONFIG}            \
-D CMAKE_EXPORT_COMPILE_COMMANDS:BOOL="TRUE"   \
-D Muscat_ENABLE_Kokkos:BOOL=ON                \
-D Muscat_ENABLE_Python:BOOL=ON                \
-D Muscat_ENABLE_Documentation=OFF             \
-D mmg_DIR:PATH=%PREFIX%/lib/cmake/mmg         \
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
