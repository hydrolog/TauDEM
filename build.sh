#!/usr/bin/env bash
#
# Build of TauDEM for user install in ~/.local prefix
#
export DEST_DIR=.
PLATFORM=$(echo "$(uname -s)" | tr [:upper:] [:lower:])
BUILD_DIR=./build-${PLATFORM}
echo "Target build dir is ${BUILD_DIR}"
rm -rf ${BUILD_DIR}
mkdir -p ${BUILD_DIR} && mkdir -p ${DEST_DIR}
cd ${BUILD_DIR}  && cmake -DCMAKE_INSTALL_PREFIX=${DEST_DIR} ../src 
cmake --build . --target install --config Release
cmake --install ${DEST_DIR} --prefix ${DEST_DIR} --config Release  

#make -j 16 
#make test
#make install
