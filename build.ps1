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

$PLATFORM = "$(uname -s)"
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

$BUILDDIR = "./build-$platf" | Resolve-Path
$DESTDIR = "./archive" | Resolve-Path
$SRCDIR = "./src" | Resolve-Path
$PRJDIR = Get-Location | Resolve-Path

#Set-Location -Path ${BUILDDIR}  
cmake --install-prefix ${PRJDIR} -S ${SRCDIR} -B ${BUILDDIR} 
cmake --build ${BUILDDIR} --target install --config Release
cmake --install ${BUILDDIR}

if ($platf -eq 'win-64'){
  $compress = @{
    Path = Join-Path "${PRJDIR}" "taudem" 
    CompressionLevel = "Fastest"
    DestinationPath = Join-Path "${DESTDIR}" "taudem.zip" 
    Update = $True 
  }
  Compress-Archive @compress
} else {
  tar -czvf ${DESTDIR}/taudem-${platf}.tar.gz ${PRJDIR}/taudem/
}

#Set-Location -Path ${PRJDIR}

#make -j 16 
#make test
#make install
