# Build of TauDEM for Release - archive zip
#
function New-FolderIfNot([string]$path)
{
 if(Test-Path -Path $path){
      Write-Host "Directory already exists."
 }
 else{
      New-Item -Path $path -ItemType Directory 
      Write-Host "Directory created successfully."
 }
}

$platf = "win-64"

if ($IsWindows) {
     $platf = 'win-64'
     $nproc = $Env:NUMBER_OF_PROCESSORS
} elseif ($IsLinux) {
     $platf = 'linux-64'
     $nproc = $(nproc)
} elseif ($MacOS) {
     $platf = 'Darwin'
     $nproc = $(nproc)
     Write "Platform not yet supported!"
} 


$Env:CMAKE_BUILD_PARALLEL_LEVEL = $nproc
$Env:CMAKE_GENERATOR = "Ninja"
New-FolderIfNot "./build-$platf"
New-FolderIfNot "./archive"
$PRJ_DIR = Get-Location | Resolve-Path
$BUILD_DIR = "./build-$platf" | Resolve-Path 
$DEST_DIR = "./archive" | Resolve-Path
$SRC_DIR = "./src" | Resolve-Path
$INSTALL_DIR = "${BUILD_DIR}"  
  
Write-Output "Target build dir is ${BUILD_DIR}"
cmake --install-prefix ${INSTALL_DIR} -S ${SRC_DIR} -B ${BUILD_DIR}
cmake --build ${BUILD_DIR} --config Release
cmake --install ${BUILD_DIR} --config Release

Set-Location -Path ${INSTALL_DIR}
if ($platf -eq 'win-64'){
  $compress = @{
    Path = "taudem/" 
    CompressionLevel = "Fastest"
    DestinationPath = Join-Path ${DEST_DIR} "taudem.zip" 
    Update = $True 
  }
  Compress-Archive @compress
} else {
  tar -czvf ${DEST_DIR}/taudem-${platf}.tar.gz taudem/
}

Set-Location ${PRJ_DIR} 

Write-Output "Finished!"
#make -j 16 
#make test
#make install
