setlocal EnableDelayedExpansion

mkdir build
cd build


cmake .. -G "Ninja"                            ^
-D CMAKE_BUILD_TYPE=Release                    ^
-D CMAKE_EXPORT_COMPILE_COMMANDS:BOOL="TRUE"   ^
-D Muscat_ENABLE_Kokkos:BOOL=ON                ^
-D Muscat_ENABLE_Python:BOOL=ON                ^
-D Muscat_ENABLE_Documentation=OFF             ^
-D mmg_DIR:PATH=%PREFIX%/lib/cmake/mmg         ^
-D CMAKE_PREFIX_PATH="%LIBRARY_PREFIX%"        ^
-D CMAKE_INSTALL_LIBDIR="Library/lib"          ^
-D CMAKE_INSTALL_BINDIR="Library/bin"          ^
-D CMAKE_INSTALL_INCLUDEDIR="Library/include"  ^
-D CMAKE_INSTALL_DATAROOTDIR="Library/share"   ^
-D CMAKE_INSTALL_PREFIX="%PREFIX%"


%python% setup.py build_clib
if errorlevel 1 exit 1
%python% -m pip install --no-deps . -vv
if errorlevel 1 exit 1
