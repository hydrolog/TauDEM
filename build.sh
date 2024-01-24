#!/usr/bin/bash
#
# Build of TauDEM for user install in ~/.local prefix
#
rm -rf src/build
mkdir -p src/build
cd src/build && cmake -DCMAKE_INSTALL_PREFIX=~/.local ..
make test
make install
