#!/usr/bin/env bash
#
# Build of TauDEM for user install in $DESTDIR
#
#PLATFORM=$(echo "$(uname -s)" | tr [:upper:] [:lower:])
#to_lower()

PLATFORM="$(uname -s)"

if [[ $PLATFORM == "Windows_NT" ]]; then
  platf="win-64"
elif [[ $PLATFORM == "Linux" ]]; then
  platf="linux-64"
elif [[ PLATFORM == "Darwin" ]]; then
  platf="osx-64"
  echo "$platf not yet supported"
  exit 0;
fi
echo "Building for $platf"

mkdir -p ./build-$platf
mkdir -p ./archive

BUILDDIR="./build-$platf"
DESTDIR=./archive
SRCDIR=./src
PRJDIR="$(pwd)"

echo "Target build dir is ${BUILDDIR}"

cmake --install-prefix ${PRJDIR} -S ${SRCDIR} -B ${BUILDDIR}
cmake --build ${BUILDDIR} --target install --config Release
cmake --install ${BUILDDIR}

if [[ $platf == "win-64" ]]; then
  zip -r ${DESTDIR}/taudem-${platf}.zip ${PRJDIR}/taudem/
else
  tar -czvf ${DESTDIR}/taudem-${platf}.tar.gz ${PRJDIR}/taudem/ 
fi


#make -j 16 
#make test
#make install
