# Build of TauDEM for Release - archive zip
#
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

mkdir-p "./build-win-64"
mkdir-p "./archive"

$BUILDDIR = "./build-win-64" | Resolve-Path
$DESTDIR = "./archive" | Resolve-Path
$SRCDIR = "./src" | Resolve-Path
$PRJDIR = Get-Location | Resolve-Path

#Set-Location -Path ${BUILDDIR}  

cmake --install-prefix ${PRJDIR} -S ${SRCDIR} -B ${BUILDDIR} 
cmake --build ${BUILDDIR} --target install --config Release

$compress = @{
  Path = Join-Path "${BUILDDIR}" "Release" "*.exe" 
  CompressionLevel = "Fastest"
  DestinationPath = Join-Path "${DESTDIR}" "taudem.zip" 
  Update = $True 

}

Compress-Archive @compress

#Set-Location -Path ${PRJDIR}

#cmake --install . --prefix ${DESTDIR} 


#make -j 16 
#make test
#make install
