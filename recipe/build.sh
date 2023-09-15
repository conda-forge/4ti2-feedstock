#!/bin/bash

./configure --prefix=$PREFIX --enable-shared --disable-static
make -j${CPU_COUNT}
make check -j${CPU_COUNT}
make install
