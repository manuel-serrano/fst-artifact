#!/bin/sh
#*=====================================================================*/
#*    serrano/diffusion/article/flt/artifact/scripts/hop.sh            */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Thu Oct  3 08:33:46 2024                          */
#*    Last change :  Fri Nov  8 14:26:26 2024 (serrano)                */
#*    Copyright   :  2024 Manuel Serrano                               */
#*    -------------------------------------------------------------    */
#*    Hop download and installation                                    */
#*=====================================================================*/
package=hop
color=38

. `dirname $0`/versions.sh
. `dirname $0`/common.sh

# download
if [ "$action " = "download " -o "$action " = "all " ]; then
  download_git || exit 1
fi

# software package install
if [ "$action " = "install " -o "$action " = "all " ]; then
  check_dir

  if [ ! -f $installdir/bin/hop ]; then
    if [ ! -f ${downloaddir}/config.status ]; then
      configure --prefix=${installdir} --bigloo=${ROOT}/install/bigloo/bin/bigloo --disable-doc || exit 1
    fi
    make_compile || exit 1
    make_install
  fi
fi
