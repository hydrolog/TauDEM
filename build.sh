#!/usr/bin/env bash
#
# Build of TauDEM for user install in $DESTDIR
#
#PLATFORM=$(echo "$(uname -s)" | tr [:upper:] [:lower:])
#to_lower()

PLATFORM="$(uname -s)"
platf="linux-64"
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

PRJ_DIR="$(pwd)"
BUILD_DIR="${PRJ_DIR}/build-$platf"
DEST_DIR="${PRJ_DIR}/archive"
SRC_DIR="${PRJ_DIR}/src"
INSTALL_DIR="${BUILD_DIR}"

echo "Target build dir is ${BUILD}"

cmake --install-prefix ${INSTALL_DIR} -S ${SRC_DIR} -B ${BUILD_DIR}
cmake --build ${BUILD_DIR} --target install --config Release
cmake --install ${BUILD_DIR}

if [[ $platf == "win-64" ]]; then
  zip -r ${DEST_DIR}/taudem-${platf}.zip ${INSTALL_DIR}/taudem/
else
  tar -czvf ${DEST_DIR}/taudem-${platf}.tar.gz ${INSTALL_DIR}/taudem/ 
fi

#make -j 16 
#make test
#make install
