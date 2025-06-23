#!/bin/sh
#*=====================================================================*/
#*    .../diffusion/article/flt/artifact/scripts/bglstone_fltnz.sh     */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Thu Oct  3 08:34:02 2024                          */
#*    Last change :  Sun Mar 16 06:20:57 2025 (serrano)                */
#*    Copyright   :  2024-25 Manuel Serrano                            */
#*    -------------------------------------------------------------    */
#*    bglstone download and installation                               */
#*=====================================================================*/
package=bglstone_fltnz
color=34

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
    (cd $downloaddir; ./configure --bigloo=${rootdir}/bigloo_fltnz/bin/bigloo --bflags="$bglstone_bflags" >> $log 2>&1) || exit 1
  fi
  
  make_compile compile TARGETS=bigloo BENCH=r7rs || exit 1
fi
