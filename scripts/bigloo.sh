#!/bin/sh
#*=====================================================================*/
#*    serrano/diffusion/article/flt/artifact/scripts/bigloo.sh         */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Thu Oct  3 08:33:46 2024                          */
#*    Last change :  Sat Mar 15 07:19:40 2025 (serrano)                */
#*    Copyright   :  2024-25 Manuel Serrano                            */
#*    -------------------------------------------------------------    */
#*    Bigloo download and installation                                 */
#*=====================================================================*/
package=bigloo
color=33

. `dirname $0`/versions.sh
. `dirname $0`/common.sh

# download
if [ "$action " = "download " -o "$action " = "all " ]; then
  download_git || exit 1
fi

# software package install
if [ "$action " = "install " -o "$action " = "all " ]; then
  check_dir

  if [ ! -f $installdir/bin/bigloo ]; then
    if [ ! -f ${downloaddir}/Makefile.config ]; then
      configure --prefix=${installdir} --heap-tagging || exit 1
    fi
    make_compile || exit 1
    make_install
  fi
fi
