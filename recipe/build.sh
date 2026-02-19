#!/bin/bash

export CFLAGS="${CFLAGS} -D_GNU_SOURCE"

./configure --prefix=$PREFIX --host=$HOST --build=$BUILD --enable-shared --disable-static
make -j${CPU_COUNT}
if [[ "$CONDA_BUILD_CROSS_COMPILATION" != "1" ]]; then
  make check -j${CPU_COUNT}
fi
make install
