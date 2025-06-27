#!/bin/sh
package=bglstone_gambit_2
color=33

. `dirname $0`/versions.sh
. `dirname $0`/common.sh

# download
if [ "$action " = "download " -o "$action " = "all " ]; then
  download_git || exit 1
fi

# install
if [ "$action " = "install " -o "$action " = "all " ]; then
  check_dir

  if [ ! -f ${downloaddir}/Makefile.config ]; then
    rootdir=`dirname ${installdir}`
    (cd $downloaddir; ./configure --gambit=${rootdir}/gambit_2/bin/gsc >> $log 2>&1) || exit 1
  fi
  
  make_compile compile TARGETS=gambit BENCH=r7rs || exit 1
fi
