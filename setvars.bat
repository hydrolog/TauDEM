@set VSINSTALLDIR="C:\Program Files\Microsoft Visual Studio\2022\Community"

REM @set MSMPI
REM Resultado do comando set MSMPI nao inclui %CONDA_PREFIX% do ambiente atual
REM
@set "MSMPI_BIN=%CONDA_PREFIX%\Library\bin
@set "MSMPI_INC=%CONDA_PREFIX%\Library\include
@set "MSMPI_LIB64=%CONDA_PREFIX%\Library\lib

@set "GDAL_DIR=%CONDA_PREFIX%\Library"
@set "GDAL_INCLUDE_DIR=%GDAL_DIR%\include"
@set "GDAL_LIBRARY_PATH=%GDAL_DIR%\bin\gdal.dll"
@set "GEOS_LIBRARY_PATH=%GDAL_DIR%\bin\geos_c.dll"
@set "LIBDIR=%GDAL_DIR%;%GDAL_DIR%\lib"
@set "GDAL_LIBRARY=%GDAL_LIBRARY_PATH%"
@set "INCLUDE=%INCLUDE%;%GDAL_INCLUDE_DIR%"
@set "LIB=%LIB%;%LIBDIR%"
@set "CMAKE_BUILD_TYPE=Release"
