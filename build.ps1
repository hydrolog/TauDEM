# Build of TauDEM for Release - archive zip
#
function mkdir-p([string]$path)
{
 if(Test-Path -Path $path){
      Write-Host "Directory already exists."
 }
 else{
      New-Item -Path $path -ItemType Directory 
      Write-Host "Directory created successfully."
 }
}

$PLATFORM = "$(uname -s)"
$platf = "win-64"
if ($PLATFORM -eq 'Windows_NT') {
     $platf = 'win-64'
} elseif ($PLATFORM -eq 'Linux') {
     $platf = 'linux-64' 
} elseif ($PLATFORM -eq'Darwin') {
     $platf = "osx-64"
     Write-Output "$platform not yet supported"
     Exit 0;
} 

mkdir-p "./build-$platf"
mkdir-p "./archive"
$PRJ_DIR = Get-Location | Resolve-Path
$BUILD_DIR = "${PRJ_DIR}/build-$platf" | Resolve-Path
$DEST_DIR = "${PRJ_DIR}/archive" | Resolve-Path
$SRC_DIR = "${PRJ_DIR}/src" | Resolve-Path
$INSTALL_DIR = ${BUILD_DIR} 

#Set-Location -Path ${BUILDDIR}  
cmake --install-prefix ${BUILD_DIR} -S ${SRC_DIR} -B ${BUILD_DIR} 
cmake --build ${BUILD_DIR} --target install --config Release
cmake --install ${BUILD_DIR}

if ($platf -eq 'win-64'){
  $compress = @{
    Path = Join-Path "${BUILD_DIR}" "taudem" 
    CompressionLevel = "Fastest"
    DestinationPath = Join-Path "${DEST_DIR}" "taudem.zip" 
    Update = $True 
  }
  Compress-Archive @compress
} else {
  tar -czvf ${DEST_DIR}/taudem-${platf}.tar.gz ${BUILD_DIR}/taudem/
}

#Set-Location -Path ${PRJDIR}

#make -j 16 
#make test
#make install
