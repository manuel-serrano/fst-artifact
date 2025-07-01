#!/bin/sh
package=gambit_nun
color=34

GAMBIT_CONFIGURE_OPTIONS="--enable-single-host --enable-march=native --enable-dynamic-clib -enable-char-size=1"

. `dirname $0`/versions.sh
. `dirname $0`/common.sh

# download
if [ "$action " = "download " -o "$action " = "all " ]; then
  download_git || exit 1
fi

# software package install
if [ "$action " = "install " -o "$action " = "all " ]; then
  check_dir

  if [ ! -f $installdir/bin/gsc ]; then
    if [ ! -f ${downloaddir}/makefile ]; then
      configure --prefix=${installdir} $GAMBIT_CONFIGURE_OPTIONS CC="$CC -D___NAN_BOXING" || exit 1
    fi
    make_compile core || exit 1
    make_install
  fi
fi
