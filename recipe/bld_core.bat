setlocal EnableDelayedExpansion

mkdir cmakeBuild%PY_VER%
cd cmakeBuild%PY_VER%


cmake .. -G "Ninja"                            ^
-D CMAKE_BUILD_TYPE=Release                    ^
-D CMAKE_EXPORT_COMPILE_COMMANDS:BOOL="TRUE"   ^
-D Muscat_ENABLE_Python:BOOL=ON                ^
-D Muscat_ENABLE_Documentation=OFF             ^
-D mmg_DIR:PATH=%PREFIX%/lib/cmake/mmg         ^
-D Python_EXECUTABLE=%PYTHON%                  ^
-D CMAKE_PREFIX_PATH="%LIBRARY_PREFIX%"        ^
-D CMAKE_INSTALL_LIBDIR="Library/lib"          ^
-D CMAKE_INSTALL_BINDIR="Library/bin"          ^
-D CMAKE_INSTALL_INCLUDEDIR="Library/include"  ^
-D CMAKE_INSTALL_DATAROOTDIR="Library/share"   ^
-D CMAKE_INSTALL_PREFIX="%PREFIX%"             ^
-DLIBXML2_LIBRARY=%PREFIX%\Library\lib\libxml2.lib ^
-DLIBXML2_INCLUDE_DIR=%PREFIX%\Library\include\libxml2 ^
-DZLIB_LIBRARY=%PREFIX%\Library\lib\zlib.lib ^
-DZLIB_INCLUDE_DIR=%PREFIX%\Library\include


cmake                ^
  --build .          ^
  --config Release   ^
  -j 1

cmake                 ^
--install .           ^
--config Release
