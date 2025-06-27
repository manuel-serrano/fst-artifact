#!/bin/sh
#*=====================================================================*/
#*    serrano/diffusion/article/flt/artifact/scripts/jsbench.sh        */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Thu Oct  3 08:34:02 2024                          */
#*    Last change :  Wed Mar 12 15:09:55 2025 (serrano)                */
#*    Copyright   :  2024-25 Manuel Serrano                            */
#*    -------------------------------------------------------------    */
#*    jsbench download and installation                                */
#*=====================================================================*/
package=jsbench
color=32

. `dirname $0`/versions.sh
. `dirname $0`/common.sh

# download
if [ "$action " = "download " -o "$action " = "all " ]; then
  download_git || exit 1

  # new entry for hop flt
  cat $downloaddir/tools/engines/hopnew.json | \
    sed -e 's/hopnew/hop.flt/' \
	-e "s|/tmp/HOPNEW/bin/hopc|$ROOT/install/hop_flt/bin/hopc|" \
	> $downloaddir/tools/engines/hop_flt.json
  cat $downloaddir/tools/engines/hopnew.json | \
    sed -e 's/hopnew/hop.nan/' \
	-e "s|/tmp/HOPNEW/bin/hopc|$ROOT/install/hop_nan/bin/hopc|" \
	> $downloaddir/tools/engines/hop_nan.json
  cat $downloaddir/tools/engines/hopnew.json | \
    sed -e 's/hopnew/hop.nun/' \
	-e "s|/tmp/HOPNEW/bin/hopc|$ROOT/install/hop_nun/bin/hopc|" \
	> $downloaddir/tools/engines/hop_nun.json
  cat $downloaddir/tools/engines/hopnew.json | \
    sed -e 's/hopnew/hop.fltlb/' \
	-e "s|/tmp/HOPNEW/bin/hopc|$ROOT/install/hop_fltlb/bin/hopc|" \
	> $downloaddir/tools/engines/hop_fltlb.json
  cat $downloaddir/tools/engines/hopnew.json | \
    sed -e 's/hopnew/hop.fltnz/' \
	-e "s|/tmp/HOPNEW/bin/hopc|$ROOT/install/hop_fltnz/bin/hopc|" \
	> $downloaddir/tools/engines/hop_fltnz.json
  cat $downloaddir/tools/engines/hopnew.json | \
    sed -e 's/hopnew/hop.fltv/' \
	-e "s|/tmp/HOPNEW/bin/hopc|$ROOT/install/hop_fltv/bin/hopc|" \
	> $downloaddir/tools/engines/hop_fltv.json
  cat $downloaddir/tools/engines/hopnew.json | \
    sed -e 's/hopnew/hop.flt1/' \
	-e "s|/tmp/HOPNEW/bin/hopc|$ROOT/install/hop_flt1/bin/hopc|" \
	> $downloaddir/tools/engines/hop_flt1.json
fi

# install
if [ "$action " = "install " -o "$action " = "all " ]; then
  check_dir

  print "   \e[1;${color}mcompile\e[0m $*"
  (cd $downloaddir && ./hopstone.sh --compileonly --hopc=${ROOT}/install/hop/bin/hopc --hop=${ROOT}/install/hop/bin/hop -e hop -e hop_flt -e hop_fltv -e hop_nan -e hop_nun -e hop_fltlb -e hop_fltnz -e hop_flt1 -e nodejs octane jetstream sunspider bglstone) || exit 1
fi
