#!/bin/bash

export CFLAGS="${CFLAGS} -D_GNU_SOURCE"

if [[ "$target_platform" == "win-64" ]]; then
  export PREFIX=${PREFIX}/Library
  # The m2w64 toolchain sets CC but not CXX; configure defaults CXXCPP
  # to /lib/cpp which doesn't exist on Windows. Explicitly set CXX and CXXCPP.
  export CXX="${HOST}-g++"
  export CXXCPP="${CXX} -E"
fi

# The CHECK_TRAPV macro uses AC_TRY_RUN without a cross-compilation fallback,
# causing configure to error out during cross-compilation. Patch configure to
# skip those runtime checks (defaulting to trapv=no, which is safe).
if [[ "$CONDA_BUILD_CROSS_COMPILATION" == "1" ]]; then
  sed -i.bak 's/as_fn_error \$? "cannot run test program while cross compiling/true "cannot run test program while cross compiling/g' configure
fi

./configure --prefix=$PREFIX --host=$HOST --build=$BUILD --enable-shared --disable-static
make -j${CPU_COUNT}
if [[ "$CONDA_BUILD_CROSS_COMPILATION" != "1" && "$CROSSCOMPILING_EMULATOR" != "" ]]; then
  make check -j${CPU_COUNT}
fi
make install
