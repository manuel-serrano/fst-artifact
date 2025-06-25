#!/bin/sh
#*=====================================================================*/
#*    .../diffusion/article/flt/artifact/scripts/bigloo_fltv.sh        */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Thu Oct  3 08:33:46 2024                          */
#*    Last change :  Tue Jun 24 15:45:47 2025 (serrano)                */
#*    Copyright   :  2024-25 Manuel Serrano                            */
#*    -------------------------------------------------------------    */
#*    Bigloo download and installation                                 */
#*=====================================================================*/
package=bigloo_fltv
color=34

. `dirname $0`/versions.sh
. `dirname $0`/common.sh

# download
if [ "$action " = "download " -o "$action " = "all " ]; then
  download_git || exit 1
  cat $downloaddir/runtime/Include/bigloo.h | \
    sed -e 's/TAG_STRING 7/TAG_VECTOR 7/g' \
	> $downloaddir/runtime/Include/bigloo.h.tmp
  mv $downloaddir/runtime/Include/bigloo.h.tmp $downloaddir/runtime/Include/bigloo.h
fi

# software package install
if [ "$action " = "install " -o "$action " = "all " ]; then
  check_dir

  if [ ! -f $installdir/bin/bigloo ]; then
    if [ ! -f ${downloaddir}/Makefile.config ]; then
      configure $bigloo_configure_opts --prefix=${installdir} --fl-tagging || exit 1
    fi
    make_compile || exit 1
    make_install
  fi
fi
