REM SET VSINSTALLDIR="C:\Program Files\Microsoft Visual Studio\2022\Community"
@set "VSINSTALLDIR=C:\Program Files (x86)\Microsoft Visual Studio\2022"
@set MSMPI
REM @call "%VSINSTALLDIR%\Launch-VsDevShell.ps1"

@set "GDAL_DIR=%CONDA_PREFIX%\pixi\envs\windows\Library"
@set "GDAL_INCLUDE_DIR=%GDAL_DIR%\include"
@set "GDAL_LIBRARY_PATH=%GDAL_DIR%\bin\gdal.dll"
@set "GEOS_LIBRARY_PATH=%GDAL_DIR%\bin\geos_c.dll"
@set "LIBDIR=%GDAL_DIR%;%GDAL_DIR%\lib"
@set "GDAL_LIBRARY=%GDAL_LIBRARY_PATH%"
SET CMAKE_BUILD_TYPE="Release"
@set "INCLUDE=%INCLUDE%;%GDAL_INCLUDE_DIR%"
@set "LIB=%LIB%;%LIBDIR%"
