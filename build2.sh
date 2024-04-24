#!/usr/bin/bash
#
# Build of TauDEM for user install in ~/.local prefix
#
rm -rf src/build2
mkdir -p src/build2
cd src/build2 && cmake -DCMAKE_INSTALL_PREFIX=${HOME}/.local .. 
cmake --build . --target install --config Release
cmake --install .
#make -j 16 
#make test
#make install
